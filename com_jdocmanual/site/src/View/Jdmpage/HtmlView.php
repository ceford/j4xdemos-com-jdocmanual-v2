<?php

/**
 * @package     Jdocmanual
 * @subpackage  Site
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Site\View\Jdmpage;

use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * View class for jdocmanual.
 *
 * @since  4.0
 */
class HtmlView extends BaseHtmlView
{
    protected $manual;
    protected $index_language_code;
    protected $page_language_code;
    protected $menu_page_id;


    /**
     * Method to display the view.
     *
     * @param   string  $tpl  A template file to load. [optional]
     *
     * @return  void
     *
     * @since   1.6
     * @throws  Exception
     */
    public function display($tpl = null): void
    {
        // Page repurposed for search results - needs work!

        //$this->loadPage();

        parent::display($tpl);
    }
}
