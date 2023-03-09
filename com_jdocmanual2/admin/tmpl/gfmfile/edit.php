<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_mediacat
 *
 * @copyright   (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

\defined('_JEXEC') or die;

use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Layout\LayoutHelper;
use Joomla\CMS\Router\Route;

$wa = $this->document->getWebAssetManager();
$wa->useScript('keepalive')
	->useScript('com_jdocmanual.jdocmanual');
// Register and attach a custom item in one run
//$wa->registerAndUseStyle('diff-table', 'com_jdocmanual/css/diff-table.css', [], [], []);
$wa->useStyle('com_jdocmanual.diff-table');

$wa->registerAndUseStyle('pp', 'https://cdn.jsdelivr.net/npm/prismjs@1/themes/prism-okaidia.min.css', [], [], []);
$wa->registerAndUseStyle('pln', 'https://cdn.jsdelivr.net/npm/prismjs@1/plugins/line-numbers/prism-line-numbers.min.css', [], [], []);

$wa->registerAndUseScript('prism','https://cdn.jsdelivr.net/npm/prismjs@1/prism.min.js', [], ['defer' => true], []);
$wa->registerAndUseScript('prism-diff','https://cdn.jsdelivr.net/npm/prismjs@1/components/prism-diff.min.js', [], ['defer' => true], []);
$wa->registerAndUseScript('prism-json','https://cdn.jsdelivr.net/npm/prismjs@1/components/prism-json.min.js', [], ['defer' => true], []);
$wa->registerAndUseScript('prism-ln','https://cdn.jsdelivr.net/npm/prismjs@1/plugins/line-numbers/prism-line-numbers.min.js', [], ['defer' => true], []);

?>

<form action="<?php echo Route::_('index.php?option=com_jdocmanual&view=gfmfile&layout=edit&id=' . (int) $this->item->id); ?>" method="post" name="adminForm" id="adminForm">

	<?php echo LayoutHelper::render('joomla.edit.title_alias', $this); ?>

	<div class="row">
		<div class="col">
		<?php echo HTMLHelper::_('uitab.startTabSet', 'myTab', array('active' => 'details', 'recall' => true)); ?>

		<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'details', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_DETAILS')); ?>
		<div class="row">
			<div class="col-md-9">
				<div class="row">
					<div class="col-12 col-lg-9">
						<?php echo $this->form->renderField('display_title'); ?>
						<?php echo $this->form->renderField('jdoc_key'); ?>
						<?php echo $this->form->renderField('path'); ?>
						<?php echo $this->form->renderField('filename'); ?>
						<?php echo $this->form->renderField('id'); ?>
						<?php echo $this->form->renderField('page_id'); ?>
						<?php echo $this->form->renderField('language'); ?>
					</div>
				</div>
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

		<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'source', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_SOURCE')); ?>
		<div id="preview-area">
			<?php echo $this->form->renderField('source'); ?>
		</div>
		<?php echo HTMLHelper::_('uitab.endTab'); ?>

		<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'stash', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_STASH')); ?>
		<div id="preview-area">
			<?php echo $this->form->renderField('markdown_text'); ?>
		</div>
		<?php echo HTMLHelper::_('uitab.endTab'); ?>

		<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'preview', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_PREVIEW')); ?>
			<?php echo $this->preview; ?>
		<?php echo HTMLHelper::_('uitab.endTab'); ?>

		<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'diff', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_DIFF')); ?>
			<?php if (!empty($this->diff)) : ?>
			<?php echo $this->diff; ?>
			<?php else : ?>
			<div class="alert alert-warning">
				<?php echo Text::_('COM_JDOCMANUAL_GFMFILE_TAB_DIFF_EMPTY'); ?>
			</div>
				<?php endif; ?>
		<?php echo HTMLHelper::_('uitab.endTab'); ?>

		<?php echo HTMLHelper::_('uitab.addTab', 'myTab', 'comments', Text::_('COM_JDOCMANUAL_GFMFILE_TAB_COMMENTS')); ?>
			<?php echo $this->form->renderField('commit_message'); ?>
			<?php echo $this->form->renderField('comments'); ?>
		<?php echo HTMLHelper::_('uitab.endTab'); ?>

		<?php echo HTMLHelper::_('uitab.endTabSet'); ?>
		</div>
	</div>
	<input type="hidden" name="task" value="" />
	<?php echo HTMLHelper::_('form.token'); ?>
</form>