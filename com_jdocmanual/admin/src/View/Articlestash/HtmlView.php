<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\View\Articlestash;

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

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * View to edit a articlestash.
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
        $app = Factory::getApplication();

        // Users/username/data/manuals/
        $params = ComponentHelper::getParams('com_jdocmanual');
        $basepath = $params->get('gfmfiles_path');

        /**
         * Fields to fill here:
         * - original_english if this is not an English stash
         * - markdown_text
         * - english_diff if this is not an English stash
         * - source
         * - diff or empty message
         * - preview
         */

        // Get the original English from item->manual/en/heading/filename. If it exists!
        $original_english = $this->set_original_english($basepath);

        // Should make the diff parameters into a class with static functions?
        require_once(JPATH_COMPONENT . '/src/Helper/diffoptions.php');

        // If the language is English the Stash is either from the stash record or the original English.
        if ($this->item->language === 'en') {
            $this->set_markdown_english($original_english);
        } else {
            $this->set_markdown($basepath);
        }

        // Fill the preview field.
        if (!empty($this->form->getValue('markdown_text'))) {
            $this->preview = Markdown2html::go($this->form->getValue('markdown_text'));
        }

       // Get a diff for the current and previous English versions.
        $this->get_english_diff($basepath, $diffOptions, $rendererOptions);

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

        ToolbarHelper::title(
            $isNew ? Text::_('COM_JDOCMANUAL_ARTICLE_NEW') : Text::_('COM_JDOCMANUAL_ARTICLE_EDIT'),
            'code-branch'
        );

        ToolbarHelper::apply('articlestash.apply');
        ToolbarHelper::save('articlestash.save');

        if (empty($isNew)) {
            ToolbarHelper::cancel('articlestash.cancel', 'JTOOLBAR_CLOSE');
        } else {
            ToolbarHelper::cancel('articlestash.cancel');
        }

        $bar = Toolbar::getInstance();

        if (!$isNew) {
            $button = (new BasicButton('gfm-delete'))
            ->text('JTOOLBAR_DELETE')
            ->buttonClass('btn btn-danger')
            ->icon('icon-times icon-fw')
            ->task('articlestash.delete');
            $bar->appendButton($button);
        }

        if (!empty($this->item->id)) {
            if (empty($this->item->pr)) {
                $button = (new BasicButton('gfm-pull-request'))
                ->text('COM_JDOCMANUAL_ARTICLES_PULL_REQUEST')
                ->buttonClass('btn btn-success')
                ->icon('icon icon-code-branch')
                ->task('articlestash.pullrequest');
                $bar->appendButton($button);
            } else {
                $button = (new BasicButton('gfm-pull-request'))
                ->text('COM_JDOCMANUAL_ARTICLES_PULL_REQUEST_CANCEL')
                ->buttonClass('btn btn-success')
                ->icon('icon icon-code-branch')
                ->task('articlestash.pullrequestcancel');
                $bar->appendButton($button);

                if ($user->authorise('core.create', 'com_jdocmanual')) {
                    $button = (new BasicButton('gfm-commit'))
                    ->text('COM_JDOCMANUAL_ARTICLES_COMMIT')
                    ->buttonClass('btn btn-success')
                    ->icon('icon icon-code-branch')
                    ->task('articlestash.commit');
                    $bar->appendButton($button);
                }
            }
        }

        ToolbarHelper::divider();

        if ($tmpl !== 'component') {
            ToolbarHelper::help('articlestash', true);
        }
    }

    /**
     * Set the markdown_text form field value if language is not English.
     * Also set diff and source fields.
     *
     * @return  void
     *
     * @since   1.0
     */
    protected function set_markdown($basepath) {
        // Does the translation file exist?
        $translation_markdown_file = $basepath .
            implode(
                '/',
                array(
                    $this->item->manual,
                    $this->item->language,
                    $this->item->heading,
                    $this->item->filename
                )
            );
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
                Factory::getApplication()->enqueueMessage(
                    Text::_('COM_JDOCMANUAL_ARTICLES_ARTICLE_COPIED'),
                    'warning'
                );
            }
        }
        $new = $stash;
        $this->form->setValue('markdown_text', null, $stash);
        $this->set_diff($old, $new);
        // Set the source - read only
        $this->form->setValue('source', null, $old);
    }

    /**
     * Set the markdown_text form field value. Also set diff and source fields.
     *
     * @return  void
     *
     * @since   1.0
     */
    protected function set_markdown_english($original_english) {
        // if there is a stash record use the stash content.
        if (!empty($this->item->id)) {
            $stash = $this->item->markdown_text;
            $old = $original_english;
        } elseif (!empty($this->item->page_id)) {
            // Get the original English text.
            $stash = $original_english;
            $old = $stash;
            Factory::getApplication()->enqueueMessage(Text::_('COM_JDOCMANUAL_ARTICLES_ARTICLE_COPIED'), 'warning');
        } else {
            // This must be a new English file.
            $stash = '';
            $old = $stash;
        }
        $new = $stash;
        $this->form->setValue('markdown_text', null, $stash);
        $this->set_diff($old, $new);
        // Set the source - read only
        $this->form->setValue('source', null, $old);
    }

    /**
     * Create a diif between new and old versions of an article.
     *
     * @return  void
     *
     * @since   1.0
     */
    protected function set_diff($old, $new) {
        require(JPATH_COMPONENT . '/src/Helper/diffoptions.php');
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
    }

    /**
     * Set the original English content of a stash.
     *
     * @return  string  The English markdown text.
     *
     * @since   1.0
     */
    protected function set_original_english($basepath) {
        $english_markdown_file = $basepath . implode(
            '/',
            array(
                $this->item->manual,
                'en',
               $this->item->heading,
               $this->item->filename
            )
        );
        if (is_file($english_markdown_file)) {
            $original_english = file_get_contents($english_markdown_file);
        } else {
            $original_english = '';
        }
        $this->form->setValue('original_english', null, $original_english);

        return $original_english;
    }

    /**
     * Set diff between the last two English commits.
     * So a translator will see what has changed.
     * @param string $basepath          The absolute path to the local repository.
     * @param array $diffOptions        The diff option settings
     * @param array $rendererOptions    The diff renderer options.
     *
     * @return void
     *
     * @since   1.0
     */
    protected function get_english_diff($basepath, $diffOptions, $rendererOptions) {
        // Get the last two commit hashes of a specific file.
        // git log -n 2 --pretty=format:%H  -- manuals/help/en/articles/articles.md
        // edf40a05aeffe81751fef2b9e5eea0780452c1da
        $file_path = $basepath . $this->item->manual . '/en/' . $this->item->heading . '/' . $this->item->filename;

        // Set a default value.
        $this->english_diff = '';

        // Check that the item exists - it won't if this is a new article.
        if (!is_file($file_path)) {
            $this->english_diff = Text::_('COM_JDOCMANUAL_ARTICLE_STASH_NEW_NO_ENGLISH_DIFF');
            return;
        }

        $repopath = str_replace('manuals/', '', $basepath);
        $repo_item_path = 'manuals/' . $this->item->manual . '/en/' . $this->item->heading . '/' . $this->item->filename;
        $command = "cd {$repopath}; /usr/bin/git log -n 2 --pretty=format:%H -- {$repo_item_path};";
        $result = exec($command, $output, $result_code);

        // Check the item has been committed - a new file may exist without being committed.
        if (empty($output)) {
            return;
        }

        // Show the content of the file at the last commit.
        // git show edf40a05aeffe81751fef2b9e5eea0780452c1da:manuals/help/en/articles/articles.md
        $command = "cd {$repopath}; /usr/bin/git show {$output[0]}:{$repo_item_path};";
        $result = exec($command, $latest, $result_code);
        $latest = implode("\n", $latest);

        if (!empty($output[1])) {
            // Get the previous commit.
            $command = "cd {$repopath}; /usr/bin/git show {$output[1]}:{$repo_item_path};";
            $result = exec($command, $previous, $result_code);
            $previous = implode("\n", $previous);
        } else {
            // Make the previous commit the same as the current? Silly?
            $previous = '';
        }

        // Make the line endings consistent.
        //$new = preg_replace('~\R~u', "\n", $new);
        //$old = preg_replace('~\R~u', "\n", $old);
        $this->english_diff = DiffHelper::calculate(
            $previous,
            $latest,
            'SideBySide',
            $diffOptions,
            $rendererOptions,
        );
    }
}
