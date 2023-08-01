<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

use Joomla\CMS\Component\ComponentHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

$gfmfiles_path = ComponentHelper::getComponent('com_jdocmanual')->getParams()->get('gfmfiles_path');
if (empty($gfmfiles_path)) {
    $data_path = '<span class="badge bg-warning">is empty</span>';
} else {
    // Does it end with /manuals/
    if (str_ends_with($gfmfiles_path, '/manuals/')) {
        $data_path = '<span class="badge bg-success">is set</span>';
    } else {
        $data_path = '<span class="badge bg-warning">is set but does not end with /manuals/</span>';
    }
}

$plugin_status = array(
    '<span class="badge bg-warning">is absent</span>',
    '<span class="badge bg-warning">is is not enabled</span>',
    '<span class="badge bg-success">is present and enabled</span>'
);

?>

<h2>Set the Markdown data source location</h2>

<p>The data used by Jocmanual are located in source files downloaded from GitHub.
The files can be anywhere in your file system that you have write access to. It is
best not to put the files in your web tree. For example, you could place the files
in <code>/home/username/data/manuals/</code>. The last element of the path must be
<code>/manuals/</code> with a trailing <code>/</code>. Steps:</p>

<ul>
<li>
Install git on your computer (not overed here). </li>
<li>In your Downloads folder issue the following command: <br>
<code>git clone https://github.com/ceford/j4xdemos-data-jdocmanual.git</code><br>
This will create a folder named <code>j4xdemos-data-jdocmanual</code>.
Move the folder to somewhere in your file system and rename it to something
simple. It contains the <code>manuals</code> folder mentioned above. </li>
<li>Remember the path to your data folder.</li>
</ul>

<p>After downloading the data files select the <strong>Options</strong> button
in the Toolbar to set the data path.</p>

<p>Your path: <?php echo $data_path; ?>.</p>

<h2>Install and Enable the Plugin</h2>

<p>To populate the database you need to install the plg_jdocmanual plugin.
This may have been installed with the Jdocmanual package or separately. It
is not enabled by default as it is only used to populate the database
from the command line.
</p>

<p>Go to the list of system plugins, find the Jdocmanul plugin and enable it</p>

<p>Your plugin: <?php echo $plugin_status[$this->plugin_status]; ?>.</p>

<h2>Database Population - Command Line Method</h2>

<p>The database jdm_articles and jdm_menus tables are populated by reading
the the data files. This can take a long time - at least a couple of minutes
and perhaps much longer on slow hosts. Proceed as follows:</p>

<ol>
<li>Open a terminal window and cd into the cli folder within
your Joomla installation root. Here is an example:<br>
<code>cd /home/username/public_html/optional-subfolder/cli</code><br></li>

<li>Issue the command to convert data from the markdown source files to html
in the #__jdm_articles table of the database:<br>
<code>php joomla.php jdocmanual:action buildarticles all all</code></li>

<li>Issue the command to create the menus:<br>
<code>php joomla.php jdocmanual:action buildmenus all all</code></li>
</ol>

<p>If you encounter <strong>out of memory</strong> problems or
<strong>out of time</strong> problems you can replace the first
<code>all</code> parameter with a single manual name, one of
<code>developer</code>, <code>help</code> or <code>user</code>
and/or the second <code>all</code> parameter with a language code,
one of <code>de en es fr nl pt pt-br ru</code>. Using that method
you can build the database manual by manual and/or language by
language.</p>

<h2>Database Population - Cron Method</h2>

<p>If you do not have access to the command line, common with shared
hosting, you should be able to call these commands from a cron job.
Make sure you give the full path to the php executable, example: <br>
<code>/usr/local/opt/php@8.1/bin/php</code><br>
You need to find out where the php executable is located on your
host operating system. </p>

<h2>Database Population - Import Method</h2>

<p>The Jdocmanual repository includes two sql.zip files that you can download
and import with phpMyAdmin. They are in the resources folder. The tables in
these files are imported as #__jdm_articles and #__jdm_menus. You need to
delete your existing (empty) tables and rename the newly imported tables
using the database prefix for your site.

