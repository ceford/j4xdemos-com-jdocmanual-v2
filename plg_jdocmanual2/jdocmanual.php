<?php

/**
 * @package     Joomla.Plugin
 * @subpackage  Finder.Jdocmanual
 *
 * @copyright   (C) 2011 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt

 * @phpcs:disable PSR1.Classes.ClassDeclaration.MissingNamespace
 */

defined('_JEXEC') or die;

use Joomla\CMS\Categories\Categories;
use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Table\Table;
use Joomla\Component\Content\Site\Helper\RouteHelper;
use Joomla\Component\Finder\Administrator\Indexer\Adapter;
use Joomla\Component\Finder\Administrator\Indexer\Helper;
use Joomla\Component\Finder\Administrator\Indexer\Indexer;
use Joomla\Component\Finder\Administrator\Indexer\Result;
use Joomla\Database\DatabaseQuery;
use Joomla\Registry\Registry;

/**
 * Smart Search adapter for com_jdocmanual.
 *
 * @since  2.5
 */
class PlgFinderJdocmanual extends Adapter
{
	/**
	 * The plugin identifier.
	 *
	 * @var    string
	 * @since  2.5
	 */
	protected $context = 'Jdocmanual';

	/**
	 * The extension name.
	 *
	 * @var    string
	 * @since  2.5
	 */
	protected $extension = 'com_jdocmanual';

	/**
	 * The sublayout to use when rendering the results.
	 *
	 * @var    string
	 * @since  2.5
	 */
	protected $layout = 'jdmpage';

	/**
	 * The type of content that the adapter indexes.
	 *
	 * @var    string
	 * @since  2.5
	 */
	protected $type_title = 'Jdocmanual';

	/**
	 * The table name.
	 *
	 * @var    string
	 * @since  2.5
	 */
	protected $table = '#__jdocmanual_pages';

	/**
	 * Load the language file on instantiation.
	 *
	 * @var    boolean
	 * @since  3.1
	 */
	protected $autoloadLanguage = true;

	/**
	 * Method to setup the indexer to be run.
	 *
	 * @return  boolean  True on success.
	 *
	 * @since   2.5
	 */
	protected function setup()
	{
		return true;
	}

	/**
	 * Method to update the item link information when the item category is
	 * changed. This is fired when the item category is published or unpublished
	 * from the list view.
	 *
	 * @param   string   $extension  The extension whose category has been updated.
	 * @param   array    $pks        A list of primary key ids of the content that has changed state.
	 * @param   integer  $value      The value of the state that the content has been changed to.
	 *
	 * @return  void
	 *
	 * @since   2.5
	 */
	public function onFinderCategoryChangeState($extension, $pks, $value)
	{
		// Make sure we're handling com_docmanual categories.
		if ($extension === 'com_jdocmanual') {
			$this->categoryStateChange($pks, $value);
		}
	}

	/**
	 * Method to remove the link information for items that have been deleted.
	 *
	 * @param   string  $context  The context of the action being performed.
	 * @param   Table   $table    A Table object containing the record to be deleted
	 *
	 * @return  void
	 *
	 * @since   2.5
	 * @throws  Exception on database error.
	 */
	public function onFinderAfterDelete($context, $table): void
	{
		if ($context === 'com_jdocmanual.jdocmanual') {
			$id = $table->id;
		} elseif ($context === 'com_finder.index') {
			$id = $table->link_id;
		} else {
			return;
		}

		// Remove item from the index.
		$this->remove($id);
	}

	/**
	 * Smart Search after save jdocmanual method.
	 * Reindexes the link information for a jdocmanual item that has been saved.
	 * It also makes adjustments if the access level of an item or the
	 * category to which it belongs has changed.
	 *
	 * @param   string   $context  The context of the content passed to the plugin.
	 * @param   Table    $row      A Table object.
	 * @param   boolean  $isNew    True if the content has just been created.
	 *
	 * @return  void
	 *
	 * @since   2.5
	 * @throws  Exception on database error.
	 */
	public function onFinderAfterSave($context, $row, $isNew): void
	{
		// We only want to handle jdocmanuals here.
		if ($context === 'com_jdocmanual.jdocmanual' || $context === 'com_jdocmanual.form') {
			// Check if the access levels are different.
			if (!$isNew && $this->old_access != $row->access) {
				// Process the change.
				$this->itemAccessChange($row);
			}

			// Reindex the item.
			$this->reindex($row->id);
		}

		// Check for access changes in the category.
		if ($context === 'com_categories.category') {
			// Check if the access levels are different.
			if (!$isNew && $this->old_cataccess != $row->access) {
				$this->categoryAccessChange($row);
			}
		}
	}

