<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\FormController;
use Joomla\CMS\Router\Route;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\Markdown2html;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Controller for the Article Stash edit form
 *
 * @since  1.0
 */
class ArticlestashController extends FormController
{
    /**
     * The prefix to use with controller messages.
     *
     * @var    string
     * @since  1.0
     */
    protected $text_prefix = 'COM_JDOCMANUAL_ARTICLESTASH';

    /**
     * The list view of article stashes.
     *
     * @var    string
     * @since  1.0
     */
    protected $view_list = 'articlestashes';

    /**
     * Constructor.
     *
     * @param   array                $config   An optional associative array of configuration settings.
     * Recognized key values include 'name', 'default_task', 'model_path', and
     * 'view_path' (this list is not meant to be comprehensive).
     * @param   MVCFactoryInterface  $factory  The factory.
     * @param   CMSApplication       $app      The Application for the dispatcher
     * @param   Input                $input    Input
     *
     * @since   3.0
     */
    public function __construct($config = array(), $factory = null, $app = null, $input = null)
    {
        parent::__construct($config, $factory, $app, $input);

        // When called from the New button - need to pass on the manual to use
        if (!empty($input)) {
            $filter = $input->get('filter');
            $app->setUserState('com_jdocmanual.articlestash.manual', $filter['manual']);
        }
        // This controller is called from a list with query string parameters. But...
        // It invokes a form for which these parameters are needed for a new stash record
        if ($app->input->get('language')) {
            $app->setUserState('com_jdocmanual.articlestash.eid', $app->input->get('eid', 0, 'int'));
            $app->setUserState('com_jdocmanual.articlestash.trid', $app->input->get('trid', 0, 'int'));
            $app->setUserState('com_jdocmanual.articlestash.manual', $app->input->get('manual', '', 'string'));
            $app->setUserState('com_jdocmanual.articlestash.language', $app->input->get('language', '', 'string'));
        }
    }

    /**
     * Add an article stash item.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function add()
    {
        $this->app->setUserState('com_jdocmanual.articlestash.eid', 0);
        $this->app->setUserState('com_jdocmanual.articlestash.trid', 0);
        parent::add();
    }

    /**
     * Cancel an article stash pul request.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function pullrequestcancel()
    {
        $this->pullrequest = -1;
        $this->save();
    }

    /**
     * Delete an article stash item.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function delete()
    {
        $data = $this->input->post->get('jform', array(), 'array');
        $model = $this->getModel();
        $model->delete($data['id']);
        // Redirect to the list screen.
        $this->setRedirect(
            Route::_(
                'index.php?option=' . $this->option . '&view=' . $this->view_list .
                $this->getRedirectToListAppend(),
                false
            )
        );
    }

    /**
     * Record an article stash pull request.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function pullrequest()
    {
        $this->pullrequest = 1;
        $this->save();
    }

    /**
     * Coomit an article stash pull request.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function commit()
    {
        $this->save();
    }

    /**
     * Method to save a record.
     *
     * @param   string  $key     The name of the primary key of the URL variable.
     * @param   string  $urlVar  The name of the URL variable if different from the primary key
     *                           (sometimes required to avoid router collisions).
     *
     * @return  boolean  True if successful, false otherwise.
     *
     * @since   2.5
     */
    public function save($key = null, $urlVar = null)
    {
        // Check for request forgeries.
        $this->checkToken();

        // Although the starting point is the jdm_articles table, any changes are to the stashes tavle.

        /** @var \Joomla\Component\Finder\Administrator\Model\FilterModel $model */
        $app   = $this->app;
        $model = $this->getModel();
        $table = $model->getTable('Articlestash');
        $data = $this->input->post->get('jform', array(), 'array');
        $context = "$this->option.edit.$this->context";
        $task = $this->getTask();

        // Keep a clear record of the eixting page_id (0 for a new page).
        $existing_page_id = $data['page_id'];

        // Determine the name of the primary key for the data.
        if (empty($key)) {
            $key = $table->getKeyName();
        }

        // To avoid data collisions the urlVar may be different from the primary key.
        if (empty($urlVar)) {
            $urlVar = $key;
        }

        $recordId = $this->input->get($urlVar, '', 'int');

        if (!$this->checkEditId($context, $recordId)) {
            // Somehow the person just went to the form and tried to save it. We don't allow that.
            $this->setMessage(
                Text::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $recordId),
                'error'
            );
            $this->setRedirect(
                Route::_(
                    'index.php?option=' . $this->option . '&view=' . $this->view_list .
                    $this->getRedirectToListAppend(),
                    false
                )
            );

            return false;
        }

