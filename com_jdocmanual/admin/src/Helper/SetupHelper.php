<?php

/**
 * @package     jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Helper;

use Joomla\CMS\Factory;
use Joomla\Database\ParameterType;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Helper to initialise data to avoid first page load problems.
 *
 * @since  1.0
 */
class SetupHelper
{
    /**
     * Set a cookie.
     *
     * @param   string  $name   The name of the cookie to set.
     * @param   string  $value  The cookie value.
     * @param   string  $days   The number of days the cookie should be valid.
     *
     * @return  void
     *
     * @since  1.0.0
     */
    protected function setcookie($name, $value, $days)
    {
        $app = Factory::getApplication();

        if (!empty($days)) {
            $offset = time() + $days * 24 * 60 * 60;
        } else {
            $offset = 0;
        }
        $cookie_domain = $app->get('cookie_domain', '');
        $cookie_path   = $app->get('cookie_path', '/');
        $cookie = session_get_cookie_params();
        $arr_cookie_options = array (
            'expires' => $offset,
            'path' => $cookie_path,
            'domain' => $cookie_domain, // leading dot for compatibility or use subdomain
            'secure' => false,     // or false
            'httponly' => false,    // or false
            'samesite' => 'Strict' // None || Lax  || Strict
            );
        setcookie($name, $value, $arr_cookie_options);
    }

