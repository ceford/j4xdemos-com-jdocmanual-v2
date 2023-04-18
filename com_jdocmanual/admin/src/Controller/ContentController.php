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

use Joomla\CMS\Factory;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\Database\ParameterType;
use Joomla\CMS\Session\Session;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\InthispageHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

/**
 * Jdocmanual Component Controller
 *
 * @since  4.0.0
 */
class ContentController extends BaseController
{
	protected $app;

	public function fillpanel()
	{
		$item_id = $this->app->input->get('item_id', 1, 'int');
		$setuphelper = new SetupHelper;
		$item_id = $setuphelper->realid($item_id);

		$db = Factory::getDbo();
		// is the required page already downloaded?
		$query = $db->getQuery(true);
		$query->select($db->quoteName(array('display_title','html')))
			->from($db->quoteName('#__jdocmanual_gfmindex'))
			->where($db->quoteName('id') . ' = :id')
			->bind(':id', $item_id, ParameterType::INTEGER);
		$db->setQuery($query);
		$row = $db->loadObject();
		// separate the Table of Contents - return array(toc, content);
		$content = InthispageHelper::doToc($row->html);
		array_push($content, $row->display_title);
		echo json_encode($content);
		jexit();
	}
}