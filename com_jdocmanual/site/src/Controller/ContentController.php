<?php

/**
 * @package     Jdocmanual
 * @subpackage  Site
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Site\Controller;

use J4xdemos\Component\Jdocmanual\Administrator\Controller\ContentController as AdmincontentController;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Jdocmanual Content Controller
 * Used by the Site Javascript but uses the admin controller.
 *
 * @since  4.0.0
 */
class ContentController extends AdmincontentController
{

}