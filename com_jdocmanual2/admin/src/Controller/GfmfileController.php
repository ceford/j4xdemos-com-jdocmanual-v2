<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

defined('_JEXEC') or die;

use Joomla\CMS\Factory;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\FormController;
use Joomla\CMS\Router\Route;
use Joomla\Database\ParameterType;

/**
 * Controller for a single source
 *
 * @since  1.6
 */
class GfmfileController extends FormController
{
	protected $text_prefix = 'COM_JDOCMANUAL_GFMFILE';

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
        // This controller is called from a list with query string parameters. But...
        // It invokes a form for which these parameters are needed for a new stash record
        if ($app->input->get('language')) {
            $app->setUserState('com_jdocmanual.gfmfile.eid', $app->input->get('eid', 0, 'int'));
            $app->setUserState('com_jdocmanual.gfmfile.trid', $app->input->get('trid', 0, 'int'));
            $app->setUserState('com_jdocmanual.gfmfile.language', $app->input->get('language', '', 'string'));
        }
    }

    public function pull_request_cancel()
    {
        $this->pull_request = -1;
        $this->save();
    }

    public function pull_request()
    {
        $this->pull_request = 1;
        $this->save();
    }

    public function commit()
    {
        $this->save();
    }
    /**
     * Method to save a record.
     *
     * @param   string  $key     The name of the primary key of the URL variable.
     * @param   string  $urlVar  The name of the URL variable if different from the primary key (sometimes required to avoid router collisions).
     *
     * @return  boolean  True if successful, false otherwise.
     *
     * @since   2.5
     */
    public function save($key = null, $urlVar = null)
    {
        // Check for request forgeries.
        $this->checkToken();

		// Although the starting point is the gfmindex table, any changes are to the stashes tavle.

        /** @var \Joomla\Component\Finder\Administrator\Model\FilterModel $model */
        $app   = $this->app;
        $model = $this->getModel();
        $table = $model->getTable('Stashes');
        $data = $this->input->post->get('jform', array(), 'array');
        $context = "$this->option.edit.$this->context";
        $task = $this->getTask();

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
            $this->setMessage(Text::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $recordId), 'error');
            $this->setRedirect(Route::_('index.php?option=' . $this->option . '&view=' . $this->view_list . $this->getRedirectToListAppend(), false));

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
                Route::_('index.php?option=' . $this->option . '&view=' . $this->view_item . $this->getRedirectToItemAppend($recordId, $key), false)
            );

            return false;
        }

        if ($this->pull_request == 1) {
            $validData['pr'] = 1;
        } elseif ($this->pull_request == -1) {
            $validData['pr'] = 0;
        }

        // Attempt to save the data.
        if (!$model->save($validData)) {
            // Save the data in the session.
            $this->app->setUserState($context . '.data', $validData);

            // Redirect back to the edit screen.
            $this->setMessage(Text::sprintf('JLIB_APPLICATION_ERROR_SAVE_FAILED', $model->getError()), 'error');
            $this->setRedirect(
                Route::_('index.php?option=' . $this->option . '&view=' . $this->view_item . $this->getRedirectToItemAppend($recordId, $key), false)
            );

            return false;
        }

        $langKey = $this->text_prefix . ($recordId === 0 && $app->isClient('site') ? '_SUBMIT' : '') . '_SAVE_SUCCESS';
        $prefix  = $this->app->getLanguage()->hasKey($langKey) ? $this->text_prefix : 'JLIB_APPLICATION';

        $this->setMessage(Text::_($prefix . ($recordId === 0 && $app->isClient('site') ? '_SUBMIT' : '') . '_SAVE_SUCCESS'));

        // Redirect the user and adjust session state based on the chosen task.
        switch ($task) {
            case 'apply':
            case 'pull_request':
            case 'pull_request_cancel':
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

                    // Commit the source file. Example, stage and then commit
                    // % git add manuals/help/en/help-screens/start-here.md
                    // % git commit -m "Commit one file from command line."
                    // In one line:
                    // % git commit -m 'Stage and commit in one line.' -- manuals/help/en/help-screens/start-here.md

                    // To get the diff of the last commit
                    // % git diff HEAD^ HEAD -- manuals/help/en/help-screens/start-here.md
                    // Or two commits back:
                    // % git diff HEAD^^ HEAD -- manuals/help/en/help-screens/start-here.md
                    // Capture the output of exec.
                    //  exec(string $command, array &$output = null, int &$result_code = null): string|false

                    // Render the stash as html and store in the index table.

                    // Remove the pr flag from the stash record.

                    // Send an appropriate message.
                    $this->setMessage(Text::_('COM_JDOCMANUAL_GFMFILE_GIT_COMMIT_SUCCESS'));

                    // Delete the stash record here? Or let the user do it?

                default:
                // Clear the record id and data from the session.
                $this->releaseEditId($context, $recordId);
                $this->app->setUserState($context . '.data', null);

                // Redirect to the list screen.
                $this->setRedirect(
                    Route::_('index.php?option=' . $this->option . '&view=' . $this->view_list . $this->getRedirectToListAppend(), false)
                );

                break;
        }

        // Invoke the postSave method to allow for the child class to access the model.
        $this->postSaveHook($model, $validData);

        return true;
    }

}
