<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

use Joomla\CMS\MVC\Controller\BaseController;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\SetupHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\Buildarticles;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Controller to display the default page - display of articles
 *
 * @since  1.0.0
 */
class DisplayController extends BaseController
{
    /**
     * The prefix to use with controller messages.
     *
     * @var    string
     * @since  1.0
     */
    protected $text_prefix = 'COM_JDOCMANUAL_DISPLAY';

    /**
     * The default view.
     *
     * @var    string
     * @since  1.6
     */
    protected $default_view = 'manual';

   /**
     * Get the article from the database and return title and content.
     *
     * @return  $string     json encoded data
     *
     * @since   1.0.0
     */
    public function display($cachable = false, $urlparams = [])
    {
        return parent::display();
    }

   /**
     * Select a new manual.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function selectmanual()
    {
        $setuphelper = new SetupHelper();
        $setuphelper->changemanual();
        return $this->display();
    }

   /**
     * Select a new index language.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function selectindexlanguage()
    {
        return $this->display();
    }

   /**
     * Select a new page language.
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function selectpagelanguage()
    {
        return $this->display();
    }

   /**
     * Update the article html for the selected manual and language.
     * This function updates all of the articles (ToDo: selected articlle).
     *
     * @return  $void
     *
     * @since   1.0.0
     */
    public function updatehtml()
    {
        if ($cookie = $this->app->input->cookie->get('jdocmanual')) {
            list ($manual, $index_language_code, $page_language_code, $old_page_id) = explode('-', $cookie);
        }
        if (empty($manual) || empty($page_language_code)) {
            return $this->display();
        }
        $ba = new Buildarticles();
        $summary = $ba->go($manual, $page_language_code);
        $this->app->enqueueMessage($summary);

        return parent::display();
    }
}
