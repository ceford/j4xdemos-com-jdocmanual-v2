<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Layout\LayoutHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

$wa = $this->document->getWebAssetManager();
$wa->useScript('keepalive')
//  ->useStyle('com_jdocmanual.jdocmanual')
    ->useScript('com_jdocmanual.jdocmanual');

?>

<form action="" method="post" name="adminForm" id="adminForm" enctype="multipart/form-data">

    <?php echo LayoutHelper::render('joomla.edit.title_alias', $this); ?>

    <div class="row">
        <div class="col">
        <?php echo HTMLHelper::_('uitab.startTabSet', 'myTab', array('active' => 'details')); ?>

        <?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'details', Text::_('COM_JDOCMANUAL_SOURCE_TAB_DETAILS')); ?>
        <div class="row">
            <div class="col-md-9">
                <?php echo $this->form->renderField('manual'); ?>
                <?php echo $this->form->renderField('heading_ini'); ?>
                <?php echo $this->form->renderField('filename_ini'); ?>
                <?php echo $this->form->renderField('id'); ?>
            </div>
            <div class="col-lg-3">
                <div class="card card-light">
                    <div class="card-body">
                        <?php echo LayoutHelper::render('joomla.edit.global', $this); ?>
                    </div>
                </div>
            </div>
        </div>
        <?php echo HTMLHelper::_('uitab.endTab'); ?>

        <?php echo HTMLHelper::_('uitab.endTabSet'); ?>
        </div>
    </div>
    <input type="hidden" name="task" value="" />
    <?php echo HTMLHelper::_('form.token'); ?>
</form>