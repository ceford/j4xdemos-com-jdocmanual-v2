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
$stash_edit_route = 'index.php?option=com_jdocmanual&task=articlestash.edit&id=';

?>

<?php echo HTMLHelper::_('uitab.startTabSet', 'myTab', array('active' => 'details', 'recall' => true)); ?>

<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'pages', Text::_('COM_JDOCMANUAL_ARTICLE_TAB_PAGES')); ?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=articlestashes'); ?>"
    method="post" name="adminForm" id="adminForm">
    <div class="row">
        <div class="col-md-12">
            <div id="j-main-container" class="j-main-container">
                <?php echo LayoutHelper::render('joomla.searchtools.default', array('view' => $this)); ?>
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
                                        'JSTATUS',
                                        'a.state',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                </th>
                                <th scope="col" class="text-center">
                                    <?php echo Text::_('COM_JDOCMANUAL_MANUAL_ACTIONS'); ?>
                                </th>
                                <?php if (!empty($language) && $language != 'en') : ?>
                                <th scope="col" class="text-center">
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_TRANSLATED'); ?>
                                </th>
                                <?php endif; ?>
                                <th scope="col">
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'COM_JDOCMANUAL_ARTICLES_DISPLAY_TITLE',
                                        'a.display_title',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'COM_JDOCMANUAL_ARTICLES_MANUAL',
                                        'a.manual',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'COM_JDOCMANUAL_ARTICLES_LANGUAGE',
                                        'a.language',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'COM_JDOCMANUAL_ARTICLES_HEADING',
                                        'a.heading',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'COM_JDOCMANUAL_ARTICLES_FILENAME',
                                        'a.filename',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                </th>
                                <th scope="col">
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'JGRID_HEADING_ID',
                                        'a.id',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php
                            $n = count($this->items);
                        foreach ($this->items as $i => $item) :
                            ?>
                            <tr class="row<?php echo $i % 2; ?>">
                                <td class="text-center">
                                <?php echo HTMLHelper::_('grid.id', $i, $item->id); ?>
                                </td>
                                <td class="text-center text-nowrap">
                                <?php if ($item->nstashes == 0) : ?>
                                        <?php echo $states[$item->state]; ?>
                                <?php else : ?>
                                        <?php echo Text::_('COM_JDOCMANUAL_ARTICLE_STASHES') . ' ' . $item->nstashes; ?>
                                        <?php if ($item->nprs > 0) : ?>
                                            <br>
                                            <?php echo Text::_('COM_JDOCMANUAL_ARTICLE_PRS') . ' ' . $item->nprs; ?>
                                        <?php endif; ?>
                                <?php endif; ?>
                                </td>
                                <td>
                                <?php if (empty($item->stash_id)) {
                                        $action = Text::_('COM_JDOCMANUAL_ARTICLE_NEW_STASH');
                                        $sid = 0;
                                        $soptions = "&language={$language}&eid={$item->id}&trid=";
                                    if (!empty($item->translation_id)) {
                                        $soptions .= $item->translation_id;
                                    }
                                        $style = 'btn-warning';
                                } else {
                                    $action = Text::_('COM_JDOCMANUAL_ARTICLE_EDIT_STASH');
                                    $sid = $item->stash_id;
                                    $soptions = '';
                                    $style = 'btn-success';
                                } ?>
                                    <a href="<?php echo Route::_($stash_edit_route . $sid . $soptions); ?>"
                                    class="btn btn-sm <?php echo $style; ?>">
                                        <?php echo $action; ?>
                                    </a>
                                </td>
                                <?php if (!empty($language) && $language != 'en') : ?>
                                <td class="text-center">
                                    <?php if (!empty($item->translation_id)) : ?>
                                        <span class="icon-publish" aria-hidden="true"></span>
                                    <?php endif; ?>
                                </td>
                                <?php endif; ?>
                                <td>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_INDEX_KEY') . ': ' . $item->display_title; ?>
                                    <br>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_HEADING') . ': ' . $item->heading; ?>
                                    <br>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_FILENAME') . ': ' . $item->filename; ?>
                                </td>
                                <td class="d-none d-md-table-cell">
                                    <?php echo $item->id; ?>
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

