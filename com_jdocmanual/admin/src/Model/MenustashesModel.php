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
use Joomla\CMS\Language\Associations;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Model\ListModel;
use Joomla\CMS\Plugin\PluginHelper;
use Joomla\CMS\Table\Table;
use Joomla\CMS\Workflow\Workflow;
use Joomla\Component\Content\Administrator\Extension\ContentComponent;
use Joomla\Utilities\ArrayHelper;
use Joomla\Database\ParameterType;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Methods for the list of menu stashes.
 *
 * @since  1.0
 */
class MenustashesModel extends ListModel
{
    /**
     * Constructor.
     *
     * @param   array  $config  An optional associative array of configuration settings.
     *
     * @since   1.6
     * @see     \Joomla\CMS\MVC\Controller\BaseController
     */
    public function __construct($config = array())
    {
        if (empty($config['filter_fields'])) {
            $config['filter_fields'] = array(
                    'id', 'a.id',
                    'manual', 'a.manual',
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
    protected function populateState($ordering = 'a.manual', $direction = 'asc')
    {
        $search = $this->getUserStateFromRequest($this->context . '.filter.search', 'filter_search');
        $this->setState('filter.search', $search);

        $manual = $this->getUserStateFromRequest($this->context . '.filter.manual', 'filter_manual', 'help');
        $this->setState('filter.manual', $manual);

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
                    $db->quoteName('b.id') . ' AS stash_id',
                    'b.user_id'
                ]
            )
        );
        $query->from($db->quoteName('#__jdm_manuals') . ' AS a')
        ->leftjoin(
            $db->quoteName(
                '#__jdm_menu_stashes'
            ) . ' AS b ON ' . $db->quoteName('a.manual') . ' = ' . $db->quoteName('b.manual')
        );

        // Subqueries to get stash and pr counts
        // count the number of stashes and pull requests for this row
        $query->select('(SELECT count(*) FROM ' .
            $db->quoteName('#__jdm_menu_stashes') .
            ' AS c WHERE ' . $db->quoteName('c.manual') . ' = ' .
            $db->quoteName('a.manual') . ') AS nstashes');
        $query->select('(SELECT count(*) FROM ' .
            $db->quoteName('#__jdm_menu_stashes') .
            ' AS c WHERE ' . $db->quoteName('c.manual') . ' = ' .
            $db->quoteName('a.manual') . ' AND ' . $db->quoteName('c.pr') . '> 0) AS nprs');
        // Get the stash id if I have this page stashed.
        $query->select('(SELECT ' . $db->quoteName('c.id') . ' FROM ' .
            $db->quoteName('#__jdm_menu_stashes') . ' AS c WHERE ' .
            $db->quoteName('c.user_id') . ' = ' . $user->id .
            ' AND ' . $db->quoteName('c.id') . ' = ' . $db->quoteName('b.id') .
            ') AS menustash_id');

        // Select by manual.
        $manual = $this->getState('filter.manual');
        if (!empty($manual)) {
        //  $query->where($db->quoteName('a.manual') . ' = ' . $db->quote($manual));
        }

        // Filter by published state
        $query->where($db->quoteName('a.state') . ' = 1');

        // Select only records where there is a pull request.
        $pr = $this->getState('filter.pr');
        if (is_numeric($pr)) {
            if ($pr == 1) {
                $query->where($db->quoteName('a.pr') . ' = 1');
            }
        }

        // Filter by search in key or heading.
        $search = $this->getState('filter.search');

        if (!empty($search)) {
            // nothing to search for?
        }

        // Add the list ordering clause.
        $orderCol  = $this->state->get('list.ordering', $db->quoteName('a.jdoc_key'));
        $orderDirn = $this->state->get('list.direction', 'ASC');

        $query->order($db->escape($orderCol) . ' ' . $db->escape($orderDirn));
        //echo ($query->__tostring());
        return $query;
    }

    /**
     * Get a list of menu stashes created by the current user.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getMystashes()
    {
        $user  = Factory::getUser();
        $db    = $this->getDbo();
        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('a.id', 'a.user_id', 'a.manual', 'a.pr')))
        ->from($db->quoteName('#__jdm_menu_stashes') . ' AS a')
        ->where($db->quoteName('a.user_id') . ' = ' . $user->id)
        ->order($db->quoteName('a.id') . ' ASC');
        $db->setQuery($query);
        return $db->loadObjectList();
    }

    /**
     * Get a list of menu pull requests.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getPullrequests()
    {
        $db    = $this->getDbo();
        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('a.id', 'a.user_id', 'a.manual', 'a.pr')))
        ->from($db->quoteName('#__jdm_menu_stashes') . ' AS a')
        ->where($db->quoteName('a.pr') . ' = 1')
        ->order($db->quoteName('a.id') . ' ASC');
        $db->setQuery($query);
        return $db->loadObjectList();
    }
}
