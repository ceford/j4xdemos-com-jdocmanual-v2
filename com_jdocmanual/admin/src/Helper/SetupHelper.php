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
		setcookie($name, $value, $offset, $cookie_path, $cookie_domain, $cookie['secure'], true);
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
		$page_path = '';

		// is there a form to work with
		$jform = $app->input->get('jform', array(), 'array');
		if (!empty($jform))
		{
			$manual = $jform['manual'];
			$index_language_code = $jform['index_language_code'];
			$page_language_code = $jform['page_language_code'];
			$page_path = $jform['page_path'];
		}
		else
		{
			// are there cookies to work with
			$manual = $app->input->cookie->get('jdocmanualManual', 'user', 'string');
			$index_language_code = $app->input->cookie->get('jdocmanualIndexLanguageCode', 'en', 'string');
			$page_language_code = $app->input->cookie->get('jdocmanualPageLanguageCode', 'en', 'string');
			$page_path = $app->input->cookie->get('jdocmanualPagePath', '', 'string');
		}
		// $name, $value, $days
		$this->setcookie('jdocmanualManual', $manual, 10);
		$this->setcookie('jdocmanualIndexLanguageCode', $index_language_code, 10);
		$this->setcookie('jdocmanualPageLanguageCode', $page_language_code, 10);
		$this->setcookie('jdocmanualPagePath', $page_path, 10);

		return [$manual, $index_language_code, $page_language_code, $page_path];
	}
}
