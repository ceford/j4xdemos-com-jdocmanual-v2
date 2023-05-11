<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Model;

defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\MVC\Model\ListModel;
use Joomla\Database\ParameterType;

/**
 * Methods supporting a list of jdocmanual records.
 *
 * @since  1.6
 */
class JdocmanualModel extends ListModel
{

	public function getPage($gfmfile_id)
	{
		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		$query->select($db->quoteName(array('display_title','html')))
		->from($db->quoteName('#__jdocmanual_gfmindex'))
		->where($db->quoteName('id') . ' = :id')
		->bind(':id', $gfmfile_id, ParameterType::INTEGER);
		$db->setQuery($query);
		$row = $db->loadObject();
		if (empty($row)) {
			return array('placeholder', '', 'Please select a document');
		}
		if (empty($row->html)) {
			return array('placeholder', '', 'The html field has not been populated. Select the GFM Files menu.');
		}

		// The commonmark menu position feature does not work.
		// So extract it here from the 'top' position.
		$dom = new \DOMDocument('1.0', 'utf-8');
		// DOMDocument::loadHTML will treat your string as being in ISO-8859-1.
		$dom->loadHTML('<?xml encoding="utf-8" ?>' . $row->html);

		// If there are headings there will be a table of contents
		$xpath = new \DOMXPath($dom);
		$uls = $xpath->query("//ul[@class='table-of-contents']");
		$in_this_page = '';
		if (!empty($uls)) {
			foreach($uls as $ul) {
				$in_this_page = $ul->nodeValue;
				$content = $ul->parentNode->removeChild($ul);
			}
		}
		$content = $dom->saveHTML();
		return array($row->display_title, $in_this_page, $content);
	}

	/**
	 * Populate the index of pages that appears in the left column
	 *
	 * @return string html created by Fetch index
	 */
	public function getMenu($manual, $index_language, $menu_page_id)
	{
		//$app = Factory::getApplication();

		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		$query->select($db->quoteName('menu'))
		->from($db->quoteName('#__jdocmanual_menu'))
		->where($db->quoteName('state') . ' = 1')
		->where($db->quoteName('manual') . ' = :manual')
		->where($db->quoteName('language') . ' = :language')
		->bind(':manual', $manual, ParameterType::STRING)
		->bind(':language', $index_language, ParameterType::STRING)
		->order($db->quoteName('id') . ' desc');
		$db->setQuery($query);
		$menu = $db->loadObject();

		// If not correctly setup - no menus create.
		if (empty($menu) && $index_language == 'en')
		{
			return;
		}
		if (empty($menu) && $index_language != 'en')
		{
			// try again with English
			$query = $db->getQuery(true);
			$query->select($db->quoteName('menu'))
			->from($db->quoteName('#__jdocmanual_menu'))
			->where($db->quoteName('state') . ' = 1')
			->where($db->quoteName('manual') . ' = :manual')
			->where($db->quoteName('language') . ' = ' . $db->quote('en'))
			->bind(':manual', $manual, ParameterType::STRING)
			->order($db->quoteName('id') . ' desc');
			$db->setQuery($query);
			$menu = $db->loadObject();
		}

		// if there is an id set the containing <details> element to open=""
		// get all of the <details> elements
		$pattern = '/<details.*?<\/details>/ms';
		preg_match_all($pattern, $menu->menu, $matches);
		// find the element that is active
		$needle = '&id=' . $menu_page_id . '"';
		$menu->menu = '';
		foreach ($matches[0] as $match) {
			if (strrpos($match, $needle)) {
				$match = str_replace('<details ', '<details open="" ', $match);
			}
			$menu->menu .= $match . "\n";
		}
		// and add a class to the opn li
		$menu->menu = str_replace('<li id="gfmfile-' . $menu_page_id . '"', '<li id="gfmfile-' . $menu_page_id . '" class="gfmfile-active"', $menu->menu);
		return $menu;
	}

	public function getManuals()
	{
		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		$query->select('*')
		->from($db->quoteName('#__jdocmanual_sources'))
		->where($db->quoteName('state') . ' = 1')
		->order($db->quoteName('id'));
		$db->setQuery($query);
		return $db->loadObjectList();
	}

	public function getLanguages($which)
	{
		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		$query->select($db->quoteName(array('id', 'code', 'title')))
		->from($db->quoteName('#__jdocmanual_languages'))
		->where($db->quoteName('state') . ' = 1')
		->where($db->quoteName($which . '_language') . ' = 1')
		->order($db->quoteName('code'));
		$db->setQuery($query);
		return $db->loadObjectList();
	}

	public function getSourceData($id)
	{
		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		$query->select($db->quoteName(array('title', 'index_url', 'page_url')))
			->from($db->quoteName('#__jdocmanual_sources'))
			->where($db->quoteName('manual') . ' = :manual')
			->bind(':manual', $id, ParameterType::STRING);
		$db->setQuery($query);
		$data = $db->loadObject();

		$app = Factory::getApplication();
		$gfmfile_id = $app->input->get('id', '1', 'int');
		$query = $db->getQuery(true);
		$query->select($db->quoteName('jdoc_key'))
			->from($db->quoteName('#__jdocmanual_gfmindex'))
			->where($db->quoteName('id') . ' = :id')
			->bind(':id', $gfmfile_id, ParameterType::INTEGER);
		$db->setQuery($query);
		$jdoc_key = $db->loadResult();
		$data->page_url = $data->page_url . $jdoc_key;

		return $data;
	}
}
