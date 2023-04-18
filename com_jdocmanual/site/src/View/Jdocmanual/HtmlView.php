<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Site\View\Jdocmanual;

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
	protected $manual;
	protected $index_language_code;
	protected $page_language_code;
	protected $menu_page_id;


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
		/** @var JdocmanualModel $model */
		$model               = $this->getModel();
		$this->manuals       = $model->getManuals();
		$this->index_languages     = $model->getLanguages('index');
		$this->page_languages     = $model->getLanguages('page');

		$setuphelper = new SetupHelper;
		list(
			$this->manual,
			$this->index_language_code,
			$this->page_language_code,
			$this->menu_page_id
		) = $setuphelper->setup();

		$page_id = $setuphelper->realid($this->menu_page_id, $this->manual, $this->page_language_code);
		list ($this->display_title, $this->in_this_page, $this->page_content) = $model->getPage($page_id);

		$this->menu          = $model->getMenu($this->manual, $this->index_language_code, $this->menu_page_id);
		$this->source        = $model->getSourceData($this->manual);

		// Check for errors.
		if (count($errors = $this->get('Errors')))
		{
			throw new GenericDataException(implode("\n", $errors), 500);
		}

		parent::display($tpl);
	}
	/**
	 * Add the page title and toolbar.
	 *
	 * @return  void
	 *
	 * @since   1.6
	 */
	protected function addToolbar(): void
	{
		$app = Factory::getApplication();

		ToolbarHelper::title($this->source->title . ' (' . $this->page_language_code . ')', 'book');

		// Get the toolbar object instance
		$toolbar = Toolbar::getInstance('toolbar');

		$dropdown = $toolbar->dropdownButton('select-manual')
		->text('COM_JDOCMANUAL_JDOCMANUAL_MANUAL_SELECT')
		->toggleSplit(false)
		->icon('icon-code-branch')
		->buttonClass('btn btn-outline-primary');

		$childBar = $dropdown->getChildToolbar();

		// ToDo: change to cycle through manuals from params
		foreach ($this->manuals as $manual)
		{
			$icon = '';
			if ($this->manual == $manual->manual)
			{
				$icon = 'icon-check';
			}
			$childBar->standardButton('manual-' . $manual->manual)
			->text($manual->title)
			->buttonClass('set-manual border-bottom')
			->icon($icon)
			->task('display.selectmanual');
		}

		$dropdown = $toolbar->dropdownButton('select-language')
		->text('COM_JDOCMANUAL_JDOCMANUAL_INDEX_LANGUAGE')
		->toggleSplit(false)
		->icon('icon-language')
		->buttonClass('btn btn-outline-primary ms-3');

		$childBar = $dropdown->getChildToolbar();

		foreach ($this->index_languages as $language)
		{
			$icon = '';
			if ($this->index_language_code == $language->code)
			{
				$icon = 'icon-check';
			}
			$childBar->standardButton($language->code)
			->text($language->title)
			->buttonClass('set-language index border-bottom')
			->task('display.setindexlanguage')
			->icon($icon);
		}

		$dropdown = $toolbar->dropdownButton('select-language')
		->text('COM_JDOCMANUAL_JDOCMANUAL_PAGE_LANGUAGE')
		->toggleSplit(false)
		->icon('icon-language')
		->buttonClass('btn btn-outline-primary ms-3');

		$childBar = $dropdown->getChildToolbar();

		foreach ($this->page_languages as $language)
		{
			$icon = '';
			if ($this->page_language_code == $language->code)
			{
				$icon = 'icon-check';
			}
			$childBar->standardButton($language->code)
			->text($language->title)
			->buttonClass('set-language border-bottom')
			->task('display.selectpagelanguage')
			->icon($icon);
		}

		$dropdown = $toolbar->dropdownButton('select-actions')
		->text('COM_JDOCMANUAL_JDOCMANUAL_ACTIONS')
		->toggleSplit(false)
		->icon('icon-ellipsis-h')
		->buttonClass('btn btn-outline-primary ms-3');

		$childBar = $dropdown->getChildToolbar();

		$childBar->linkButton('preview')
		->icon('icon-file-alt')
		->text('COM_JDOCMANUAL_JDOCMANUAL_ORIGINAL')
		->url($this->source->page_url)
		->attributes(['target' => '_blank']);

		echo $toolbar->render();
	}
}
