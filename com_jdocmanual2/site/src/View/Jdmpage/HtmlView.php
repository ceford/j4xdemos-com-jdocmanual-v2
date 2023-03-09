<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Site\View\Jdmpage;

\defined('_JEXEC') or die;

use Joomla\CMS\Factory;
use Joomla\CMS\Toolbar\Toolbar;
use Joomla\CMS\Toolbar\ToolbarHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\View\GenericDataException;
use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

/**
 * View class for jdocmanual.
 *
 * @since  4.0
 */
class HtmlView extends BaseHtmlView
{
	protected $manual_id;
	protected $index_language_code;
	protected $page_language_code;
	protected $page_path;


	/**
	 * Method to display the view.
	 *
	 * @param   string  $tpl  A template file to load. [optional]
	 *
	 * @return  void
	 *
	 * @since   1.6
	 * @throws  Exception
	 */
	public function display($tpl = null): void
	{
		$this->loadPage();

		parent::display($tpl);
	}

	protected function loadPage()
	{
		$app = Factory::getApplication();
		$db = Factory::getDbo();

		$id = $app->input->get('id', 0, 'int');

		$query = $db->getQuery(true);
		$query->select('language_code, jdoc_key, content')
		->from('#__jdocmanual_pages')
		->where('id = :itemid')
		->bind(':itemid', $id);
		$db->setQuery($query);
		$this->page = $db->loadObject();
	}
}
