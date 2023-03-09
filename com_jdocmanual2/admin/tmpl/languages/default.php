<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Layout\LayoutHelper;
use Joomla\CMS\Router\Route;
$params = ComponentHelper::getParams('com_jdocmanual');

/** @var Joomla\CMS\WebAsset\WebAssetManager $wa */
$wa = $this->document->getWebAssetManager();
$wa->useStyle('com_jdocmanual.jdocmanual')
->useScript('com_jdocmanual.jdocmanual');

$listOrder  = $this->escape($this->state->get('list.ordering'));
$listDirn   = $this->escape($this->state->get('list.direction'));

$states = array (
		'0' => Text::_('JUNPUBLISHED'),
		'1' => Text::_('JPUBLISHED'),
		'2' => Text::_('JARCHIVED'),
		'-2' => Text::_('JTRASHED')
);

?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=sources'); ?>" method="post" name="adminForm" id="adminForm">
	<div class="row">
		<div class="col-md-12">
			<div id="j-main-container" class="j-main-container">
				<?php echo LayoutHelper::render('joomla.searchtools.default', array('view' => $this)); ?>
				<?php if (empty($this->items)) : ?>
					<div class="alert alert-info">
						<span class="fa fa-info-circle" aria-hidden="true"></span><span class="sr-only"><?php echo Text::_('INFO'); ?></span>
						<?php echo Text::_('JGLOBAL_NO_MATCHING_RESULTS'); ?>
					</div>
				<?php else : ?>
					<table class="table" id="jdocmanualList">
						<thead>
							<tr>
								<th class="text-center">
									<?php echo HTMLHelper::_('grid.checkall'); ?>
								</th>
								<th scope="col">
									<?php echo HTMLHelper::_('searchtools.sort', 'JSTATUS', 'a.state', $listDirn, $listOrder); ?>
								</th>
								<th scope="col">
									<?php echo HTMLHelper::_('searchtools.sort', 'JGLOBAL_TITLE', 'a.title', $listDirn, $listOrder); ?>
								</th>
								<th scope="col" class="text-center">
									<?php echo HTMLHelper::_('searchtools.sort', 'COM_JDOCMANUAL_LANGUAGES_CODE', 'a.code', $listDirn, $listOrder); ?>
								</th>
								<th scope="col" class="text-center">
									<?php echo HTMLHelper::_('searchtools.sort', 'COM_JDOCMANUAL_LANGUAGE_INDEX_LABEL', 'a.index_language', $listDirn, $listOrder); ?>
								</th>
								<th scope="col" class="text-center">
									<?php echo HTMLHelper::_('searchtools.sort', 'COM_JDOCMANUAL_LANGUAGE_PAGE_LABEL', 'a.page_language', $listDirn, $listOrder); ?>
								</th>
								<th scope="col">
									<?php echo HTMLHelper::_('searchtools.sort', 'JGRID_HEADING_ID', 'a.id', $listDirn, $listOrder); ?>
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
								<td class="class="article-status"">
									<?php echo $states[$item->state]; ?>
								</td>
								<td scope="row" class="has-context">
									<a href="<?php echo Route::_('index.php?option=com_jdocmanual&task=language.edit&id=' . $item->id); ?>">
										<?php echo $this->escape($item->title); ?>
									</a>
								</td>
								<td class="text-center">
									<?php echo $item->code; ?>
								</td>
								<td class="text-center">
									<?php echo $item->index_language ? Text::_('JYES') : Text::_('JNO'); ?>
								</td>
								<td class="text-center">
									<?php echo $item->page_language ? Text::_('JYES') : Text::_('JNO'); ?>
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

</form>
