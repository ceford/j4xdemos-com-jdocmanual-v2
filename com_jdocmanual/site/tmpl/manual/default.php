<?php

/**
 * @package     Jdocmanual
 * @subpackage  Site
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

use Joomla\CMS\Factory;
use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Router\Route;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/** @var Joomla\CMS\WebAsset\WebAssetManager $wa */
$wa = $this->document->getWebAssetManager();
$wa->useStyle('com_jdocmanual.jdocmanual')
->useScript('com_jdocmanual.jdocmanual');
//->addInlineScript($scripts);

//$wa->registerAndUseStyle('jdocmanual-site', 'com_jdocmanual/jdocmanual-site.css', [], [], []);

Text::script('COM_JDOCMANUAL_MANUAL_TOC_IN_THIS_PAGE', true);

$proxy = false;

//HTMLHelper::_('formbehavior.chosen', 'select');
HTMLHelper::_('bootstrap.dropdown', 'select', []);
HTMLHelper::_('bootstrap.collapse');

$app = Factory::getApplication();
$sitemenu = $app->getMenu();
$activeMenuitem = $sitemenu->getActive();

?>

<?php $this->addToolbar(); ?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=manual&Itemid=' . $activeMenuitem->id); ?>"
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
    <h1><?php echo $this->source->title; ?></h1>

    <?php include 'site-layout.php'; ?>
<?php endif; ?>