<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'newpages', Text::_('COM_JDOCMANUAL_ARTICLE_TAB_NEWPAGES')); ?>
<?php if (empty($this->newpages)) : ?>
                    <div class="alert alert-info">
                        <span class="fa fa-info-circle" aria-hidden="true"></span>
                        <span class="sr-only"><?php echo Text::_('INFO'); ?></span>
                        <?php echo Text::_('JGLOBAL_NO_MATCHING_RESULTS'); ?>
                    </div>
                <?php else : ?>
                    <table class="table" id="gfmList">
                        <thead>
                            <tr>
                                <th scope="col" class="text-center">
                                    <?php echo Text::_('COM_JDOCMANUAL_MANUAL_ACTIONS'); ?>
                                </th>
                                <th scope="col">
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_DISPLAY_TITLE'); ?>,
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_MANUAL'); ?>,
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_LANGUAGE'); ?>,
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_HEADING'); ?>,
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_FILENAME'); ?>
                                </th>
                                <th scope="col">
                                    <?php echo HTMLHelper::_(
                                        'searchtools.sort',
                                        'JGRID_HEADING_ID',
                                        'a.id',
                                        $listDirn,
                                        $listOrder
                                    ); ?>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php
                            $n = count($this->newpages);
                            foreach ($this->newpages as $i => $item) :
                        ?>
                            <tr class="row<?php echo $i % 2; ?>">
                                <td class="text-center">
                                    <?php
                                        $action = Text::_('COM_JDOCMANUAL_ARTICLE_EDIT_STASH');
                                        $sid = $item->id;
                                        $soptions = '';
                                        $style = 'btn-success';
                                    ?>
                                    <a href="<?php echo Route::_($stash_edit_route . $sid . $soptions); ?>"
                                        class="btn btn-sm <?php echo $style; ?>">
                                        <?php echo $action; ?>
                                    </a>
                                </td>
                                <td>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_DISPLAY_TITLE') . ': ' . $item->display_title; ?>
                                    <br>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_MANUAL') . ': ' . $item->manual; ?>,
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_LANGUAGE') . ': ' . $item->language; ?>
                                    <br>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_HEADING') . ': ' . $item->heading; ?>
                                    <br>
                                    <?php echo Text::_('COM_JDOCMANUAL_ARTICLES_FILENAME') . ': ' . $item->filename; ?>
                                </td>
                                <td class="d-none d-md-table-cell">
                                    <?php echo $item->id; ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>

                    <?php // load the pagination. ?>
                    <?php echo $this->pagination->getListFooter(); ?>

                <?php endif; ?>

<?php echo HTMLHelper::_('uitab.endTab'); ?>

<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'mystashes', Text::_('COM_JDOCMANUAL_ARTICLE_TAB_MY_STASHES')); ?>
    <?php if (empty($this->mystashes)) : ?>
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
                        Key
                    </th>
                    <th scope="col">
                        Language
                    </th>
                    <th scope="col">
                        Heading
                    </th>
                    <th scope="col">
                        Filename
                    </th>
                    <th scope="col">
                        PR
                    </th>
                </tr>
            </thead>
            <tbody>
                <?php
                    $n = count($this->mystashes);
                    foreach ($this->mystashes as $i => $stash) :
                ?>
                <tr class="row<?php echo $i % 2; ?>">
                    <td>
                        <a href="<?php echo Route::_($stash_edit_route . $stash->id); ?>">
                    <?php echo $stash->display_title; ?>
                        </a>
                    </td>
                    <td class="text-center">
                    <?php echo $stash->language; ?>
                    </td>
                    <td>
                    <?php echo $stash->heading; ?>
                    </td>
                    <td>
                    <?php echo $stash->filename; ?>
                    </td>
                    <td class="text-center">
                    <?php echo $stash->pr; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
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
                        Key
                    </th>
                    <th scope="col">
                        Language
                    </th>
                    <th scope="col">
                        Heading
                    </th>
                    <th scope="col">
                        Filename
                    </th>
                    <th scope="col">
                        PR
                    </th>
                </tr>
            </thead>
            <tbody>
                <?php
                    $n = count($this->pull_requests);
                foreach ($this->pull_requests as $i => $stash) :
                    ?>
                <tr class="row<?php echo $i % 2; ?>">
                    <td>
                        <a href="<?php echo Route::_($stash_edit_route . $stash->id); ?>">
                        <?php echo $stash->display_title; ?>
                        </a>
                    </td>
                    <td class="text-center">
                    <?php echo $stash->language; ?>
                    </td>
                    <td>
                    <?php echo $stash->heading; ?>
                    </td>
                    <td>
                    <?php echo $stash->filename; ?>
                    </td>
                    <td class="text-center">
                    <?php echo $stash->pr; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
    <?php echo HTMLHelper::_('uitab.endTab'); ?>
<?php endif; ?>

<?php echo HTMLHelper::_('uitab.endTabSet'); ?>
