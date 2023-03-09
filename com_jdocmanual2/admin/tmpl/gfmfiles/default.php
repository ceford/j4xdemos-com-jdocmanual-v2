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

/** @var Joomla\CMS\WebAsset\WebAssetManager $wa */
$wa = $this->document->getWebAssetManager();
$wa->useStyle('com_jdocmanual.jdocmanual')
->useScript('com_jdocmanual.jdocmanual');

$listOrder  = $this->escape($this->state->get('list.ordering'));
$listDirn   = $this->escape($this->state->get('list.direction'));

$states = array (
		'0' => Text::_('COM_JDOCMANUAL_GFM_FREE'),
		'1' => Text::_('COM_JDOCMANUAL_GFM_CHECKED_OUT'),
		'2' => Text::_('COM_JDOCMANUAL_GFM_PR_PENDING'),
);

// se the filter language or 'en'
$language = $this->state->get('filter.language') ? : 'en';

?>

<?php echo HTMLHelper::_('uitab.startTabSet', 'myTab', array('active' => 'details', 'recall' => true)); ?>

<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'pages', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_PAGES')); ?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=gfmfiles'); ?>" method="post" name="adminForm" id="adminForm">
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
					<table class="table" id="gfmList">
						<thead>
							<tr>
								<th class="text-center">
									<?php echo HTMLHelper::_('grid.checkall'); ?>
								</th>
								<th scope="col" class="text-center">
									<?php echo HTMLHelper::_('searchtools.sort', 'JSTATUS', 'a.state', $listDirn, $listOrder); ?>
								</th>
								<th scope="col" class="text-center">
									<?php echo Text::_('COM_JDOCMANUAL_JDOCMANUAL_ACTIONS'); ?>
								</th>
								<?php if (!empty($language) && $language != 'en') : ?>
								<th scope="col" class="text-center">
									<?php echo Text::_('COM_JDOCMANUAL_GFM_TRANSLATED'); ?>
								</th>
								<?php endif; ?>
								<th scope="col">
									<?php echo HTMLHelper::_('searchtools.sort', 'COM_JDOCMANUAL_GFM_INDEX_KEY', 'a.jdoc_key', $listDirn, $listOrder); ?>
									<?php echo HTMLHelper::_('searchtools.sort', 'COM_JDOCMANUAL_GFM_PATH', 'a.path', $listDirn, $listOrder); ?>
									<?php echo HTMLHelper::_('searchtools.sort', 'COM_JDOCMANUAL_GFM_FILENAME', 'a.filename', $listDirn, $listOrder); ?>
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
								<td class="text-center text-nowrap">
									<?php if ($item->nstashes == 0) : ?>
										<?php echo $states[$item->state]; ?>
									<?php else : ?>
										<?php echo Text::_('COM_JDOCMANUAL_GFMFILE_STASHES') . ' ' . $item->nstashes; ?>
										<?php if ($item->nprs > 0) : ?>
											<br>
											<?php echo Text::_('COM_JDOCMANUAL_GFMFILE_PRS') . ' ' . $item->nprs; ?>
										<?php endif; ?>
									<?php endif; ?>
								</td>
								<td>
									<?php if(empty($item->stash_id)) {
										$action = Text::_('COM_JDOCMANUAL_GFMFILE_NEW_STASH');
										$sid = 0;
										$soptions = "&language={$language}&eid={$item->id}&trid=";
										if (!empty($item->translation_id)) {
											$soptions .= $item->translation_id;
										}
										$style = 'btn-warning';
									} else {
										$action = Text::_('COM_JDOCMANUAL_GFMFILE_EDIT_STASH');
										$sid = $item->stash_id;
										$soptions = '';
										$style = 'btn-success';
									} ?>
									<a href="<?php echo Route::_('index.php?option=com_jdocmanual&task=gfmfile.edit&id=' . $sid . $soptions); ?>"
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
									<?php echo Text::_('COM_JDOCMANUAL_GFM_INDEX_KEY') . ': ' . $item->jdoc_key; ?>
									<br>
									<?php echo Text::_('COM_JDOCMANUAL_GFM_PATH') . ': ' . $this->escape($item->path); ?>
									<br>
									<?php echo Text::_('COM_JDOCMANUAL_GFM_FILENAME') . ': ' . $this->escape($item->filename); ?>
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

<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'mystashes', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_MY_STASHES')); ?>
	<?php if (empty($this->mystashes)) : ?>
		<div class="alert alert-info">
			<span class="fa fa-info-circle" aria-hidden="true"></span><span class="sr-only"><?php echo Text::_('INFO'); ?></span>
			<?php echo Text::_('JGLOBAL_NO_MATCHING_RESULTS'); ?>
		</div>
	<?php else : ?>
		<table class="table" id="gfmList">
			<thead>
				<tr>
					<th scope="col">
						Language
					</th>
					<th scope="col">
						Key
					</th>
					<th scope="col">
						Path
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
					<td class="text-center">
						<?php echo $stash->language; ?>
					</td>
					<td>
						<a href="<?php echo Route::_('index.php?option=com_jdocmanual&task=gfmfile.edit&id=' . $stash->id); ?>">
						<?php echo $stash->jdoc_key; ?>
						</a>
					</td>
					<td>
						<?php echo $stash->path; ?>
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

<?php echo HTMLHelper::_('uitab.endTabSet'); ?>
