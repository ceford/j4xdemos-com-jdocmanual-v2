<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\View\Gfmfile;

\defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Helper\ContentHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\View\GenericDataException;
use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
use Joomla\CMS\Toolbar\Button\BasicButton;
use Joomla\CMS\Toolbar\Button\ConfirmButton;
use Joomla\CMS\Toolbar\Toolbar;
use Joomla\CMS\Toolbar\ToolbarHelper;
use Joomla\Database\ParameterType;
require JPATH_COMPONENT . '/libraries/vendor/autoload.php';
use League\CommonMark\CommonMarkConverter;
use Jfcherng\Diff\Differ;
use Jfcherng\Diff\Renderer\RendererConstant;
use Jfcherng\Diff\DiffHelper;
use Jfcherng\Diff\Factory\RendererFactory;

/**
 * View to edit a gfmfile.
 *
 * @since  1.6
 */
class HtmlView extends BaseHtmlView
{
	/**
	 * The \JForm object
	 *
	 * @var  \JForm
	 */
	protected $form;

	/**
	 * The active item
	 *
	 * @var  object
	 */
	protected $item;

	/**
	 * The model state
	 *
	 * @var  \JObject
	 */
	protected $state;

	/**
	 * The html rendering of gfm
	 *
	 * @var
	 */
	protected $preview;

	protected $stash;

	/**
	 * Display the view.
	 *
	 * @param   string  $tpl  The name of the template file to parse; automatically searches through the template paths.
	 *
	 * @return  mixed  A string if successful, otherwise an Error object.
	 */
	public function display($tpl = null)
	{
		// Initialise variables.
		$this->form = $this->get('Form');
		$this->item = $this->get('Item');
		$this->state = $this->get('State');

		//$old = file_get_contents('/Users/ceford/git/J4.docs/manuals/help/en/help-screens/start-here.md');
		//$new = file_get_contents('/Users/ceford/Sites/php-diff-6/example/start-here.md');
		$params = ComponentHelper::getParams('com_jdocmanual');
		$basepath = $params->get('gfmfiles_path');

		// Inject the item data into the form
		if (!empty($this->item->id)) {
			if (!empty($this->item->page_id)) {
				$old = file_get_contents($basepath . $this->item->path . $this->item->filename);
			} else {
				// Need to get the original english text.
				// change the path for the new language
				$pattern = '/(.*?\/)\w\w(\/.*)/';
				$test = preg_match($pattern, $this->item->path, $matches);
				if ($test === 1) {
					$path = $matches[1] . 'en' . $matches[2];
				}
				$old = file_get_contents($basepath . $path . $this->item->filename);
			}
			$new = $this->item->markdown_text;
		} elseif (!empty($this->item->page_id)) {
			$old = file_get_contents($basepath . $this->item->path . $this->item->filename);
			$new = $old;
			$this->form->setValue('markdown_text', null, $old);
            Factory::getApplication()->enqueueMessage(Text::_('COM_JDOCMANUAL_GFM_GFMFILE_COPIED'), 'warning');
		} else {
			// Need to get the original english text.
			// change the path for the new language
			$pattern = '/(.*?\/)\w\w(\/.*)/';
			$test = preg_match($pattern, $this->item->path, $matches);
			if ($test === 1) {
				$path = $matches[1] . 'en' . $matches[2];
			}
			$old = file_get_contents($basepath . $path . $this->item->filename);
			$new = '';
			$this->form->setValue('markdown_text', null, $new);
            Factory::getApplication()->enqueueMessage(Text::_('COM_JDOCMANUAL_GFM_GFMFILE_ENGLISH_COPIED'), 'warning');
		}

		// set the source - read only
		$this->form->setValue('source', null, $old);

		// Fill the preview field
		$this->preview = $this->markdown($new);

		// Get a diff - $old and $new must be null
		require_once (JPATH_COMPONENT . '/src/Helper/diffoptions.php');
		$new = preg_replace('~\R~u', "\n", $new);

		$this->diff = DiffHelper::calculate(
			$old,
			$new,
			'SideBySide',
			$diffOptions,
			$rendererOptions,
		);

		// Check for errors.
		if (count($errors = $this->get('Errors'))) {
			throw new GenericDataException(implode("\n", $errors), 500);
		}

		$this->addToolbar();

		return parent::display($tpl);
	}

	/**
	 * Add the page title and toolbar.
	 *
	 * @return  void
	 *
	 * @since   1.6
	 */
	protected function addToolbar()
	{
		$tmpl = Factory::getApplication()->input->getCmd('tmpl');

		Factory::getApplication()->input->set('hidemainmenu', true);

		$isNew = ($this->item->id == 0);

		ToolbarHelper::title($isNew ? Text::_('COM_JDOCMANUAL_GFMFILE_NEW') : Text::_('COM_JDOCMANUAL_GFMFILE_EDIT'), 'code-branch');

		ToolbarHelper::apply('gfmfile.apply');
		ToolbarHelper::save('gfmfile.save');

		if (empty($isNew)) {
			ToolbarHelper::cancel('gfmfile.cancel', 'JTOOLBAR_CLOSE');
		} else {
			ToolbarHelper::cancel('gfmfile.cancel');
		}

		$bar = Toolbar::getInstance();

		$button = (new BasicButton('gfm-delete'))
		->text('JTOOLBAR_DELETE')
		->buttonClass('btn btn-danger')
		->icon('icon-times icon-fw')
		->task('gfmfile.delete');
		$bar->appendButton($button);

		if (!empty($this->item->id)) {
			if (empty($this->item->pr)) {
				$button = (new BasicButton('gfm-pull-request'))
				->text('COM_JDOCMANUAL_GFM_PULL_REQUEST')
				->buttonClass('btn btn-success')
				->icon('icon icon-code-branch')
				->task('gfmfile.pull_request');
				$bar->appendButton($button);
			} else {
				$button = (new BasicButton('gfm-pull-request'))
				->text('COM_JDOCMANUAL_GFM_PULL_REQUEST_CANCEL')
				->buttonClass('btn btn-success')
				->icon('icon icon-code-branch')
				->task('gfmfile.pull_request_cancel');
				$bar->appendButton($button);

				$button = (new ConfirmButton('gfm-commit'))
				->text('COM_JDOCMANUAL_GFM_COMMIT')
				->buttonClass('btn btn-success')
				->icon('icon icon-code-branch')
				->task('gfmfile.commit')
				->message('COM_JDOCMANUAL_GFMFILE_COMMIT_CONFIRM_MESSAGE');
				$bar->appendButton($button);
			}
		}

		ToolbarHelper::divider();

		if ($tmpl !== 'component') {
			ToolbarHelper::help('gfmfile', true);
		}
	}

	protected function markdown($mdfile)
	{
		$converter = new CommonMarkConverter([
			'allow_unsafe_links' => false,
		]);
		return $converter->convert($mdfile);
	}
}


