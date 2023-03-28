<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

\defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Installer\InstallerHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\Database\ParameterType;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use Joomla\CMS\Uri\Uri;

/**
 * Jdocmanual Component Controller
 *
 * @since  4.0.0
 */
class ContentController extends BaseController
{
	protected $app;
	protected $manual;
	protected $item_id;
	protected $page_language_code;

	public function fillpanel()
	{
		$this->manual = $this->app->input->get('manual', 'user', 'string');
		$this->item_id = $this->app->input->get('item_id', '', 'string');
		$page_language_code = $this->app->input->get('page_language_code', 'en', 'string');
		$this->page_language_code = empty($page_language_code) ? 'en' : $page_language_code;

		$error_message = '';
		$db = Factory::getDbo();
		// is the required page already downloaded?
		$query = $db->getQuery(true);
		$query->select('html')
			->from('#__jdocmanual_gfmindex')
			->where('jdoc_key = ' . $db->quote($this->item_id)) //:jdoc_key')
			//->where('manual = ' . $db->quote($this->manual))
			->where('language = :language')
			//->bind(':jdoc_key', $this->item_id, ParameterType::STRING)
			->bind(':language', $this->page_language_code, ParameterType::STRING);
		$db->setQuery($query);
		$content = $db->loadResult();
		// If there is no content from the gfm source in a language other than English.
		if (empty($content)) {
			$query = $db->getQuery(true);
			$query->select('html')
				->from('#__jdocmanual_gfmindex')
				->where('jdoc_key = :jdoc_key')
				->where('manual = ' . $db->quote($this->manual))
				->where('language = ' . $db->quote('en'))
				->bind(':jdoc_key', $this->item_id, ParameterType::STRING);
			$db->setQuery($query);
			$content = $db->loadResult();
			$error_message = '<div class="alert alert-info">';
			$error_message .= "\nThis document was not available in the selected language. This is the English version.\n";
			$error_message .= "</div>\n";
		}
		echo '<div id="scroll-panel">';
		echo $error_message;
		echo $content;
		echo '</div>';
		jexit();
	}
}