        // Populate the row id from the session.
        $data[$key] = $recordId;

        // Validate the posted data.
        // Sometimes the form needs some posted data, such as for plugins and modules.
        $form = $model->getForm($data, false);

        if (!$form) {
            $this->app->enqueueMessage($model->getError(), 'error');

            return false;
        }

        // Test whether the data is valid.
        $validData = $model->validate($form, $data);

        // Check for validation errors.
        if ($validData === false) {
            // Get the validation messages.
            $errors = $model->getErrors();

            // Push up to three validation messages out to the user.
            for ($i = 0, $n = count($errors); $i < $n && $i < 3; $i++) {
                if ($errors[$i] instanceof \Exception) {
                    $this->app->enqueueMessage($errors[$i]->getMessage(), 'warning');
                } else {
                    $this->app->enqueueMessage($errors[$i], 'warning');
                }
            }

            // Save the data in the session.
            $this->app->setUserState($context . '.data', $data);

            // Redirect back to the edit screen.
            $this->setRedirect(
                Route::_(
                    'index.php?option=' . $this->option . '&view=' . $this->view_item .
                    $this->getRedirectToItemAppend($recordId, $key),
                    false
                )
            );

            return false;
        }

        if ($task == 'pullrequest') {
            $validData['pr'] = 1;
        } elseif ($task == 'pullrequestcancel') {
            $validData['pr'] = 0;
        }

        // Attempt to save the data.
        if (!$model->save($validData)) {
            // Save the data in the session.
            $this->app->setUserState($context . '.data', $validData);

            // Redirect back to the edit screen.
            $this->setMessage(Text::sprintf('JLIB_APPLICATION_ERROR_SAVE_FAILED', $model->getError()), 'error');
            $this->setRedirect(
                Route::_(
                    'index.php?option=' . $this->option . '&view=' . $this->view_item .
                    $this->getRedirectToItemAppend($recordId, $key),
                    false
                )
            );

            return false;
        }

        $langKey = $this->text_prefix . ($recordId === 0 && $app->isClient('site') ? '_SUBMIT' : '') . '_SAVE_SUCCESS';
        $prefix  = $this->app->getLanguage()->hasKey($langKey) ? $this->text_prefix : 'JLIB_APPLICATION';

        $this->setMessage(
            Text::_(
                $prefix . ($recordId === 0 && $app->isClient('site') ? '_SUBMIT' : '') . '_SAVE_SUCCESS'
            )
        );

