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
->useScript('com_jdocmanual.jdocmanual');

$listOrder  = $this->escape($this->state->get('list.ordering'));
$listDirn   = $this->escape($this->state->get('list.direction'));

$states = array (
        '0' => Text::_('COM_JDOCMANUAL_ARTICLES_FREE'),
        '1' => Text::_('COM_JDOCMANUAL_ARTICLES_CHECKED_OUT'),
        '2' => Text::_('COM_JDOCMANUAL_ARTICLES_PR_PENDING'),
);

// Use the filter language or 'en'
$language = $this->state->get('filter.language') ? : 'en';
$user  = Factory::getUser();

$menustash_edit_route = 'index.php?option=com_jdocmanual&task=menustash.edit&id=';

?>

<?php echo HTMLHelper::_('uitab.startTabSet', 'myTab', array('active' => 'details', 'recall' => true)); ?>

<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'pages', Text::_('COM_JDOCMANUAL_MENUSTASHES_TAB_MANUALS')); ?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=menustashes'); ?>"
    method="post" name="adminForm" id="adminForm">
    <div class="row">
        <div class="col-md-12">
            <div id="j-main-container" class="j-main-container">
                <?php //echo LayoutHelper::render('joomla.searchtools.default', array('view' => $this)); ?>
                <?php if (empty($this->items)) : ?>
                    <div class="alert alert-info">
                        <span class="fa fa-info-circle" aria-hidden="true"></span>
                        <span class="sr-only"><?php echo Text::_('INFO'); ?></span>
                        <?php echo Text::_('JGLOBAL_NO_MATCHING_RESULTS'); ?>
                    </div>
                <?php else : ?>
                    <table class="table" id="gfmList">
                        <thead>
                            <tr>
                                <th class="text-center">
                                    <?php echo HTMLHelper::_('grid.checkall'); ?>
                                </th>
                                <th scope="col" class="text-center">
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'COM_JDOCMANUAL_ARTICLES_MANUAL',
                                        'a.manual',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                </th>
                                <th scope="col" class="text-center">
                                    <?php echo Text::_('COM_JDOCMANUAL_MANUAL_ACTIONS'); ?>
                                </th>
                                <th scope="col" class="text-center">
                                    <?php echo Text::_('COM_JDOCMANUAL_MENUSTASHES_NSTASHES'); ?>
                                </th>
                                <th scope="col" class="text-center">
                                    <?php echo Text::_('COM_JDOCMANUAL_MENUSTASHES_NPRS'); ?>
                                </th>
                                <th scope="col" class="text-center">
                                    Stash ID
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php
                        foreach ($this->items as $i => $item) :
                            ?>
                            <tr class="row<?php echo $i % 2; ?>">
                                <td class="text-center">
                            <?php echo HTMLHelper::_('grid.id', $i, $item->id); ?>
                                </td>
                                <td class="text-center">
                                <?php echo $item->manual; ?>
                                </td>
                                <td class="text-center">
                            <?php if (empty($item->stash_id) || $item->user_id != $user->id) {
                                        $action = Text::_('COM_JDOCMANUAL_ARTICLE_NEW_STASH');
                                        $sid = 0;
                                        $style = 'btn-warning';
                            } else {
                                $action = Text::_('COM_JDOCMANUAL_ARTICLE_EDIT_STASH');
                                $sid = $item->menustash_id;
                                $style = 'btn-success';
                            } ?>
                                    <a href="<?php echo Route::_($menustash_edit_route .
                                    $sid . '&manual=' . $item->manual); ?>"
                                    class="btn btn-sm <?php echo $style; ?>">
                                        <?php echo $action; ?>
                                    </a>
                                </td>
                                <td class="text-center">
                                    <?php echo $item->nstashes; ?>
                                </td>
                                <td class="text-center">
                                    <?php echo $item->nprs; ?>
                                </td>
                                <td class="d-none d-md-table-cell text-center">
                                    <?php echo $item->stash_id; ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>

                    <?php // load the pagination. ?>
                    <?php echo $this->pagination->getListFooter(); ?>

                <?php endif; ?>
                <input type="hidden" name="task" value="">
                <input type="hidden" name="boxchecked" value="0">
                <?php echo HTMLHelper::_('form.token'); ?>
            </div>
        </div>
    </div>
    <?php echo HTMLHelper::_('uitab.endTab'); ?>

</form>
<?php echo HTMLHelper::_('uitab.endTab'); ?>

<?php if ($user->authorise('core.admin', 'com_jdocmanual') || $user->authorise('core.options', 'com_jdocmanual')) : ?>
    <?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'prs', Text::_('COM_JDOCMANUAL_ARTICLE_TAB_PULL_REQUESTS')); ?>
    <?php if (empty($this->pull_requests)) : ?>
        <div class="alert alert-info">
            <span class="fa fa-info-circle" aria-hidden="true"></span>
            <span class="sr-only"><?php echo Text::_('INFO'); ?></span>
                <?php echo Text::_('JGLOBAL_NO_MATCHING_RESULTS'); ?>
        </div>
    <?php else : ?>
        <table class="table" id="gfmList">
            <thead>
                <tr>
                    <th scope="col">
                        Manual
                    </th>
                    <th scope="col">
                        Action
                    </th>
                    <th scope="col">
                        Stash ID
                    </th>
                    <th scope="col">
                        User ID
                    </th>
                </tr>
            </thead>
            <tbody>
                <?php
                foreach ($this->pull_requests as $i => $stash) :
                    ?>
                <tr class="row<?php echo $i % 2; ?>">
                    <td>
                    <?php echo $stash->manual; ?>
                    </td>
                    <td>
                        <a href="<?php echo Route::_('index.php?option=com_jdocmanual&task=menustash.edit&id=' .
                        $stash->id . '&manual=' . $item->manual); ?>"
                            class="btn btn-sm btn-success">
                            Review
                        </a>
                    </td>
                    <td>
                        <?php echo $stash->id; ?>
                    </td>
                    <td>
                        <?php echo $stash->user_id; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
    <?php echo HTMLHelper::_('uitab.endTab'); ?>
<?php endif; ?>

<?php echo HTMLHelper::_('uitab.endTabSet'); ?>
