<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

use Joomla\CMS\Language\Text;
use Joomla\CMS\HTML\HTMLHelper;

HTMLHelper::_('bootstrap.offcanvas', '.offcanvas', []);

?>

<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
	<div class="offcanvas-header">
		<h5 class="offcanvas-title" id="offcanvasExampleLabel">Manual Index</h5>
		<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<div id="offcanvasMenu">
		</div>
	</div>
</div>

	<div class="row">
		<div class="col-12 col-sm-3 g-0 d-none d-sm-block" id="index-panel">
			<div id="oncanvasMenu">
			<nav id="jdocmanual-wrapper" aria-label="JDOC Manual Menu" class="">
				<h2 class="toc">Index of Articles</h2>
				<?php echo $this->menu->menu; ?>
			</nav>
			</div>
		</div>
		<div class="col-12 col-md-6" id="page-panel">
			<div class="row">
				<div class="col document-title pb-1">
					<button class="btn btn-secondary btn-sm d-bloc d-sm-none float-start me-2 mt-2" type="button"
					data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample"
					aria-controls="offcanvasExample">
					Index
					</button>
					<h2 id="document-title">
					<?php echo $this->display_title; ?>
					<?php //echo Text::_('COM_JDOCMANUAL_JDOCMANUAL_DOCUMENT_TITLE'); ?>
					</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-md-9" id="document-panel" tabindex="0">
					<?php echo $this->page_content; ?>
				</div>
				<div class="col-12 col-md-3 d-none d-lg-block" id="toc-panel">
					<h2 class="toc">In this Article</h2>
					<?php echo $this->in_this_page; ?>
				</div>
			</div>
		</div>
	</div>
