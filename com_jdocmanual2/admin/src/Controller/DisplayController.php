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

use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;

/**
 * Media Manager Component Controller
 *
 * @since  4.0.0
 */
class DisplayController extends BaseController
{
	/**
	 * The default view.
	 *
	 * @var    string
	 * @since  1.6
	 */
	protected $default_view = 'jdocmanual';

	protected $app;

	public function selectmanual()
	{
		return parent::display();
	}

	public function selectindexlanguage()
	{
		return parent::display();
	}

	public function selectpagelanguage()
	{
		return parent::display();
	}

	/**
	 * Method to fetch, parse and store the Manual contents from docs.joomla.org
	 */
	public function fetchcontents()
	{
		$this->app->enqueueMessage('Controller: Test in DisplayController', 'warning');
		if (!Session::checkToken('post'))
		{
			$this->app->enqueueMessage('Controller: Invalid Token!', 'warning');
		}
		else
		{
			$model = $this->getModel('Jdocmanual');
			$model->setContents();
			$this->app->enqueueMessage(Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_SUCCESS'), 'success');
		}
		$this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=jdocmanual', false));
	}
}
