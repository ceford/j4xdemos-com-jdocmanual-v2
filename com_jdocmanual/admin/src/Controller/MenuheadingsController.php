<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\MVC\Controller\AdminController;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use Joomla\Database\ParameterType;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\Buildmenus;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Controller for the Menu Headings list.
 *
 * @since  1.0.0
 */
class MenuheadingsController extends AdminController
{
    /**
     * The prefix to use with controller messages.
     *
     * @var    string
     * @since  1.0
     */
    protected $text_prefix = 'COM_JDOCMANUAL_ARTICLES_STASHES';

    /**
     * Update a heading display_title with Javascript call from Menu Headings list
     *
     * @return string   A message for the calling JavaScript
     *
     * @since 1.0
     */
    public function update()
    {
        Session::checkToken('get') or die('Is your session expired? Try a page reload!'); //|Invalid Token' );
        $app = Factory::getApplication();
        $db = Factory::getContainer()->get('DatabaseDriver');

        $field = $app->input->get('field', '', 'string');
        $display_title = $app->input->get('value', '', 'string');
        $item_id = $app->input->get('item_id', 0, 'int');
        if (empty($item_id)) {
            // If the item it is 0 this must be a new item and there should be an original id.
            $original_id = $app->input->get('original_id', 0, 'int');
            // Check this is really a translation.
            if (empty($original_id)) {
                die('NOT OK: No original id!');
            }
            $language = $app->input->get('language', '', 'string');
            if (empty($language)) {
                die('NOT OK: No language!');
            }

            // Get data from the original id.
            $query = $db->getQuery(true);
            $query->select($db->quoteName(array('manual', 'heading')))
            ->from($db->quoteName('#__jdm_menu_headings'))
            ->where('id = :id')
            ->bind(':id', $original_id, ParameterType::INTEGER);
            $db->setQuery($query);
            $row = $db->loadObject();

            // Make a new entry.
            $query = $db->getQuery(true);
            $query->insert($db->quoteName('#__jdm_menu_headings'))
            ->set($db->quoteName('manual') . ' = :manual')
            ->set($db->quoteName('language') . ' = :language')
            ->set($db->quoteName('heading') . ' = :heading')
            ->set($db->quoteName('display_title') . ' = :display_title')
            ->bind(':manual', $row->manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':heading', $row->heading, ParameterType::STRING)
            ->bind(':display_title', $display_title, ParameterType::STRING);
            $db->setQuery($query);
            $result = $db->execute();
            $last_insert = $db->insertid();
            exit('OK 2:' . $last_insert);
        }
        $query = $db->getQuery(true);
        $query->update($db->quoteName('#__jdm_menu_headings'))
        ->set($db->quoteName('display_title') . ' = :display_title')
        ->where('id = :id')
        ->bind(':display_title', $display_title, ParameterType::STRING)
        ->bind(':id', $item_id, ParameterType::INTEGER);
        $db->setQuery($query);
        $result = $db->execute();
        exit('OK 1: ' . $result);
    }

    /**
     * Build a menu for the selected manual and language
     *
     * @return void   result A message is enqueued.
     *
     * @since 1.0
     */
    public function buildmenus()
    {
        Session::checkToken('post') or die('Is your session expired? Try a page reload!'); //|Invalid Token' );
        // Get some the currently selected manual.
        $manual = $this->app->input->get('filter')['manual'];
        $language = $this->app->input->get('filter')['language'];
        if (empty($language) || empty($manual)) {
            $this->app->enqueueMessage("Result: no action! Either Manual or Language were not set.", 'warning');
        } else {
            $bm = new Buildmenus();
            $msg = $bm->go($manual, $language);
            //$command = "php " . JPATH_ROOT . "/cli/joomla.php jdocmanual:action buildmenus {$manual} {$language}";
            //$result = exec($command, $output, $result_code3);

            $this->app->enqueueMessage('That seemed to work! ' . $msg, 'success');
        }
        $this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=menuheadings', false));
    }

