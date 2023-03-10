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
class MenuheadingsModel extends ListModel
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
					'manual', 'a.manual',
					'language', 'a.language',
					'heading', 'a.heading',
					'display_title', 'a.display_title',
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
	protected function populateState($ordering = 'a.heading', $direction = 'asc')
	{
		$manual = $this->getUserStateFromRequest($this->context . '.filter.manual', 'filter_manual', 'user', 'string');
		$this->setState('filter.manual', $manual);

		$language = $this->getUserStateFromRequest($this->context . '.filter.language', 'filter_language', 'en', 'string');
		$this->setState('filter.language', $language);

		$search = $this->getUserStateFromRequest($this->context . '.filter.search', 'filter_search');
		$this->setState('filter.search', $search);

		//$published = $this->getUserStateFromRequest($this->context . '.filter.published', 'filter_published', '');
		//$this->setState('filter.published', $published);

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
		$id .= ':' . $this->getState('filter.search');
		//$id .= ':' . $this->getState('filter.published');
		$id .= ':' . $this->getState('filter.manual');
		$id .= ':' . $this->getState('filter.language');

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
		// Create a new query object.
		$db    = $this->getDbo();
		$query = $db->getQuery(true);

		// Select the required fields from the table.
		$query->select(
				$this->getState(
						'list.select',
						'a.*'
						)
				);
		$query->from('#__jdocmanual_menu_headings AS a');

		// Filter by manual
		$manual = $this->getState('filter.manual');
		$query->where('a.manual = :manual')
		->bind(':manual', $manual, ParameterType::STRING);

		// Always filter by English.

		// Filter by language
		$language = $this->getState('filter.language');
		$english = 'en';
		$query->where('a.language = :language')
		->bind(':language', $english, ParameterType::STRING);

		// If not English add a join
		if ($language != 'en') {
			$query->select('(SELECT c.id FROM #__jdocmanual_menu_headings AS c WHERE c.manual = '. $db->quote($manual) . ' AND language = ' . $db->quote($language) . ' AND c.heading = a.heading) AS translation_id');
			$query->select('(SELECT c.display_title FROM #__jdocmanual_menu_headings AS c WHERE c.manual = '. $db->quote($manual) . ' AND language = ' . $db->quote($language) . ' AND c.heading = a.heading) AS translation_display_title');
		}

		// Filter by published state
		/*
		$published = (string) $this->getState('filter.published');

		if (is_numeric($published))
		{
			$query->where($db->quoteName('a.state') . ' = :published');
			$query->bind(':published', $published, ParameterType::INTEGER);
		}
		elseif ($published === '')
		{
			$query->where('(' . $db->quoteName('a.state') . ' = 0 OR ' . $db->quoteName('a.state') . ' = 1)');
		}
		*/

		// Filter by search in title.
		$search = $this->getState('filter.search');

		if (!empty($search))
		{
			$search = $db->quote('%' . str_replace(' ', '%', $db->escape(trim($search), true) . '%'));
			$query->where('(a.heading LIKE ' . $search . ')');
		}
		// Add the list ordering clause.
		$orderCol  = $this->state->get('list.ordering', 'a.heading');
		$orderDirn = $this->state->get('list.direction', 'ASC');

		$query->order($db->escape($orderCol) . ' ' . $db->escape($orderDirn));
		return $query;
	}

}
