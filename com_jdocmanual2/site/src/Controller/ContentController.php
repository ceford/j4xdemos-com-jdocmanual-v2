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

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\Database\ParameterType;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use Joomla\CMS\Uri\Uri;
use J4xdemos\Component\Jdocmanual\Administrator\Controller\ContentController as AdmincontentController;

/**
 * Jdocmanual Component Controller
 *
 * @since  4.0.0
 */
class ContentController extends AdmincontentController
{
	protected $app;
	protected $update = false;

	//public function fillpanel()
	//{
	//	$this->fill();
	//}
}