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
use Joomla\Database\ParameterType;
use Joomla\Utilities\ArrayHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\Markdown2html;

/**
 * Controller for a single source
 *
 * @since  1.6
 */
class GfmfilesController extends FormController
{
	protected $text_prefix = 'COM_JDOCMANUAL_GFMFILES';
	protected $app;
    protected $nitems = 0;
    protected $titems = 0;

    public function updatehtml()
    {
        // Set the return path.
        $this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=gfmfiles', false));
        $cids = $this->app->input->get('cid', array(), 'array');

        // Get the path to .md documents.
		$params = ComponentHelper::getParams('com_jdocmanual');
		$sitepath = $params->get('gfmfiles_path');
        $updatehtmlcount = $params->get('update_html_count');

        // Check the site path has been set.
        if (empty($sitepath)) {
            $this->app->enqueueMessage('The path to git repo has not been set. Please select Options to set it', 'warning');
            return false;
        }

        // Get records from the database and fill the html field where it is empty
		$db = Factory::getDbo();
		$query = $db->getQuery(true);
        $query->select($db->quoteName(array('id', 'jdoc_key', 'manual', 'language', 'heading', 'filename', 'display_title')))
            ->from($db->quoteName('#__jdocmanual_gfmindex'));

        // if no specific ids were give look for empty html fields
        if (empty($cids)) {
            $query->where('html IS NULL OR html =""');
        } else {
            $query->whereIn($db->quoteName('id'), $cids);
        }

		$db->setQuery($query, 0, $updatehtmlcount);
		$rows = $db->loadAssocList();
        $start_at = $rows[0]['id'];
        foreach ($rows as $row) {
            $path = $sitepath . implode('/', array($row['manual'], $row['language'], $row['heading'], $row['filename']));
            $mdfile = file_get_contents($path);
            // problems with encoding.
            //$mdfile = iconv(mb_detect_encoding($mdfile, mb_detect_order(), true), "UTF-8", $mdfile);
            if (empty($mdfile)) {
                $this->app->enqueueMessage('Empty file, skipping: ' . $path, 'success');
                continue;
            }
            $html = Markdown2html::go($mdfile);
            // store in the database.
            $row['page_id'] = $row['id'];
            Markdown2html::store($html, $row);
        }
        $this->app->enqueueMessage('Number of html fields updated: ' . count($rows) . '. Starting at ' . $start_at, 'success');
    }
}
