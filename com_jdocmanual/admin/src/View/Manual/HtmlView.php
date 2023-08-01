<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\View\Manual;

use Joomla\CMS\Factory;
use Joomla\CMS\Layout\FileLayout;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\View\GenericDataException;
use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
use Joomla\CMS\Toolbar\Toolbar;
use Joomla\CMS\Toolbar\ToolbarHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

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

    protected $plugin_status;

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
        $model = $this->getModel();
        // Check the database has been populated.
        $this->dbisgood = $model->checkDatabase();
        $this->plugin_status = $model->checkplugin();

        if (!empty($this->dbisgood)) {
            $this->manuals       = $model->getManuals();
            $this->index_languages     = $model->getLanguages('index');
            $this->page_languages     = $model->getLanguages('page');

            $setuphelper = new SetupHelper();
            list(
            $this->manual,
            $this->index_language_code,
            $this->page_language_code,
            $this->menu_page_id
            ) = $setuphelper->setup();

            $page_id = $setuphelper->realid(
                $this->menu_page_id,
                $this->manual,
                $this->index_language_code,
                $this->page_language_code
            );
            list ($this->display_title, $this->in_this_page, $this->page_content) = $model->getPage($page_id);


            $this->menu    = $model->getMenu($this->manual, $this->index_language_code, $this->menu_page_id);
            $this->source  = $model->getSourceData($this->manual);

        // Check for errors.
            if (count($errors = $this->get('Errors'))) {
                throw new GenericDataException(implode("\n", $errors), 500);
            }
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

        // Get the toolbar object instance
        $toolbar = Toolbar::getInstance('toolbar');

        if (!empty($this->dbisgood)) {
            ToolbarHelper::title($this->source->title . ' (' . $this->page_language_code . ')', 'book');
            $dropdown = $toolbar->dropdownButton('select-manual')
            ->text('COM_JDOCMANUAL_MANUAL_MANUAL_SELECT')
            ->toggleSplit(false)
            ->icon('icon-code-branch')
            ->buttonClass('btn btn-action');

            $childBar = $dropdown->getChildToolbar();

            foreach ($this->manuals as $manual) {
                $icon = '';
                if ($this->manual == $manual->manual) {
                    $icon = 'icon-check';
                }
                $childBar->standardButton('manual-' . $manual->manual)
                ->text($manual->title)
                ->buttonClass('set-manual')
                ->icon($icon)
                ->task('display.selectmanual');
            }

            $dropdown = $toolbar->dropdownButton('select-language')
            ->text('COM_JDOCMANUAL_MANUAL_INDEX_LANGUAGE')
            ->toggleSplit(false)
            ->icon('icon-language')
            ->buttonClass('btn btn-action');

            $childBar = $dropdown->getChildToolbar();

            foreach ($this->index_languages as $language) {
                $icon = '';
                if ($this->index_language_code == $language->code) {
                    $icon = 'icon-check';
                }
                $childBar->standardButton($language->code)
                ->text($language->title)
                ->buttonClass('set-language index')
                ->task('display.setindexlanguage')
                ->icon($icon);
            }

            $dropdown = $toolbar->dropdownButton('select-language')
            ->text('COM_JDOCMANUAL_MANUAL_PAGE_LANGUAGE')
            ->toggleSplit(false)
            ->icon('icon-language')
            ->buttonClass('btn btn-action');

            $childBar = $dropdown->getChildToolbar();

            foreach ($this->page_languages as $language) {
                $icon = '';
                if ($this->page_language_code == $language->code) {
                    $icon = 'icon-check';
                }
                $childBar->standardButton($language->code)
                ->text($language->title)
                ->buttonClass('set-language')
                ->task('display.selectpagelanguage')
                ->icon($icon);
            }

            $dropdown = $toolbar->dropdownButton('select-actions')
            ->text('COM_JDOCMANUAL_MANUAL_ACTIONS')
            ->toggleSplit(false)
            ->icon('icon-ellipsis-h')
            ->buttonClass('btn btn-action');

            $childBar = $dropdown->getChildToolbar();

            $layout = new FileLayout('toolbar.toggle-joomla-menu', JPATH_COMPONENT_ADMINISTRATOR . '/layouts');
            $childBar->appendButton('Custom', $layout->render([]), 'toggle-joomla-menu');

            $childBar->confirmButton('update-html')
            ->text('COM_JDOCMANUAL_UPDATE_HTML')
            ->buttonClass('update-html')
            ->task('display.updatehtml')
            ->icon('icon-share')
            ->message("Update HTML for this Manual and Language.\n This may take a long time!");
        } else {
            ToolbarHelper::title('Setup Notes', 'book');
        }

        $user  = Factory::getUser();

        if ($user->authorise('core.admin', 'com_jdocmanual') || $user->authorise('core.options', 'com_jdocmanual')) {
            $toolbar->preferences('com_jdocmanual');
        }

        $tmpl = $app->input->getCmd('tmpl');
        if ($tmpl !== 'component') {
            ToolbarHelper::help('jdocmanual', true);
        }
    }
}
