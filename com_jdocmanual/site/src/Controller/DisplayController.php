<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Site\Controller;

\defined('_JEXEC') or die;

use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

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

    public function display($cachable = false, $urlparams = [])
    {
		$view   = $this->input->get('view', 'jdocmanual');
		$layout = $this->input->get('layout', 'default');
		$id     = $this->input->getInt('id');
        return parent::display();
	}

	public function selectmanual()
	{
		$setuphelper = new SetupHelper;
		$setuphelper->change_of_manual();
		return $this->display();
	}

	public function selectindexlanguage()
	{
		return $this->display();
	}

	public function selectpagelanguage()
	{
		return $this->display();
	}

	/**
	 * Method to get a model object, loading it if required.
	 *
	 * @param   string  $name    The model name. Optional.
	 * @param   string  $prefix  The class prefix. Optional.
	 * @param   array   $config  Configuration array for model. Optional.
	 *
	 * @return  \Joomla\CMS\MVC\Model\BaseDatabaseModel|boolean  Model object on success; otherwise false on failure.
	 *
	 * @since   3.0
	 */
	public function getModel($name = '', $prefix = '', $config = [])
	{
		// Force to load the admin model
		return parent::getModel($name, 'Administrator', $config);
	}

}
