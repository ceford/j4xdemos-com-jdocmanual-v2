<?php

/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Helper;

use Joomla\Database\ParameterType;
use Joomla\CMS\Factory;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Helper to create a menu preview for the Menu Stash: Edit form.
 * This is an abbreiviated version of the code used in Cli/Buildmenus.php.
 *
 * @since  1.0
 */
class BuildmenusHelper
{
    /**
     * Build a menu table for a menu stash preview.
     *
     * @param   string  $manual     The path fragment for the manual.
     * @param   string  $menu       A string containing the menu-index.txt.
     * @param   string  $language   The language code for this menu.
     *
     * @return  string  The menu in html.
     *
     * @since  1.0.0
     */
    public function buildmenus($manual, $menu, $language = 'en')
    {
        // if any parameter is missing return false
        if (empty($manual) || empty($menu)) {
            return false;
        }

        // Fetch a list of article headings in English.
        $headings_english = $this->set_headings($manual);

        // Fetch a list of headings in the specified language.
        if ($language !== 'en') {
            $headings_language = $this->set_headings($manual, $language);
        }

        // Split the menu into lines.
        $lines = preg_split("/((\r?\n)|(\r\n?))/", $menu);
        $count = count($lines);
        $count_headings = 0;
        $count_articles = 0;
        $html = '';

        foreach ($lines as $line) {
            $line = trim($line);
            // Skip any line starting with a semi-colon
            if (empty($line) || strpos($line, ';') === 0) {
                continue;
            }
            $parts = explode('=', $line);
            // If the line starts with 'heading=' start a new accordion.
            if ($parts[0] === 'heading') {
                if ($count_headings > 0) {
                    $html .= $this->accordionend();
                }
                // Example: heading=getting-started=Getting Started
                $count_headings += 1;
                $html .= $this->accordionstart($language, $parts[2]);
            } else {
                // Example: developer=getting-started=developer-required-software.md
                $html .= $this->accordionitem($language, $parts);
            }
        }
        $html .= $this->accordionend();
        return $html;
    }

    /**
     * Create an accordian start code.
     *
     * @param   int     $id     The sequence number of the accordion.
     * @param   string  $label  A summary label.
     *
     * @return  string  The required html code.
     *
     * @since   1.0.0
     */
    protected function accordionstart($language, $heading)
    {
        // First set the English display title
        /*
        $result = $this->heading_english();
        if ($language === 'en') {

        } else {

        }
        */
        // If language not English get the heading from ...
        $html = "<details class=\"jdm\">\n<summary>{$heading}</summary>\n<ul>\n";
        return $html;
    }

    /**
     * Create an accordian end code.
     *
     * @return  string  The required html code.
     *
     * @since   1.0.0
     */
    protected function accordionend()
    {
        return "\n</ul>\n</details>\n";
    }

    /**
     * Create an accordian item code.
     *
     * @param   int     $id             The sequence number of the accordion.
     * @param   string  $display_title  The display title.
     *
     * @return  string  The required html code.
     *
     * @since   1.0.0
     */
    protected function accordionitem($language, $parts)
    {
        // Example: developer=getting-started=developer-required-software.md
        $id = 0;
        $jdoc_key = '';
        list($id, $title, $jdoc_key) = $this->get_article_data($parts[0], $language, $parts[1]);
        if (empty($title) && $language !== 'en') {
            list($id, $title, $jdoc_key) = $this->get_article_data($parts[0], 'en', $parts[1]);
        }
        if (empty($title)) {
            $title = substr($parts[2], 0, strpos($parts[2], '.md'));
            $title = str_replace('-', ' ', $title);
            $title = ucwords($title);
        }

        // escape any " character in the link
        // $link = str_replace('"', '', $link);
        $html = ''; //'<li><span class="icon-file-alt icon-fw icon-jdocmanual" aria-hidden="true"></span>';

        // Including the view here causes the sef router not to break!
        $route = 'index.php?option=com_jdocmanual&id=' . $id;
        $html .= '<li id="article-' . $id . '">';
        $html .= '<a href="' . $route . '" class="content-link" data-content-id="' . $jdoc_key . '">';
        $html .= $title . '</a></li>' . "\n";
        return $html;
    }

    /**
     * Get article data for the menu.
     *
     * @param   string  $manual     The article path fragment.
     * @param   string  $language   The article language.
     * @param   string  $heading    The article filename.
     *
     * @return  string  The required html code.
     *
     * @since   1.0.0
     */
    protected function get_article_data($manual, $language, $heading)
    {
        // Try to get the article record from the database.
        $db = Factory::getContainer()->get('DatabaseDriver');

        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('id','display_title', 'jdoc_key')))
        ->from($db->quoteName('#__jdm_articles'))
        ->where($db->quoteName('manual') . ' = :manual')
        ->where($db->quoteName('language') . ' = :language')
        ->where($db->quoteName('heading') . ' = :heading')
        ->bind(':manual', $manual, ParameterType::STRING)
        ->bind(':language', $language, ParameterType::STRING)
        ->bind(':heading', $heading, ParameterType::STRING);
        $db->setQuery($query);
        return $db->loadResult();
    }

    /**
     * Get the accordion headings for the menu.
     *
     * @param   manual     $manual      The article path fragment.
     * @param   language   $language    The article language.
     *
     * @return  array      An associative array of headings.
     *
     * @since   1.0.0
     */
    protected function set_headings($manual, $language = 'en')
    {
        $db = Factory::getContainer()->get('DatabaseDriver');

        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('heading','display_title')))
        ->from($db->quoteName('#__jdm_menu_headings'))
        ->where($db->quoteName('manual') . ' = :manual')
        ->where($db->quoteName('language') . ' = :language')
        ->bind(':manual', $manual, ParameterType::STRING)
        ->bind(':language', $language, ParameterType::STRING);
        $db->setQuery($query);
        $rows = $db->loadObjectList();
        $headings = [];
        foreach ($rows as $row) {
            $headings[$row->heading] = $row->display_title;
        }
        return $headings;
    }
}
