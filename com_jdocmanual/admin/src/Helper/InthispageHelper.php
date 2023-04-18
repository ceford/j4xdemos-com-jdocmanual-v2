<?php
/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Helper;

\defined('_JEXEC') or die;

use Joomla\CMS\Language\Text;

class InthispageHelper {

	public static function doToc($html) {
		// The commonmark menu position feature does not work.
		// So extract it here from the 'top' position.
		$dom = new \DOMDocument('1.0', 'utf-8');
		// DOMDocument::loadHTML will treat your string as being in ISO-8859-1.
		$dom->loadHTML('<?xml encoding="utf-8" ?>' . $html);
		$uls = $dom->getElementsByTagName('ul');
		$in_this_page = $dom->saveHTML($uls->item(0));
		$content = $uls[0]->parentNode->removeChild($uls[0]);
		$content = $dom->saveHTML();
		$in_this_page = '<h2 class="toc">' . Text::_('COM_JDOCMANUAL_JDOCMANUAL_TOC_IN_THIS_ARTICLE') . '</h2>' . "\n" . $in_this_page;
		return array($in_this_page, $content);
	}
}