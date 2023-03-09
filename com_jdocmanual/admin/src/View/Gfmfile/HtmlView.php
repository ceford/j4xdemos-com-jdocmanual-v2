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
use J4xdemos\Component\Jdocmanual\Administrator\Helper\Markdown2html;

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

		// Users/ceford/data/manuals/
		$params = ComponentHelper::getParams('com_jdocmanual');
		$basepath = $params->get('gfmfiles_path');

		// Check that the basepath is not empty - forgotten to enter it on installation.
		if (empty($basepath)) {
            Factory::getApplication()->enqueueMessage(Text::_('COM_JDOCMANUAL_GFMFILES_BASEPATH_MISSING'), 'error');
			return false;
		}

		// Always get the original English version of a file. If it exists!
		$english_markdown_file = $basepath . implode('/', array($this->item->manual, 'en', $this->item->heading, $this->item->filename));
		if (is_file($english_markdown_file)) {
			$original_english = file_get_contents($english_markdown_file);
		} else {
			$original_english = '';
		}
		$this->form->setValue('original_english', null, $original_english);	
		require_once (JPATH_COMPONENT . '/src/Helper/diffoptions.php');

		// If the language is English the Stash is either from the stash record or the original English.
		if ($this->item->language === 'en') {
			// if there is a stash record use the stash content.
			if (!empty($this->item->id)) {
				$stash = $this->item->markdown_text;
				$old = $original_english;
			} else if (!empty($this->item->page_id)) {
				// Get the original English text.
				$stash = $original_english;
				$old = $stash;
	            Factory::getApplication()->enqueueMessage(Text::_('COM_JDOCMANUAL_GFMFILES_GFMFILE_COPIED'), 'warning');
			} else {
				// This must be a new English file.
				$stash = '';
				$old = $stash;
			}
			$new = $stash;
			$this->form->setValue('markdown_text', null, $stash);

			// make the line endings consistent
			$new = preg_replace('~\R~u', "\n", $new);
			$old = preg_replace('~\R~u', "\n", $old);
			// The diff is the difference between the stash and the original.
			$this->diff = DiffHelper::calculate(
				$old,
				$new,
				'SideBySide',
				$diffOptions,
				$rendererOptions,
			);
		} else {
			// Does the translation file exist?
			$translation_markdown_file = $basepath . implode('/', array($this->item->manual, $this->item->language, $this->item->heading, $this->item->filename));
			if (is_file($translation_markdown_file)) {
				$translation_markdown = file_get_contents($translation_markdown_file);
			} else {
				$translation_markdown = '';
			}
			$old = $translation_markdown;

			// Does the stash exist?
			if (!empty($this->item->id)) {
				// Yes so use the stash value.
				$stash = $this->item->markdown_text;
			} else {
				// No so use the original if it exists
				$stash = $translation_markdown;
				if (!empty($stash)) {
					Factory::getApplication()->enqueueMessage(Text::_('COM_JDOCMANUAL_GFMFILES_GFMFILE_COPIED'), 'warning');
				}
			} 
			$new = $stash;
			$this->form->setValue('markdown_text', null, $stash);
		}

		// Fill the preview field.
		if (!empty($old)) {
			// set the source - read only
			$this->form->setValue('source', null, $old);
			$this->preview = Markdown2html::go($new);

			// Get a diff for the repo and stash versions of the current stash.
			// make the line endings consistent
			$new = preg_replace('~\R~u', "\n", $new);
			$old = preg_replace('~\R~u', "\n", $old);

			$this->diff = DiffHelper::calculate(
				$old,
				$new,
				'SideBySide',
				$diffOptions,
				$rendererOptions,
			);
		}

		// If the language is not English get a diff for the current and previous English versions.
		// So the translator will see what has changed.
		if ($this->item->language != 'en') {
			// Get the last two commit hashes of a specific file.
			// git log -n 2 --pretty=format:%H  -- manuals/help/en/articles/articles.md
			// edf40a05aeffe81751fef2b9e5eea0780452c1da
			$repo_item_path = $this->item->manual . '/en/' . $this->item->heading . '/' . $this->item->filename;
			$repopath = str_replace('manuals/', '', $basepath);

			$command = "cd {$repopath}; /usr/bin/git log -n 2 --pretty=format:%H -- manuals/{$repo_item_path};";
			$result = exec($command, $output, $result_code);

			// Show the content of the file at the last commit.
			// git show edf40a05aeffe81751fef2b9e5eea0780452c1da:manuals/help/en/articles/articles.md
			$command = "cd {$repopath}; /usr/bin/git show {$output[0]}:manuals/{$repo_item_path};";
			$result = exec($command, $latest, $result_code);
			$latest = implode("\n", $latest);

			if (!empty($output[1])) {
				// Get the previous commit.
				$command = "cd {$repopath}; /usr/bin/git show {$output[1]}:manuals/{$repo_item_path};";
				$result = exec($command, $previous, $result_code);
				$previous = implode("\n", $previous);
			} else {
				// Make the previous commit the same as the current? Silly?
				$previous = '';
			}

			//var_dump($command);
			// To get the diff of the last commit
            // % git diff HEAD^ HEAD -- manuals/help/en/help-screens/start-here.md
            // Or two commits back:
            // % git diff HEAD^^ HEAD -- manuals/help/en/help-screens/start-here.md
			//$latest = file_get_contents($basepath . implode('/', array($this->item->manual, 'en', $this->item->heading, $this->item->filename)));
			
			// make the line endings consistent
			$new = preg_replace('~\R~u', "\n", $new);
			$old = preg_replace('~\R~u', "\n", $old);
			$this->english_diff = DiffHelper::calculate(
				$previous,
				$latest,
				'SideBySide',
				$diffOptions,
				['detailLevel' => 'word'] +$rendererOptions,
			);
		}

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

		$user  = Factory::getUser();

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

		if (!$isNew) {
			$button = (new BasicButton('gfm-delete'))
			->text('JTOOLBAR_DELETE')
			->buttonClass('btn btn-danger')
			->icon('icon-times icon-fw')
			->task('gfmfile.delete');
			$bar->appendButton($button);
		}

		if (!empty($this->item->id)) {
			if (empty($this->item->pr)) {
				$button = (new BasicButton('gfm-pull-request'))
				->text('COM_JDOCMANUAL_GFMFILES_PULL_REQUEST')
				->buttonClass('btn btn-success')
				->icon('icon icon-code-branch')
				->task('gfmfile.pull_request');
				$bar->appendButton($button);
			} else {
				$button = (new BasicButton('gfm-pull-request'))
				->text('COM_JDOCMANUAL_GFMFILES_PULL_REQUEST_CANCEL')
				->buttonClass('btn btn-success')
				->icon('icon icon-code-branch')
				->task('gfmfile.pull_request_cancel');
				$bar->appendButton($button);

				if ($user->authorise('core.create', 'com_jdocmanual'))
				{
					$button = (new BasicButton('gfm-commit'))
					->text('COM_JDOCMANUAL_GFMFILES_COMMIT')
					->buttonClass('btn btn-success')
					->icon('icon icon-code-branch');
					//->task('gfmfile.commit')
					//->message('COM_JDOCMANUAL_GFMFILE_COMMIT_CONFIRM_MESSAGE');
					$bar->appendButton($button);
				}
			}
		}

		ToolbarHelper::divider();

		if ($tmpl !== 'component') {
			ToolbarHelper::help('gfmfile', true);
		}
	}
}


