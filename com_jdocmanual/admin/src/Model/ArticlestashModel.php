<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Model;

use Joomla\CMS\Factory;
use Joomla\CMS\Form\Form;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Model\AdminModel;
use Joomla\Database\ParameterType;
use Joomla\CMS\Table\Table;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Item Model for a single stash record.
 *
 * @since  1.0
 */

class ArticlestashModel extends AdminModel
{
    /**
     * Method to get the record form.
     *
     * @param   array    $data      Data for the form.
     * @param   boolean  $loadData  True if the form is to load its own data (default case), false if not.
     *
     * @return  Form|boolean  A Form object on success, false on failure
     *
     * @since   1.6
     */
    public function getForm($data = array(), $loadData = true)
    {
        // Get the form.
        $form = $this->loadForm(
            'com_jdocmanual.articlestash',
            'articlestash',
            array('control' => 'jform',
            'load_data' => $loadData)
        );

        if (empty($form)) {
            return false;
        }

        return $form;
    }

    /**
     * Method to get a single record.
     *
     * @param   integer  $pk  The id of the primary key.
     *
     * @return  mixed  Object on success, false on failure.
     */
    public function getItem($pk = null)
    {
        // If there is data in the form then use that data. Otherwise...
        $pk = (!empty($pk)) ? $pk : (int) $this->getState($this->getName() . '.id');

        $db = $this->getDatabase();
        // If a stash record exists use the stash record.
        if (!empty($pk)) {
            $query = $db->getQuery(true);
            $query->select('*')
                ->from($db->quoteName('#__jdm_article_stashes'))
                ->where($db->quoteName('id') . ' = :id')
                ->bind(':id', $pk, ParameterType::INTEGER);
            $db->setQuery($query);
            $item = $db->loadObject();
            return $item;
        }

        $app = Factory::getApplication();

        // New stash so get the request variables
        $manual = $app->getUserState('com_jdocmanual.articlestash.manual');
        $language = $app->getUserState('com_jdocmanual.articlestash.language');
        // The ide of the original English document
        $eid = $app->getUserState('com_jdocmanual.articlestash.eid');
        // The id of a translation if it exists
        $trid = $app->getUserState('com_jdocmanual.articlestash.trid');

        // If the language is en and the eid is set use it
        if ($language == 'en' & !empty($eid)) {
            $query = $db->getQuery(true);
            $query->select($db->quoteName('a.id') . ' AS page_id')
            ->select(
                $db->quoteName(
                    array
                    (
                        'a.jdoc_key',
                        'a.manual',
                        'a.language',
                        'a.heading',
                        'a.filename',
                        'a.display_title'
                    )
                )
            )
            ->from($db->quoteName('#__jdm_articles') . ' AS a')
            ->where($db->quoteName('a.id') . ' = :id')
            ->bind(':id', $eid, ParameterType::INTEGER);
            $db->setQuery($query);
            $item = $db->loadObject();
            $item->id = 0;
            $item->markdown_text = '';
            return $item;
        }

        // If a translation exists use it.
        if (!empty($trid)) {
            $query = $db->getQuery(true);
            $query->select($db->quoteName('a.id') . ' AS page_id')
            ->select(
                $db->quoteName(
                    array
                    (
                        'a.jdoc_key',
                        'a.manual',
                        'a.language',
                        'a.heading',
                        'a.filename',
                        'a.display_title'
                    )
                )
            )
            ->from($db->quoteName('#__jdm_articles') . ' AS a')
            ->where($db->quoteName('a.id') . ' = :id')
            ->bind(':id', $trid, ParameterType::INTEGER);
            $db->setQuery($query);
            $item = $db->loadObject();
            $item->id = 0;
            $item->markdown_text = '';
            return $item;
        }

        // Otherwise use the English original.
        if (!empty($eid)) {
            $query = $db->getQuery(true);
            $query->select($db->quoteName('a.id') . ' AS page_id')
            ->select(
                $db->quoteName(
                    array
                    (
                        'a.jdoc_key',
                        'a.manual',
                        'a.language',
                        'a.heading',
                        'a.filename',
                        'a.display_title'
                    )
                )
            )
            ->from($db->quoteName('#__jdm_articles') . ' AS a')
            ->where($db->quoteName('a.id') . ' = :id')
            ->bind(':id', $eid, ParameterType::INTEGER);
            $db->setQuery($query);
            $item = $db->loadObject();
            $item->original_id = $eid;
            $item->page_id = 0;
            $item->id = 0;
            $item->language = $language;
            $item->markdown_text = '';
            return $item;
        }

        // so this must be a new English document.
        $item = new \stdClass();
        $item->page_id = 0;
        $item->manual = $manual;
        $item->language = 'en';
        $item->jdoc_key = '';
        $item->heading = '';
        $item->filename = '';
        $item->display_title = '';
        $item->id = 0;
        return $item;
    }

