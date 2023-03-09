<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Model;

defined('_JEXEC') or die;

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

/**
 * Methods supporting a list of jdocmanual records.
 *
 * @since  1.6
 */
class GfmfilesModel extends ListModel
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
		if (empty($config['filter_fields']))
		{
			$config['filter_fields'] = array(
					'id', 'a.id',
					'state', 'a.state',
					'language', 'a.language',
					'jdoc_key', 'a.jdoc_key',
					'path', 'a.path',
					'filename', 'a.filename',
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

		$language = $this->getUserStateFromRequest($this->context . '.filter.language', 'filter_language', 'en');
		$this->setState('filter.language', $language);

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
		$user = Factory::getUser();
		// Create a new query object.
		$db    = $this->getDbo();
		$query = $db->getQuery(true);

		// Select the required fields from the table.
		$query->select(
				$this->getState(
						'list.select',
						'DISTINCT a.*'
						)
				);
		$query->from('#__jdocmanual_gfmindex AS a');

		// Always filter on English
        $query->where($db->quoteName('a.language') . '= ' . $db->quote('en'));

		// Subqueries to get stash and pr counts
		$language = $this->getState('filter.language');
		if (empty($language)) {
			$language = 'en';
			//Factory::getApplication()->enqueueMessage('No Language!');
		}
		// count the number of stashes and pull requests for this row
		$query->select('(SELECT count(*) FROM #__jdocmanual_stashes AS c WHERE c.jdoc_key = a.jdoc_key AND a.language = ' . $db->quote('en') . ') AS nstashes');
		$query->select('(SELECT count(*) FROM #__jdocmanual_stashes AS c WHERE c.jdoc_key = a.jdoc_key AND a.language = ' . $db->quote('en') . ' AND c.pr > 0) AS nprs');
		// Get the stash id if I have this page stashed.
		$query->select('(SELECT c.id FROM #__jdocmanual_stashes AS c WHERE c.user_id = '. $user->id .' AND c.jdoc_key = a.jdoc_key AND c.language = ' . $db->quote($language) . ') AS stash_id');

		// Filter by search in key or path.
		$search = $this->getState('filter.search');

		if (!empty($search))
		{
			$search = $db->quote('%' . str_replace(' ', '%', $db->escape(trim($search), true) . '%'));
			$query->where('(a.jdoc_key LIKE ' . $search . ' OR a.path LIKE ' . $search . ')');
		}

		// For language other than en find whether a translation exists
		if ($language != 'en') {
			$query->select('(SELECT id FROM #__jdocmanual_gfmindex AS b WHERE a.jdoc_key = b.jdoc_key AND b.language = ' . $db->quote($language) . ') AS translation_id');
		}
		// Add the list ordering clause.
		$orderCol  = $this->state->get('list.ordering', 'a.jdoc_key');
		$orderDirn = $this->state->get('list.direction', 'ASC');

		$query->order($db->escape($orderCol) . ' ' . $db->escape($orderDirn));
		//echo ($query->__tostring());
		return $query;
	}

	public function getMystashes() {
		$user  = Factory::getUser();
		$db    = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select('a.id, a.user_id, a.page_id, a.language, a.pr, a.jdoc_key, a.path, a.filename')
		->select('b.id AS en_id')
		->from('#__jdocmanual_stashes AS a')
		->leftjoin('#__jdocmanual_gfmindex AS b ON a.jdoc_key = b.jdoc_key')
		->where('a.user_id = ' . $user->id)
		->where('b.language = ' . $db->quote('en'))
		->order('id ASC');
		$db->setQuery($query);
		return $db->loadObjectList();
	}
}