    /**
     * Check for form parameters change.
     *
     * @return  array   Setup data for a page load.
     *
     * @since  1.0.0
     */
    public function setup()
    {
        $app = Factory::getApplication();

        // Defaults when there is no form or cookie.
        $manual = 'user';
        $index_language_code = 'en';
        $page_language_code = 'en';

        // Are there query parameters to work with - within page links.
        $heading = $app->input->get('heading', '', 'string');
        $filename = $app->input->get('filename', '', 'string');

        // is there a form to work with
        $jform = $app->input->get('jform', array(), 'array');

        $cookie = $app->input->cookie->get('jdocmanual');
        if (!empty($cookie)) {
            $cookie_items = preg_split("/--/", $cookie);

            if (!empty($cookie_items) && count($cookie_items) == 5){
                $old_manual = $cookie_items[0];
                $old_index_language_code = $cookie_items[1];
                $old_page_language_code = $cookie_items[2];
                $old_heading = $cookie_items[3];
                $old_filename = $cookie_items[4];
            } else {
                $cookie = null;
            }
        }

        if (!empty($jform)) {
            $manual = $jform['manual'];
            $index_language_code = $jform['index_language_code'];
            $page_language_code = $jform['page_language_code'];
            $heading = $jform['heading'];
            $filename = $jform['filename'];
        } elseif (!empty($heading) && !empty($filename)) {
            if (!empty($cookie)) {
                $manual = $old_manual;
                $index_language_code = $old_index_language_code;
                $page_language_code = $old_page_language_code;
            }
        } elseif (!empty($cookie)) {
            $manual = $old_manual;
            $index_language_code = $old_index_language_code;
            $page_language_code = $old_page_language_code;
            $heading = $old_heading;
            $filename = $old_filename;
        }
        
        // If the heading and/or filename are empty get default values
        if (empty($heading) || empty ($filename)) {
            $db = Factory::getContainer()->get('DatabaseDriver');

            $query = $db->getQuery(true);
            $query->select($db->quoteName(array('heading_ini', 'filename_ini')))
            ->from($db->quoteName('#__jdm_manuals'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->bind(':manual', $manual, ParameterType::STRING);
            $db->setQuery($query);
            $row = $db->loadObject();
            $heading = $row->heading_ini;
            $filename = $row->filename_ini;
        }

        $new_cookie = "{$manual}--{$index_language_code}--{$page_language_code}--{$heading}--{$filename}";
        // $name, $value, $days
        $this->setCookie('jdocmanual', $new_cookie, 10);

        return [$manual, $index_language_code, $page_language_code, $heading, $filename];
    }

    /**
     * Reset for a change of manual.
     *
     * @return  void   Set the article id to the first item in the manual.
     *
     * @since  1.0.0
     */
    public function changemanual()
    {
        // change of Manual needs the Itemid set to the first in the list
        // get menu from jdocmanual_menu wher manual=x and language=y then
        // get the very first li e.g. <li id="article-1"> and use the value
        // by placing it in the cookie.

        $app = Factory::getApplication();
        $jform = $app->input->get('jform', array(), 'array');

        $db = Factory::getContainer()->get('DatabaseDriver');

        $query = $db->getQuery(true);
        $query->select($db->quoteName('menu'))
        ->from($db->quoteName('#__jdm_menus'))
        ->where($db->quoteName('manual') . ' = :manual')
        ->where($db->quoteName('language') . ' = :language')
        ->bind(':manual', $jform['manual'], ParameterType::STRING)
        ->bind(':language', $jform['index_language_code'], ParameterType::STRING);

        $db->setQuery($query);
        $menu = $db->loadResult();

        // If there was no result and the index_language_code was not en try again.
        if (empty($menu)) {
            $query = $db->getQuery(true);
            $query->select($db->quoteName('menu'))
            ->from($db->quoteName('#__jdm_menus'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = ' . $db->quote('en'))
            ->bind(':manual', $jform['manual'], ParameterType::STRING);

            $db->setQuery($query);
            $menu = $db->loadResult();
        }
        $pattern = '/<li id="article-(\d{1,}).*/';
        $result = preg_match($pattern, $menu, $matches);
        $jform['menu_page_id'] = $matches[1];
        $app->input->set('jform', $jform);
    }

    /**
     * Get the translated article id from the english id.
     *
     * @param integer   $id                     The article id value set in the menu.
     * @param string    $manual                 The manual code.
     * @param string    $index_language_code    The index language code.
     * @param string    $page_language_code     The page language code.
     *
     * @return  int     The article id in the selected page language.
     *
     * @since  1.0.0
     */
    public function realid($id, $manual = null, $index_language_code = null, $page_language_code = null)
    {
        // Check that there are settings to work with.
        if (empty($page_language_code)) {
            $app = Factory::getApplication();
            $cookie = $app->input->cookie->get('jdocmanual');
            if (empty($cookie)) {
                return $id;
            }
            list($manual, $index_language_code, $page_language_code, $menu_page_id) = explode('-', $cookie);
        }

        // If the index and page languages are the same do nothing.
        if ($index_language_code == $page_language_code) {
            return $id;
        }

        // If the index and page languages are different - return the corrected page id.
        $db = Factory::getContainer()->get('DatabaseDriver');
        $query = $db->getQuery(true);

        // Get the data for the menu item article id.
        $query->select($db->quoteName(array('manual', 'language', 'heading', 'filename')))
        ->from($db->quoteName('#__jdm_articles'))
        ->where($db->quoteName('id') . ' = :id')
        ->bind(':id', $id, ParameterType::INTEGER);
        $db->setQuery($query);
        $row = $db->loadObject();

        // If the language is the same as the page language.
        if ($page_language_code == $row->language) {
            return $id;
        }

        // Get the id for the key in the selected page language.
        $query = $db->getQuery(true);
        $query->select($db->quoteName('id'))
        ->from($db->quoteName('#__jdm_articles'))
        ->where($db->quoteName('manual') . ' = :manual')
        ->where($db->quoteName('language') . ' = :language')
        ->where($db->quoteName('heading') . ' = :heading')
        ->where($db->quoteName('filename') . ' = :filename')
        ->bind(':manual', $row->manual, ParameterType::STRING)
        ->bind(':language', $page_language_code, ParameterType::STRING)
        ->bind(':heading', $row->heading, ParameterType::STRING)
        ->bind(':filename', $row->filename, ParameterType::STRING);
        $db->setQuery($query);
        $new_id = $db->loadResult();

        if (!empty($new_id)) {
            return $new_id;
        }

        // Try again using en for the article language.
        $query = $db->getQuery(true);
        $query->select($db->quoteName('id'))
        ->from($db->quoteName('#__jdm_articles'))
        ->where($db->quoteName('manual') . ' = :manual')
        ->where($db->quoteName('language') . ' = ' . $db->quote('en'))
        ->where($db->quoteName('heading') . ' = :heading')
        ->where($db->quoteName('filename') . ' = :filename')
        ->bind(':manual', $row->manual, ParameterType::STRING)
        ->bind(':heading', $row->heading, ParameterType::STRING)
        ->bind(':filename', $row->filename, ParameterType::STRING);
        $db->setQuery($query);
        $new_id = $db->loadResult();

        if (!empty($new_id)) {
            return $new_id;
        }

        return $id;
    }
}
