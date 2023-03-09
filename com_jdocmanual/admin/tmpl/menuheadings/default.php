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
->useScript('com_jdocmanual.menuheadings');

$listOrder  = $this->escape($this->state->get('list.ordering'));
$listDirn   = $this->escape($this->state->get('list.direction'));
$filter_language = $this->state->get('filter.language');

?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=menuheadings'); ?>" method="post" name="adminForm" id="adminForm">
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
								<th>
									Manual
								</th>
								<th>
									Heading
								</td>
								<th>
									Language
								</td>
								<th scope="col">
									Display Title
								</th>
								<?php if (strcmp($filter_language, 'en') !== 0) : ?>
								<th>
									Language
								</td>
								<th scope="col">
									Display Title
								</th>
								<?php endif; ?>

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
								<td class="">
									<?php echo $item->manual; ?>
								</td>
								<td class="">
									<?php echo $item->heading; ?>
								</td>
								<td class="">
									<?php echo $item->language; ?>
								</td>
								<td class="">
									<input type="text" id="heading_<?php echo $item->id; ?>" 
									class="fix-heading" value="<?php echo $item->display_title; ?>" />
								</td>

								<?php if (strcmp($filter_language, 'en') !== 0) : ?>
								<td class="">
									<?php echo $filter_language; ?>
								</td>
								<td class="">
									<input type="text" 
									id="heading_<?php echo empty($item->translation_id) ? 0 : $item->translation_id; ?>" 
									data-original_id="<?php echo $item->id; ?>"
									data-filter_language="<?php echo $filter_language; ?>"
									class="fix-heading" 
									value="<?php echo $item->translation_display_title; ?>" 
									/>
								</td>
								<?php endif; ?>

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
