<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Model;

use Joomla\CMS\MVC\Model\ListModel;
use Joomla\Database\ParameterType;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Model for the articlestashes list view.
 *
 * @since  1.0
 */
class ArticlestashesModel extends ListModel
{
    /**
     * Constructor.
     *
     * @param   array  $config  An optional associative array of configuration settings.
     *
     * @since   1.6
     */
    public function __construct($config = array())
    {
        if (empty($config['filter_fields'])) {
            $config['filter_fields'] = array(
                    'id', 'a.id',
                    'jdoc_key', 'a.jdoc_key',
                    'manual', 'a.manual',
                    'language', 'a.language',
                    'heading', 'a.heading',
                    'filename', 'a.filename',
                    'state', 'a.state',
            );
        }

        parent::__construct($config);
    }

    /**
     * Method to auto-populate the model state.
     *
     * Note. Calling getState in this method will result in recursion.
     *
     * @param   string  $ordering   An optional ordering field.
     * @param   string  $direction  An optional direction (asc|desc).
     *
     * @return  void
     *
     * @since   1.6
     */
    protected function populateState($ordering = 'a.jdoc_key', $direction = 'asc')
    {
        $search = $this->getUserStateFromRequest($this->context . '.filter.search', 'filter_search');
        $this->setState('filter.search', $search);

        $manual = $this->getUserStateFromRequest($this->context . '.filter.manual', 'filter_manual', 'help');
        $this->setState('filter.manual', $manual);

        $language = $this->getUserStateFromRequest($this->context . '.filter.language', 'filter_language', 'en');
        $this->setState('filter.language', $language);

        $pr = $this->getUserStateFromRequest($this->context . '.filter.pr', 'filter_pr', '');
        $this->setState('filter.pr', $pr);

        // List state information.
        parent::populateState($ordering, $direction);
    }

    /**
     * Method to get a store id based on model configuration state.
     *
     * This is necessary because the model is used by the component and
     * different modules that might need different sets of data or different
     * ordering requirements.
     *
     * @param   string  $id  A prefix for the store id.
     *
     * @return  string  A store id.
     *
     * @since   1.6
     */
    protected function getStoreId($id = '')
    {
        // Compile the store id.
        $id .= ':' . $this->getState('filter.state');
        $id .= ':' . $this->getState('filter.language');
        $id .= ':' . $this->getState('filter.manual');
        $id .= ':' . $this->getState('filter.search');

        return parent::getStoreId($id);
    }

