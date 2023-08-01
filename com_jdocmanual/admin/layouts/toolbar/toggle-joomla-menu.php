<?php

/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   (C) 2021 Clifford E. Ford <https://www.fford.me.uk>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

use Joomla\CMS\Language\Text;

$title = Text::_('COM_JDOCMANUAL_MANUAL_TOGGLE_JOOMLA_MENU')

?>
<joomla-toolbar-button id="toggle-joomla-menu" task="">
    <button class="btn btn-info" type="button">
        <span class="icon-toggle-off" aria-hidden="true"></span>
        <?php echo $title; ?>
    </button>
</joomla-toolbar-button>