	/**
	 * Smart Search before jdocmanual save method.
	 * This event is fired before the data is actually saved.
	 *
	 * @param   string   $context  The context of the content passed to the plugin.
	 * @param   Table    $row      A Table object.
	 * @param   boolean  $isNew    If the content is just about to be created.
	 *
	 * @return  boolean  True on success.
	 *
	 * @since   2.5
	 * @throws  Exception on database error.
	 */
	public function onFinderBeforeSave($context, $row, $isNew)
	{
		// We only want to handle jdocmanuals here.
		if ($context === 'com_jdocmanual.jdocmanual' || $context === 'com_jdocmanual.form') {
			// Query the database for the old access level if the item isn't new.
			if (!$isNew) {
				$this->checkItemAccess($row);
			}
		}

		// Check for access levels from the category.
		if ($context === 'com_categories.category') {
			// Query the database for the old access level if the item isn't new.
			if (!$isNew) {
				$this->checkCategoryAccess($row);
			}
		}

		return true;
	}

	/**
	 * Method to update the link information for items that have been changed
	 * from outside the edit screen. This is fired when the item is published,
	 * unpublished, archived, or unarchived from the list view.
	 *
	 * @param   string   $context  The context for the content passed to the plugin.
	 * @param   array    $pks      An array of primary key ids of the content that has changed state.
	 * @param   integer  $value    The value of the state that the content has been changed to.
	 *
	 * @return  void
	 *
	 * @since   2.5
	 */
	public function onFinderChangeState($context, $pks, $value)
	{
		// We only want to handle jdocmanuals here.
		if ($context === 'com_jdocmanual.jdocmanual' || $context === 'com_jdocmanual.form') {
			$this->itemStateChange($pks, $value);
		}

		// Handle when the plugin is disabled.
		if ($context === 'com_plugins.plugin' && $value === 0) {
			$this->pluginDisable($pks);
		}
	}

	/**
	 * Method to index an item. The item must be a Result object.
	 *
	 * @param   Result  $item  The item to index as a Result object.
	 *
	 * @return  void
	 *
	 * @since   2.5
	 * @throws  Exception on database error.
	 */
	protected function index(Result $item)
	{
		$item->setLanguage();

		// Check if the extension is enabled.
		if (ComponentHelper::isEnabled($this->extension) === false) {
			return;
		}

		$item->context = 'com_jdocmanual.jdocmanual';

		// Items are always publicly accessible
		$item->access = 1;

		// Initialise the item parameters.
		//$registry = new Registry($item->params);
		//$item->params = clone ComponentHelper::getParams('com_jdocmanual', true);
		//$item->params->merge($registry);

		//$item->metadata = new Registry($item->metadata);

		// Trigger the onContentPrepare event.
		//$item->summary = Helper::prepareContent($item->summary, $item->params, $item);
		//$item->body    = Helper::prepareContent($item->body, $item->params, $item);

		// Create a URL as identifier to recognise items again.
		$item->url = $this->getUrl($item->id, $this->extension, $this->layout);

		// The title contains the Jdocs url
		//$item->url = 'https://docs.joomla.org/' . $item->title;

		//$item->url = $item->title;

		$item->title = str_replace('_', ' ', $item->title);

		// Build the necessary route and path information.
		$item->route = $item->url; //RouteHelper::getArticleRoute($item->slug, $item->catid, $item->language);

		// Translate the state. Items should only be published if the category is published.
		//$item->state = $this->translateState($item->state, $item->cat_state);

		// Add the type taxonomy data.
		$item->addTaxonomy('Type', 'Jdocmanual');

		// Add the language taxonomy data.
		$item->addTaxonomy('Language', $item->language);

		// Index the item.
		$this->indexer->index($item);
	}

	/**
	 * Method to get the SQL query used to retrieve the list of content items.
	 *
	 * @param   mixed  $query  A DatabaseQuery object or null.
	 *
	 * @return  DatabaseQuery  A database object.
	 *
	 * @since   2.5
	 */
	protected function getListQuery($query = null)
	{
		$db = $this->db;

		// Check if we can use the supplied SQL query.
		$query = $query instanceof DatabaseQuery ? $query : $db->getQuery(true)
		->select('a.id, a.jdoc_key AS title, a.content AS summary, a.content AS body')
		->select('a.state')
		->select('a.language_code')
		->select('a.last_update')
		->from('#__jdocmanual_pages AS a');

		return $query;
	}
}
