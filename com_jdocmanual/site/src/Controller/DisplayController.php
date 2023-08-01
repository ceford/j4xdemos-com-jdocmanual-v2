<?php

/**
 * @package     Jdocmanual
 * @subpackage  Site
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Site\Controller;

use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

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
    protected $default_view = 'manual';

    public function display($cachable = false, $urlparams = [])
    {
        //$view   = $this->input->get('view', 'jdocmanual');
        //$layout = $this->input->get('layout', 'default');
        //$id     = $this->input->getInt('id');
        return parent::display();
    }

    public function selectmanual()
    {
        $setuphelper = new SetupHelper();
        $setuphelper->changemanual();
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
