<?php

/**
 * @package     Jdocmanual
 * @subpackage  Site
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

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

?>
<?php if (!empty($this->page)) : ?>
<h1><?php echo str_replace('_', ' ', $this->page->jdoc_key);?></h1>
    <?php echo $this->page->content; ?>
<?php endif; ?>

<p>A page for search results - not yet implemented.</p>

<details class="jdm">
    <summary>Getting Started</summary>
    <ul>
        <li id="article-1">
            <a href="index.php?option=com_jdocmanual&id=1" class="content-link"
            data-content-id="J4.x:Introduction_to_Joomla!">
                Introduction to Joomla!
            </a>
        </li>
    </ul>
</details>