    /**
     * Build an SQL query to load the list data.
     *
     * @return  \Joomla\Database\DatabaseQuery
     *
     * @since   1.6
     */
    protected function getListQuery()
    {
        $user  = $this->getCurrentUser();
        $db    = $this->getDatabase();
        $query = $db->getQuery(true);

        // Select the required fields from the table.
        $query->select(
            $this->getState(
                'list.select',
                [
                        'DISTINCT a.*',
                        $db->quoteName('b.id') . ' AS stash_id'
                        ]
            )
        );
        $query->from($db->quoteName('#__jdm_articles') . ' AS a')
        ->leftjoin($db->quoteName('#__jdm_article_stashes') . ' AS b ON ' . $db->quoteName('a.id') .
            ' = ' . $db->quoteName('b.page_id'));

        // Always filter on English
        $query->where($db->quoteName('a.language') . '= ' . $db->quote('en'));

        // Subqueries to get stash and pr counts
        $language = $this->getState('filter.language');
        if (empty($language)) {
            $language = 'en';
            //Factory::getApplication()->enqueueMessage('No Language!');
        }
        // count the number of stashes and pull requests for this row
        $query->select('(SELECT count(*) FROM ' .
            $db->quoteName('#__jdm_article_stashes') . ' AS c WHERE ' .
            $db->quoteName('c.jdoc_key') . ' = ' .
            $db->quoteName('a.jdoc_key') .
            ' AND ' . $db->quoteName('a.language') . ' = ' .
            $db->quote('en') . ') AS nstashes');
        $query->select('(SELECT count(*) FROM ' .
            $db->quoteName('#__jdm_article_stashes') . ' AS c WHERE ' .
            $db->quoteName('c.jdoc_key') . ' = ' . $db->quoteName('a.jdoc_key') .
            ' AND ' . $db->quoteName('a.language') . ' = ' . $db->quote('en') .
            ' AND ' . $db->quoteName('c.pr') . '> 0) AS nprs');
        // Get the stash id if I have this page stashed.
        $query->select('(SELECT ' . $db->quoteName('c.id') . ' FROM ' .
            $db->quoteName('#__jdm_article_stashes') . ' AS c WHERE ' .
            $db->quoteName('c.user_id') . ' = ' . $user->id .
            ' AND ' . $db->quoteName('c.jdoc_key') . ' = ' .
            $db->quoteName('a.jdoc_key') . ' AND ' . $db->quoteName('c.language') .
            ' = ' . $db->quote($language) . ') AS stash_id');

        // Select by manual.
        $manual = $this->getState('filter.manual');
        if (!empty($manual)) {
            $query->where($db->quoteName('a.manual') . ' = ' . $db->quote($manual));
        }

        // Select only records where there is a pull request.
        $pr = $this->getState('filter.pr');
        if (is_numeric($pr)) {
            if ($pr == 1) {
                $query->where($db->quoteName('b.pr') . ' = 1');
            }
        }

        // Filter by search in key or heading.
        $search = $this->getState('filter.search');

        if (!empty($search)) {
            $search = $db->quote('%' . str_replace(' ', '%', $db->escape(trim($search), true) . '%'));
            $query->where('(' . $db->quoteName('a.jdoc_key') . ' LIKE ' . $search . ' OR ' .
            $db->quoteName('a.heading') . ' LIKE ' . $search . ')');
        }

        // For language other than en find whether a translation exists
        if ($language != 'en') {
            $query->leftjoin($db->quoteName('#__jdm_articles') .
            ' AS d ON ' . $db->quoteName('a.jdoc_key') .
            ' = ' . $db->quoteName('d.jdoc_key') .
            ' AND ' . $db->quoteName('a.manual') .
            ' = ' . $db->quoteName('d.manual') .
            ' AND ' . $db->quoteName('d.language') .
            ' = ' . $db->quote($language))
            ->select($db->quoteName('d.id') . ' AS translation_id');
        }

        // Add the list ordering clause.
        $orderCol  = $this->state->get('list.ordering', $db->quoteName('a.jdoc_key'));
        $orderDirn = $this->state->get('list.direction', 'ASC');

        $query->order($db->escape($orderCol) . ' ' . $db->escape($orderDirn));
        //echo ($query->__tostring());
        return $query;
    }

        /**
     * Get a list of new pages created by the current user.
     * They are in the stashes table but not the articles table.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getNewpages()
    {
        $user  = $this->getCurrentUser();
        $db    = $this->getDatabase();
        $manual = $this->getState('filter.manual');

        $query = $db->getQuery(true);
        $query->select('*')
        ->from($db->quoteName('#__jdm_article_stashes'))
        ->where($db->quoteName('user_id') . ' = ' . $user->id)
        ->where($db->quoteName('page_id') . ' = 0')
        ->where($db->quoteName('manual') . ' = :manual')
        ->bind(':manual', $manual, ParameterType::STRING);
        $db->setQuery($query);
        return $db->loadObjectList();
    }

    /**
     * Get a list of article stashes created by the current user.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getMystashes()
    {
        $user  = $this->getCurrentUser();
        $db    = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select(
            $db->quoteName(
                array
                (
                    'a.id',
                    'a.user_id',
                    'a.page_id',
                    'a.display_title',
                    'a.manual',
                    'a.language',
                    'a.heading',
                    'a.filename',
                    'a.pr'
                )
            )
        )
        ->select($db->quoteName('b.id') . ' AS en_id')
        ->from($db->quoteName('#__jdm_article_stashes') . ' AS a')
        ->leftjoin($db->quoteName('#__jdm_articles') . ' AS b ON ' . $db->quoteName('a.jdoc_key') .
            ' = ' . $db->quoteName('b.jdoc_key'))
        ->where($db->quoteName('a.user_id') . ' = ' . $user->id)
        ->where($db->quoteName('b.language') . ' = ' . $db->quote('en'))
        ->order($db->quoteName('a.id') . ' ASC');
        $db->setQuery($query);
        return $db->loadObjectList();
    }

    /**
     * Get a list of article pull requests.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getPullrequests()
    {
        $db    = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select(
            $db->quoteName(
                array(
                    'a.id',
                    'a.user_id',
                    'a.page_id',
                    'a.jdoc_key',
                    'a.manual',
                    'a.language',
                    'a.heading',
                    'a.filename',
                    'a.display_title',
                    'a.pr'
                )
            )
        )
        ->from($db->quoteName('#__jdm_article_stashes') . ' AS a')
        ->where($db->quoteName('a.pr') . ' = 1')
        ->order($db->quoteName('a.id') . ' ASC');
        $db->setQuery($query);
        return $db->loadObjectList();
    }
}
