<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

use Joomla\CMS\Language\Text;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

$title = Text::_('COM_JDOCMANUAL_MANUAL_TOGGLE_JOOMLA_MENU')

?>
<joomla-toolbar-button id="toggle-joomla-menu" task="">
    <button class="btn btn-info" type="button">
        <span class="icon-toggle-off" aria-hidden="true"></span>
        <?php echo $title; ?>
    </button>
</joomla-toolbar-button>
