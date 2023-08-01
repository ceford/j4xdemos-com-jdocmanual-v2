<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Layout\LayoutHelper;
use Joomla\CMS\Router\Route;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/** @var Joomla\CMS\WebAsset\WebAssetManager $wa */
$wa = $this->document->getWebAssetManager();
$wa->useStyle('com_jdocmanual.jdocmanual')
->useStyle('com_jdocmanual.offcanvas')
->useScript('com_jdocmanual.jdocmanual');

// make the toolbar not sticky
$wa->addInlineStyle('.subhead { position: inherit; ');

Text::script('COM_JDOCMANUAL_MANUAL_TOC_IN_THIS_PAGE', true);

$url = '';

// if using proxy do not show link to original
$proxy = false;
if (strpos($url, '/proxy/') !== false) {
    $proxy = true;
}
$gfmfiles_path = ComponentHelper::getComponent('com_jdocmanual')->getParams()->get('gfmfiles_path');

?>
<?php if (empty($this->dbisgood) || !str_ends_with($gfmfiles_path, '/manuals/')) : ?>
    <?php include __DIR__ . '/notes.php'; ?>
<?php else : ?>
<form action="index.php?option=com_jdocmanual&view=manual"
    method="post" name="adminForm" id="adminForm">
    <input type="hidden" name="task" id="task" value="">
    <input type="hidden" name="jform[manual]" id="jform_manual" value="<?php echo $this->manual; ?>">
    <input type="hidden" name="jform[index_language_code]" id="jform_index_language_code"
        value="<?php echo $this->index_language_code; ?>">
    <input type="hidden" name="jform[page_language_code]" id="jform_page_language_code"
        value="<?php echo $this->page_language_code; ?>">
    <input type="hidden" name="jform[menu_page_id]" id="jform_menu_page_id"
        value="<?php echo $this->menu_page_id; ?>">

    <?php echo HTMLHelper::_('form.token'); ?>
</form>

    <?php if (empty($this->menu)) : ?>
        <?php
        echo Text::_('COM_JDOCMANUAL_MANUAL_FIRST_FETCH_INDEX');
        ?>
    <?php else : ?>
        <?php include JPATH_SITE . '/components/com_jdocmanual/tmpl/manual/site-layout.php'; ?>
    <?php endif; ?>
<?php endif; ?>
