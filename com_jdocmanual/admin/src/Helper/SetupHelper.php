<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Helper;

\defined('_JEXEC') or die;

use Joomla\CMS\Factory;
use Joomla\Database\ParameterType;

class SetupHelper
{
	protected function setcookie($name, $value, $days)
	{
		$app = Factory::getApplication();

		if (!empty($days))
		{
			$offset = time() + $days*24*60*60;
		}
		else
		{
			$offset = 0;
		}
		$cookie_domain = $app->get('cookie_domain', '');
		$cookie_path   = $app->get('cookie_path', '/');
		$cookie = session_get_cookie_params();
		$arr_cookie_options = array (
			'expires' => $offset, 
			'path' => $cookie_path, 
			'domain' => $cookie_domain, // leading dot for compatibility or use subdomain
			'secure' => false,     // or false
			'httponly' => false,    // or false
			'samesite' => 'Strict' // None || Lax  || Strict
			);
		setcookie($name, $value, $arr_cookie_options);
		//setcookie($name, $value, $offset, $cookie_path, $cookie_domain, $cookie['secure'], true);
	}

	/**
	 * Check for form parameters change
	 */
	public function setup()
	{
		$app = Factory::getApplication();

		// use default values
		$manual = 'user';
		$index_language_code = 'en';
		$page_language_code = 'en';
		// is there an id in the query string
		$menu_page_id = $app->input->get('id', 0, 'int');

		// is there a form to work with
		$jform = $app->input->get('jform', array(), 'array');

		if (!empty($menu_page_id)) {
			if ($cookie = $app->input->cookie->get('jdocmanual')) {
				list ($manual, $index_language_code, $page_language_code, $old_page_id) = explode('-', $cookie);
			}
		} else if (!empty($jform))
		{
			$manual = $jform['manual'];
			$index_language_code = $jform['index_language_code'];
			$page_language_code = $jform['page_language_code'];
			$menu_page_id = $jform['menu_page_id'];
		}
		else if ($cookie = $app->input->cookie->get('jdocmanual'))
		{
			// are there cookies to work with
			list ($manual, $index_language_code, $page_language_code, $menu_page_id) = explode('-', $cookie);
		}
		// If menu_page_id is still empty set it to 1 - for very first site visit.
		if (empty($menu_page_id)) {
			$menu_page_id = 1;
		}
		$new_cookie = "{$manual}-{$index_language_code}-{$page_language_code}-{$menu_page_id}";
		// $name, $value, $days
		$this->setCookie('jdocmanual', $new_cookie, 10);

		return [$manual, $index_language_code, $page_language_code, $menu_page_id];
	}

	public function change_of_manual() {
		// change of Manual needs the Itemid set to the first in the list
		// get menu from jdocmanual_menu wher manual=x and language=y then
		// get the very first li e.g. <li id="gfmfile-1"> and use the value
		// by placing it in the cookie.

		$app = Factory::getApplication();
		$jform = $app->input->get('jform', array(), 'array');

		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		$query->select($db->quoteName('menu'))
		->from($db->quoteName('#__jdocmanual_menu'))
		->where($db->quoteName('manual') . ' = :manual')
		->where($db->quoteName('language') . ' = :language')
		->bind(':manual', $jform['manual'], ParameterType::STRING)
		->bind(':language', $jform['page_language_code'], ParameterType::STRING);

		$db->setQuery($query);
		$menu = $db->loadResult();
		$pattern = '/<li id="gfmfile-(\d{1,}).*/';
		$result = preg_match($pattern, $menu, $matches);

		$jform['menu_page_id'] = $matches[1];
		$app->input->set('jform', $jform);
	}

	public function realid($id, $manual = null, $page_language_code = null) {
		// If the index and page languages are different - return the corrected page id.
		if (empty($page_language_code)) {
			$app = Factory::getApplication();
			$cookie = $app->input->cookie->get('jdocmanual');
			if (empty($cookie)) {
				return $id;
			}
			list($manual, $index_language_code, $page_language_code, $menu_page_id) = explode('-', $cookie);
		}
		if ($page_language_code == 'en') {
			return $id;
		}
		$db = Factory::getDbo();
		$query = $db->getQuery(true);

		// get the key
		$query->select($db->quoteName('jdoc_key'))
		->from($db->quoteName('#__jdocmanual_gfmindex'))
		->where($db->quoteName('id') . ' = :id')
		->bind(':id', $id, ParameterType::INTEGER);
		$db->setQuery($query);
		$jdoc_key = $db->loadResult();

		// get the id for the key in the selected page language
		$query = $db->getQuery(true);
		$query->select($db->quoteName('id'))
		->from($db->quoteName('#__jdocmanual_gfmindex'))
		->where($db->quoteName('jdoc_key') . ' = :jdoc_key')
		->where($db->quoteName('manual') . ' = :manual')
		->where($db->quoteName('language') . ' = :language')
		->bind(':jdoc_key', $jdoc_key, ParameterType::STRING)
		->bind(':manual', $manual, ParameterType::STRING)
		->bind(':language', $page_language_code, ParameterType::STRING);
		$db->setQuery($query);
		$new_id = $db->loadResult();

		if (!empty($new_id)) {
			return $new_id;
		}
		return $id;
	}
}
