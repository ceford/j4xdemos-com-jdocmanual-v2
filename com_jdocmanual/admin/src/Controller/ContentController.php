<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

use Joomla\CMS\Factory;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\Database\ParameterType;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\InthispageHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Controller to load a single article in the Jdocmanual page
 * Called from jdocmanual.js line 193
 *
 * @since  1.0.0
 */
class ContentController extends BaseController
{
    /**
     * Get the article from the database and return title and content.
     *
     * @return  $string     json encoded data
     *
     * @since   1.0.0
     */
    public function fillpanel()
    {
        $manual = $this->app->input->get('manual', '', 'string');
        $language = $this->app->input->get('language', '', 'string');
        $heading = $this->app->input->get('heading', '', 'string');
        $filename = $this->app->input->get('filename', '', 'string');

        $db = Factory::getContainer()->get('DatabaseDriver');

        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('display_title','html')))
            ->from($db->quoteName('#__jdm_articles'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = :language')
            ->where($db->quoteName('heading') . ' = :heading')
            ->where($db->quoteName('filename') . ' = :filename')
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':heading', $heading, ParameterType::STRING)
            ->bind(':filename', $filename, ParameterType::STRING);
        $db->setQuery($query);
        $row = $db->loadObject();

        if (empty($row) && $language != 'en') {
            // Try again with English
            $query = $db->getQuery(true);
            $language = 'en';
        
            $query->select($db->quoteName(array('display_title','html')))
            ->from($db->quoteName('#__jdm_articles'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = :language')
            ->where($db->quoteName('heading') . ' = :heading')
            ->where($db->quoteName('filename') . ' = :filename')
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':heading', $heading, ParameterType::STRING)
            ->bind(':filename', $filename, ParameterType::STRING);
            $db->setQuery($query);
            $row = $db->loadObject();
        }
        if (empty($row)) {
           $content = array('Placeholder', 'Please select a document');
        } else {
            // separate the Table of Contents - return array(toc, content);
            $content = InthispageHelper::doToc($row->html);
            array_push($content, $row->display_title);
        }
        echo json_encode($content);
        jexit();
    }
}