        // Redirect the user and adjust session state based on the chosen task.
        switch ($task) {
            case 'apply':
            case 'pullrequest':
            case 'pullrequestcancel':
                // Set the record data in the session.
                $recordId = $model->getState($model->getName() . '.id');
                $this->holdEditId($context, $recordId);
                $this->app->setUserState($context . '.data', null);
                // Redirect back to the edit screen.
                // Redirect back to the edit screen.
                $this->setRedirect(
                    Route::_(
                        'index.php?option=' . $this->option . '&view=' . $this->view_item
                        . $this->getRedirectToItemAppend($recordId, $urlVar),
                        false
                    )
                );
                break;

            case 'commit':
                 // Write out the stash to the source file.
                $params = ComponentHelper::getParams('com_jdocmanual');
                $gfmfiles_path = $params->get('gfmfiles_path');

                // check that the folder exists
                $folder_path = $data['manual'] . '/' . $data['language'] . '/' . $data['heading'];
                if (!file_exists($gfmfiles_path . $folder_path)) {
                    mkdir($gfmfiles_path . $folder_path);
                }

                $repo_item_path = $data['manual'] . '/' . $data['language'] .
                    '/' . $data['heading'] . '/' . $data['filename'];
                $filepath = $params->get('gfmfiles_path') . $repo_item_path;
                // .git is in the parent folder
                $gitpath = str_replace('manuals/', '.git', $gfmfiles_path);

                // Send an appropriate message.
                if (empty(file_put_contents($filepath, $data['markdown_text']))) {
                    $this->setMessage(Text::_('COM_JDOCMANUAL_ARTICLE_GIT_SAVE_FAILED') . ' Path: ' . $filepath);
                } else {
                    $this->setMessage(Text::_('COM_JDOCMANUAL_ARTICLE_GIT_SAVE_SUCCESS'));

                    // Commit the source file. Example, stage and then commit
                    // % git add manuals/help/en/help-screens/start-here.md
                    // % git commit -m "Commit one file from command line."
                    // In one line:
                    // % git commit -m 'Stage and commit in one line.' -- manuals/help/en/help-screens/start-here.md
                    // git --git-dir /foo/bar/.git log

                    // Build add command - only works properly after cd to folder containing rep.
                    $command1 = "cd {$gfmfiles_path}; /usr/bin/git add -- {$gfmfiles_path}{$repo_item_path};";
                    // Add the file to the index
                    $result = exec($command1, $output1, $result_code1);
                    $this->app->enqueueMessage(implode("<br>\n", $output1), 'warning');

                    // Commit the item:
                    $command2 = "cd {$gfmfiles_path}; /usr/bin/git commit -m \"{$data['commit_message']}\"";
                    $command2 .= " -- {$gfmfiles_path}{$repo_item_path};";
                    $result = exec($command2, $output2, $result_code2);
                    $this->app->enqueueMessage(implode("<br>\n", $output2), 'warning');

                    if (!empty($result)) {
                        // Render the stash as html and store in the index table.
                        $html = Markdown2html::go($data['markdown_text']);
                        Markdown2html::store($html, $data);
                        $this->setMessage(
                            Text::_(
                                'COM_JDOCMANUAL_ARTICLE_GIT_COMMIT_SUCCESS'
                            ) .
                            " Response:  {$result}"
                        );

                        // If this is a new article make an entry in articles-index.txt
                        if (empty($existing_page_id)) {
                            // Example: jdocmanual=Menu_Items=menu-items.md
                            $new_entry = $data['heading'] . '=' . $data['jdoc_key'] . '=' . $data['filename'];
                            $append_to = $gfmfiles_path . '/' . $data['manual'] . '/articles-index.txt';
                            $result = file_put_contents($append_to, $new_entry, FILE_APPEND);
                            // No messages for now?
                            if (empty($result)) {
                                //$this->app->enqueueMessage(Text::_(''), 'warning');
                            } else {
                                //$this->app->enqueueMessage(Text::_(''), 'success');
                            }
                        }

                        // Here, delete the stash.
                        $model->delete($data['id']);
                    }
                    // To get the diff of the last commit
                    // % git diff HEAD^ HEAD -- manuals/help/en/help-screens/start-here.md
                    // Or two commits back:
                    // % git diff HEAD^^ HEAD -- manuals/help/en/help-screens/start-here.md
                    // Capture the output of exec.
                    //  exec(string $command, array &$output = null, int &$result_code = null): string|false
                }
                // fall through? or break?

            default:
                // Clear the record id and data from the session.
                $this->releaseEditId($context, $recordId);
                $this->app->setUserState($context . '.data', null);

                // Redirect to the list screen.
                $this->setRedirect(
                    Route::_(
                        'index.php?option=' .
                        $this->option .
                        '&view=' .
                        $this->view_list .
                        $this->getRedirectToListAppend(),
                        false
                    )
                );
        }

        // Invoke the postSave method to allow for the child class to access the model.
        $this->postSaveHook($model, $validData);

        return true;
    }
}