    public function getStash($language, $jdoc_key)
    {
        $user  = $this->getCurrentUser();
        $db    = $this->getDatabase();

        // Load a stash record if one exists
        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('b.id', 'b.markdown_text')))
            ->from($db->quoteName('#__jdm_article_stashes AS b'))
            ->where($db->quoteName('user_id') . ' = :user_id')
            ->where($db->quoteName('language') . ' = :language')
            ->where($db->quoteName('jdoc_key') . ' = :jdoc_key')
            ->bind(':user_id', $user->id, ParameterType::INTEGER)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':jdoc_key', $jdoc_key, ParameterType::STRING);
        $db->setQuery($query);
        return $db->loadObject();
    }

    /**
     * Method to get the data that should be injected in the form.
     *
     * @return  mixed  The data for the form.
     *
     * @since   1.6
     */
    protected function loadFormData()
    {
        // Check the session for previously entered form data.
        $app = Factory::getApplication();
        $data = $app->getUserState('com_jdocmanual.edit.articlestash.data', array());

        if (empty($data)) {
            $data = $this->getItem();
        }

        return $data;
    }

    /**
     * Method to validate the form data.
     *
     * @param   Form    $form   The form to validate against.
     * @param   array   $data   The data to validate.
     * @param   string  $group  The name of the field group to validate.
     *
     * @return  array|boolean  Array of filtered data if valid, false otherwise.
     *
     * @see     \Joomla\CMS\Form\FormRule
     * @see     JFilterInput
     * @since   3.7.0
     */
    public function validate($form, $data, $group = null)
    {
        $user  = $this->getCurrentUser();

        if (!$user->authorise('core.admin', 'com_jdocmanual')) {
            if (isset($data['rules'])) {
                unset($data['rules']);
            }
        }
        if (empty($data['id'])) {
            if ($this->isduplicate($data)) {
                // do nat save a new duplicate
                return false;
            }
        }

        return parent::validate($form, $data, $group);
    }

    /**
     * Method to save the form data.
     *
     * @param   array  $data  The form data.
     *
     * @return  boolean  True on success.
     *
     * @since   1.6
     */
    public function save($data)
    {
        $user  = $this->getCurrentUser();
        $data['user_id'] = $user->id;
        $table      = $this->getTable();

        $key = $table->getKeyName();
        $pk = (isset($data[$key])) ? $data[$key] : (int) $this->getState($this->getName() . '.id');
        $isNew = true;

        // Allow an exception to be thrown.
        try {
            // Load the row if saving an existing record.
            if ($pk > 0) {
                $table->load($pk);
                $isNew = false;
            }

            // Bind the data.
            if (!$table->bind($data)) {
                $this->setError($table->getError());

                return false;
            }

            // Prepare the row for saving
            $this->prepareTable($table);

            // Check the data.
            if (!$table->check()) {
                $this->setError($table->getError());

                return false;
            }

            // Store the data.
            if (!$table->store()) {
                $this->setError($table->getError());

                return false;
            }

            // Clean the cache.
            $this->cleanCache();
        } catch (\Exception $e) {
            $this->setError($e->getMessage());

            return false;
        }

        if (isset($table->$key)) {
            $this->setState($this->getName() . '.id', $table->$key);
        }

        $this->setState($this->getName() . '.new', $isNew);

        return true;
    }

    /**
     * Check for attempt to save a duplicate.
     *
     * @param array $data   The array of form data.
     *
     * @return  bool
     *
     * @since   1.0
     */
    protected function isduplicate($data)
    {
        $user  = $this->getCurrentUser();
        $db    = $this->getDatabase();

        $query = $db->getQuery(true);
        $query->select($db->quoteName('id'))
            ->from($db->quoteName('#__jdm_article_stashes'))
            ->where($db->quoteName('user_id') . ' = :user_id')
            ->where($db->quoteName('page_id') . ' = :page_id')
            ->where($db->quoteName('language') . ' = :language')
            ->where($db->quoteName('jdoc_key') . ' = :jdoc_key')
            ->where($db->quoteName('heading') . ' = :heading')
            ->where($db->quoteName('manual') . ' = :manual')
            ->bind(':user_id', $user->id, ParameterType::INTEGER)
            ->bind(':page_id', $data['page_id'], ParameterType::INTEGER)
            ->bind(':language', $data['language'], ParameterType::STRING)
            ->bind(':jdoc_key', $data['jdoc_key'], ParameterType::STRING)
            ->bind(':heading', $data['heading'], ParameterType::STRING)
            ->bind(':manual', $data['manual'], ParameterType::STRING);
        $db->setQuery($query);
        $id = $db->loadResult();

        if (!empty($id)) {
            // this would be a duplicate
            $this->setError(Text::_('COM_JDOCMANUAL_ARTICLES_ERROR_DUPLICATE'));
            return true;
        }
        // check also for a valid heading and filenemae.
        // ToDo

        return false;
    }

    /**
     * Method to get a table object, load it if necessary.
     *
     * @param   string  $name     The table name. Optional.
     * @param   string  $prefix   The class prefix. Optional.
     * @param   array   $options  Configuration array for model. Optional.
     *
     * @return  Table  A Table object
     *
     * @since   3.0
     * @throws  \Exception
     */
    public function getTable($name = 'Articlestash', $prefix = 'Table', $options = array())
    {
        if ($table = $this->_createTable($name, $prefix, $options)) {
            return $table;
        }

        throw new \Exception(Text::sprintf('JLIB_APPLICATION_ERROR_TABLE_NAME_NOT_SUPPORTED', $name), 0);
    }
}
