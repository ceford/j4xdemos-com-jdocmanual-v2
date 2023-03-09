<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_mediacat
 *
 * @copyright   (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

\defined('_JEXEC') or die;

//use Joomla\CMS\Component\ComponentHelper;
//use Joomla\CMS\Factory;
//use Joomla\CMS\Helper\ContentHelper;
use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Layout\LayoutHelper;
//use Joomla\CMS\MVC\View\GenericDataException;
//use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
//use Joomla\CMS\Toolbar\ToolbarHelper;

$wa = $this->document->getWebAssetManager();
$wa->useScript('keepalive')
//	->useStyle('com_jdocmanual.jdocmanual')
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
				<div class="row">
					<div class="col-12 col-lg-9">
						<?php echo $this->form->renderField('page_url'); ?>
						<?php echo $this->form->renderField('index_url'); ?>
						<?php echo $this->form->renderField('id'); ?>
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

		<?php echo HTMLHelper::_('uitab.endTabSet'); ?>
		</div>
	</div>
	<input type="hidden" name="task" value="" />
	<?php echo HTMLHelper::_('form.token'); ?>
</form>