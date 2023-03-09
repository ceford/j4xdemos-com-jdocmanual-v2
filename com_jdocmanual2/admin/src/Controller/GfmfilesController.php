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

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\FormController;
use Joomla\CMS\Router\Route;
use Joomla\Utilities\ArrayHelper;
require JPATH_COMPONENT . '/libraries/vendor/autoload.php';
use League\CommonMark\CommonMarkConverter;

/**
 * Controller for a single source
 *
 * @since  1.6
 */
class GfmfilesController extends FormController
{
	protected $text_prefix = 'COM_JDOCMANUAL_GFMFILES';

    public function updatehtmlall()
    {
        // Get records from the database and fill the html field where it is empty
		$db = Factory::getDbo();
		$params = ComponentHelper::getParams('com_jdocmanual');
		$sitepath = $params->get('gfmfiles_path') . $data['path'];

        $converter = new CommonMarkConverter([
            'allow_unsafe_links' => false,
        ]);

		$query = $db->getQuery(true);
        $query->select('id, path, filename, html')
            ->from('#__jdocmanual_gfmindex')
            ->where('html IS NULL');
		$db->setQuery($query, 0, 100);
		$rows = $db->loadObjectList();

        foreach ($rows as $row) {
            $path = $sitepath . $row->path . $row->filename;
            $mdfile = file_get_contents($path);
            $html = $converter->convert($mdfile);
    		$query = $db->getQuery(true);
            $query->update('#__jdocmanual_gfmindex')
            ->set('html = ' . $db->quote($html))
            ->where('id = ' . $row->id);
            $db->setQuery($query);
            $db->execute();
        }
        $this->app->enqueueMessage('Number of empty html fields updated: ' . count($rows), 'success');

		$this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=gfmfiles', false));
    }
}