    /**
     * Import the menu headings for all languages.
     *
     * @return void   result A message is enqueued.
     *
     * @since 1.0
     */
    public function import()
    {
        Session::checkToken('post') or die('Is your session expired? Try a page reload!'); //|Invalid Token' );
        $this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=menuheadings', false));

        $gfmfiles_path = ComponentHelper::getComponent('com_jdocmanual')->getParams()->get('gfmfiles_path');

        // Scan the manuals folders.
        $manuals = array_diff(scandir($gfmfiles_path), array('..', '.', '.DS_Store'));
        $count = 0;

        // Truncate the table
        $db = Factory::getContainer()->get('DatabaseDriver');
        try {
            $db->truncateTable('#__jdm_menu_headings');
        } catch (Exception $e) {
            $this->app->enqueueMessage("Result: no action! Failed to truncate table.", 'warning');
                return;
        }

        $columns = $db->quoteName(array('manual', 'language', 'heading', 'display_title'));

        foreach ($manuals as $manual) {
            if (!is_dir($gfmfiles_path . $manual)) {
                continue;
            }

            // Scan the language folders.
            $languages = array_diff(scandir($gfmfiles_path . $manual), array('..', '.', '.DS_Store'));
            if (empty($languages)) {
                $this->app->enqueueMessage("Result: no action! No languages folders.", 'warning');
                return;
            }

            foreach ($languages as $language) {
                if (!is_dir($gfmfiles_path . $manual . '/' . $language)) {
                    continue;
                }
                $query = $db->getQuery(true);
                $query->insert($db->quoteName('#__jdm_menu_headings'));

                // Read in the menu-headings.ini file
                $path = "{$gfmfiles_path}{$manual}/{$language}/menu-headings.ini";
                $menu_headings = file_get_contents($path);
                $lines = preg_split("/((\r?\n)|(\r\n?))/", $menu_headings);

                $values = array();

                foreach ($lines as $line) {
                    if (empty(trim($line))) {
                        continue;
                    }
                    list($key, $value) = explode('=', $line);
                        $array = array(
                        $db->quote($manual),
                        $db->quote($language),
                        $db->quote($key),
                        $db->quote($value),
                        );
                        $values[] = implode(',', $array);
                        $count += 1;
                }
                $query->insert($db->quoteName('#__jdm_menu_headings'));
                $query->columns($columns);
                $query->values($values);
                $db->setQuery($query);
                $db->execute();
            }
        }
        $this->app->enqueueMessage("Result: {$count} headings imported.", 'success');
    }

    /**
     * Export the menu headings for the selected manual and language.
     *
     * @return void   result A message is enqueued.
     *
     * @since 1.0
     */
    public function export()
    {
        Session::checkToken('post') or die('Is your session expired? Try a page reload!'); //|Invalid Token' );

        // Get some the currently selected manual.
        $manual = $this->app->input->get('filter')['manual'];
        $language = $this->app->input->get('filter')['language'];

        if (empty($language) || empty($manual)) {
            $this->app->enqueueMessage("Result: no action! Either Manual or Language were not set.", 'warning');
        } else {
            $db = Factory::getContainer()->get('DatabaseDriver');
            $query = $db->getQuery(true);
            $query->select($db->quoteName(array('heading', 'display_title')))
            ->from($db->quoteName('#__jdm_menu_headings'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = :language')
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->order($db->quoteName('heading'));
            $db->setQuery($query);
            $rows = $db->loadObjectList();

            $gfmfiles_path = ComponentHelper::getComponent('com_jdocmanual')->getParams()->get('gfmfiles_path', ',');
            $contents = '';
            $count = 0;
            foreach ($rows as $row) {
                $contents .= "{$row->heading}={$row->display_title}\n";
                $count += 1;
            }
            $path = $gfmfiles_path . "{$manual}/{$language}/menu-headings.ini";
            file_put_contents($path, $contents);

            $this->app->enqueueMessage(
                "Result: {$count} lines written to [data root]/{$manual}/{$language}/menu-headings.ini.",
                'success'
            );
        }
        $this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=menuheadings', false));
    }
}
