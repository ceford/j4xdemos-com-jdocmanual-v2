<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Model;

use Joomla\CMS\MVC\Model\ListModel;
use Joomla\Database\ParameterType;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\InthispageHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * First page start. Do some checks, get the Menu and Manual and Language lists.
 *
 * @since  1.0
 */
class ManualModel extends ListModel
{
    /**
     * Check that the jdocmanual plugin has been enabled.
     *
     * @return int The enabled value, 0 or 1.
     */
    public function checkplugin()
    {
        $db = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('extension_id', 'enabled')))
        ->from($db->quoteName('#__extensions'))
        ->where($db->quoteName('name') . ' = ' . $db->quote('plg_system_jdocmanualcli'));
        $db->setQuery($query);
        $row = $db->loadObject();
        if (empty($row)) {
            return 0;
        }
        if (empty($row->enabled)) {
            return 1;
        }
        return 2;
    }

    /**
     * Check that the jdm_articles and jdm_menus tables have been populated.
     *
     * @return int  Flag for tables populated, value, 0 or 1.
     */
    public function checkDatabase()
    {
        $db = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select('COUNT(id)')
        ->from('#__jdm_articles');
        $db->setQuery($query);
        $articles_total = $db->loadResult();
        if (empty($articles_total)) {
            return 0;
        }

        $query = $db->getQuery(true);
        $query->select('COUNT(id)')
        ->from('#__jdm_menus');
        $db->setQuery($query);
        $menus_total = $db->loadResult();
        if (empty($menus_total)) {
            return 0;
        }

        return 1;
    }

    /**
     * Get the first article on page load.
     *
     * @param string $manual        The name of the manual.
     * @param string $language      The name of the language.
     * @param string $data_path     The name of the data_path.
     *
     * @return  array  An array of display items.
     *
     * @since  1.0.0
     */
    public function getPage($manual, $language, $heading, $filename)
    {
        $db = $this->getDatabase();
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
            return array('placeholder', '', 'Please select a document');
        }

        if (empty($row->html)) {
            return array('placeholder', '', 'The html field has not been populated. Select the GFM Files menu.');
        }

        // First page load needs the ToC processed here.
        $itp = new InthispageHelper;
        list ($in_this_page, $content) = $itp->doToc($row->html);

        return array($row->display_title, $in_this_page, $content);
    }

    /**
     * Populate the index of pages that appears in the left column
     *
     * @param string    $manual             The manual code.
     * @param string    $index_language     The menu language code.
     * @param string    $menu_page_id       The id of the currently open article.
     *
     * @return string   The menu html.
     */
    public function getMenu($manual, $index_language, $heading, $filename)
    {
        $db = $this->getDatabase();
        $query = $db->getQuery(true);
        
        $query->select($db->quoteName('menu'))
        ->from($db->quoteName('#__jdm_menus'))
        ->where($db->quoteName('state') . ' = 1')
        ->where($db->quoteName('manual') . ' = :manual')
        ->where($db->quoteName('language') . ' = :language')
        ->bind(':manual', $manual, ParameterType::STRING)
        ->bind(':language', $index_language, ParameterType::STRING)
        ->order($db->quoteName('id') . ' desc');
        $db->setQuery($query);
        $menu = $db->loadObject();

        // If not correctly setup - no menus create.
        if (empty($menu) && $index_language == 'en') {
            return;
        }

        if (empty($menu) && $index_language != 'en') {
            // try again with English
            $query = $db->getQuery(true);
            $query->select($db->quoteName('menu'))
            ->from($db->quoteName('#__jdm_menus'))
            ->where($db->quoteName('state') . ' = 1')
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = ' . $db->quote('en'))
            ->bind(':manual', $manual, ParameterType::STRING)
            ->order($db->quoteName('id') . ' desc');
            $db->setQuery($query);
            $menu = $db->loadObject();
        }
        return $menu;

        // If there is an id, set the containing <details> element to open=""
        // Get all of the <details> elements.
        $pattern = '/<details.*?<\/details>/ms';
        preg_match_all($pattern, $menu->menu, $matches);

        // Find the element that is active.
        $needle = '&id=' . $menu_page_id . '"';
        $menu->menu = '';
        foreach ($matches[0] as $match) {
            if (strrpos($match, $needle)) {
                $match = str_replace('<details ', '<details open="" ', $match);
            }
            $menu->menu .= $match . "\n";
        }

        // Add a class to the open li
        $menu->menu = str_replace('<li id="article-' . $menu_page_id .
            '"', '<li id="article-' . $menu_page_id . '" class="article-active"', $menu->menu);

        return $menu;
    }

    /**
     * Get a list of manuals.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getManuals()
    {
        $db = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select('*')
        ->from($db->quoteName('#__jdm_manuals'))
        ->where($db->quoteName('state') . ' = 1')
        ->order($db->quoteName('id'));
        $db->setQuery($query);
        return $db->loadObjectList();
    }

    /**
     * Get a list of language.
     *
     * @param   string  $indexorpage  Which list: index or page.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getLanguages($indexorpage)
    {
        $db = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select($db->quoteName(array('id', 'code', 'title')))
        ->from($db->quoteName('#__jdm_languages'))
        ->where($db->quoteName('state') . ' = 1')
        ->where($db->quoteName($indexorpage . '_language') . ' = 1')
        ->order($db->quoteName('code'));
        $db->setQuery($query);
        return $db->loadObjectList();
    }

    /**
     * Get a Manual data source.
     *
     * @param   int  $id  The id of the data source.
     *
     * @return  array  An array of query result objects.
     *
     * @since  1.0.0
     */
    public function getSourceData($id)
    {
        $db = $this->getDatabase();
        $query = $db->getQuery(true);
        $query->select($db->quoteName('title'))
            ->from($db->quoteName('#__jdm_manuals'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->bind(':manual', $id, ParameterType::STRING);
        $db->setQuery($query);
        $data = $db->loadObject();

        return $data;
    }
}
