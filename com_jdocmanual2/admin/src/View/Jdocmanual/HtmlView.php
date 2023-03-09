<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\View\Jdocmanual;

\defined('_JEXEC') or die;

use Joomla\CMS\Factory;
use Joomla\CMS\Layout\FileLayout;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\View\GenericDataException;
use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
use Joomla\CMS\Toolbar\Toolbar;
use Joomla\CMS\Toolbar\ToolbarHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

/**
 * View class for jdocmanual.
 *
 * @since  4.0
 */
class HtmlView extends BaseHtmlView
{
	/**
	 * The search tools form
	 *
	 * @var    Form
	 * @since  1.6
	 */
	public $filterForm;

	/**
	 * The active search filters
	 *
	 * @var    array
	 * @since  1.6
	 */
	public $activeFilters = [];

	/**
	 * Category data
	 *
	 * @var    array
	 * @since  1.6
	 */
	protected $categories = [];

	/**
	 * An array of items
	 *
	 * @var    array
	 * @since  1.6
	 */
	protected $items = [];

	/**
	 * The pagination object
	 *
	 * @var    Pagination
	 * @since  1.6
	 */
	protected $pagination;

	/**
	 * The model state
	 *
	 * @var    Registry
	 * @since  1.6
	 */
	protected $state;


	protected $active_manual;

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
			$this->manual_id,
			$this->index_language_code,
			$this->page_language_code,
			$this->page_path
		) = $setuphelper->setup();

		$this->page    = $model->getPage();
		$this->menu    = $model->getMenu($this->manual_id, $this->index_language_code);
		$this->source  = $model->getSourceData($this->manual_id);

		// Check for errors.
		if (count($errors = $this->get('Errors')))
		{
			throw new GenericDataException(implode("\n", $errors), 500);
		}

		$this->addToolbar();

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
		->buttonClass('btn btn-action');

		$childBar = $dropdown->getChildToolbar();

		// ToDo: change to cycle through manuals from params
		foreach ($this->manuals as $manual)
		{
			$icon = '';
			if ($this->manual_id == $manual->id)
			{
				$icon = 'icon-check';
			}
			$childBar->standardButton($manual->id)
			->text($manual->title)
			->buttonClass('set-manual')
			->icon($icon)
			->task('display.selectmanual');
		}

		$dropdown = $toolbar->dropdownButton('select-language')
		->text('COM_JDOCMANUAL_JDOCMANUAL_INDEX_LANGUAGE')
		->toggleSplit(false)
		->icon('icon-language')
		->buttonClass('btn btn-action');

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
			->buttonClass('set-language index')
			->task('display.setindexlanguage')
			->icon($icon);
		}

		$dropdown = $toolbar->dropdownButton('select-language')
		->text('COM_JDOCMANUAL_JDOCMANUAL_PAGE_LANGUAGE')
		->toggleSplit(false)
		->icon('icon-language')
		->buttonClass('btn btn-action');

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
			->buttonClass('set-language')
			->task('display.selectpagelanguage')
			->icon($icon);
		}

		$dropdown = $toolbar->dropdownButton('select-actions')
		->text('COM_JDOCMANUAL_JDOCMANUAL_ACTIONS')
		->toggleSplit(false)
		->icon('icon-ellipsis-h')
		->buttonClass('btn btn-action');

		$childBar = $dropdown->getChildToolbar();

		$layout = new FileLayout('toolbar.toggle-joomla-menu', JPATH_COMPONENT_ADMINISTRATOR . '/layouts');
		$childBar->appendButton('Custom', $layout->render([]), 'toggle-joomla-menu');

		$childBar->linkButton('preview')
		->icon('icon-file-alt')
		->text('COM_JDOCMANUAL_JDOCMANUAL_ORIGINAL')
		->url($this->source->index_url)
		->attributes(['target' => '_blank']);

		$childBar->standardButton('update-page')
		->text(Text::_('COM_JDOCMANUAL_JDOCMANUAL_UPDATE_PAGE'))
		->task('content.update')
		->icon('icon-upload');

		$user  = Factory::getUser();

		if ($user->authorise('core.admin', 'com_jdocmanual') || $user->authorise('core.options', 'com_jdocmanual'))
		{
			$childBar->standardButton('index')
			->text(Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_INDEX'))
			->task('index.fetch')
			->icon('icon-download');

			$toolbar->preferences('com_jdocmanual');
		}

		$tmpl = $app->input->getCmd('tmpl');
		if ($tmpl !== 'component')
		{
			ToolbarHelper::help('jdocmanual', true);
		}
	}
}

