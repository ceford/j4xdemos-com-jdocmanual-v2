# JDOC Manual

This component displays pages prepared in Markdown format in a Manual
layout with an index of pages to the left, the content of a page in
the centre and the contents of the current page to the right.

It was designed to work with data obtained from the Joomla documentation
site. However, it can work with any documentation source in Markdown format.

For demonstration purposes, Joomla documentation pages relevant to
Joomla 4 and 5 have been converted from Mediawiki format markdown to
GitHub flavoured markdown. The pages are organised into three Manuals
aimed at different types of user:

- The Joomla 4 User Manual
- The Joomla 4 Help Pages
- The Joomla 4 Developer Manual

A method is provided to update the source Markdown files. However,
Updating git repository markdown files uses the PHP exec
function which is unlikely to be allowed on shared hosting.

## Jdocmanual Backward Compatibility

Version 0.10.0 of Jdocmanual is not compatible with previous versions.
Please uninstall any previous version before installing Version 0.10.0 or later.

The post-installation database population method has also changed. The tables
are now built from the Markdown and Text source files.

Note that the major version number is 0, which means this software has
not reached release status. Future changes of minor version may not be
backwards compatible.

## Installation

Jdocmanual requires Joomla 4 or 5. It is best used on a system which
allows command line access. Some functionality will not be available
on shared hosting due to the use of the PHP exec function to commit
changes to git.

## Install git

Git is a version control system available for most platforms. It is
not essential for Jdocmanual and you don't need to know much about
it. Install it if you can. Otherwise see the `workarounds` below.

## Obtain the Markdown data files

In your Downloads folder issue the following command:

```bash
git clone https://github.com/ceford/j4xdemos-data-jdocmanual.git
```

This will create a folder named `j4xdemos-data-jdocmanual`. Move the
folder to somewhere in your file system and rename it to something
simple. It contains a `manuals` folder used by Jdocmanual
to retrieve source files.

The data files can be anywhere in your file system that you have write
access to. It is best not to put the files in your web tree. For
example, you could place the files in `/home/username/data/manuals/`.
The last element of the path must be `/manuals/` with a trailing `/`.

Remember the path to your data folder!

### Non-git Workaround

Go to this url:

```text
https://github.com/ceford/j4xdemos-data-jdocmanual
```

Select the green `Code` button and the `Download ZIP` option.
When downloaded you may unzip it and move it to wherever required.
On a shared hsting system you can upload the zip file, unzip it
there and then move the `manuals` folder to a location outside your
web tree.

Remember the path to your data folder!

## Jdocmanual installation

The Jdocmanual package consists of a component and a plugin. For now
they are installed individually and not as a package. To obtain each,
go to the following sites, select the green Code button and then the
`Download ZIP` option and save the downloads.

```text
https://github.com/ceford/j4xdemos-com-jdocmanual-v2
https://github.com/ceford/j4xdemos-plg-jdocmanualcli
```

The items are installed in the same way as any other component. After
installation select the `Components/Jdocmanual/Manual` menu from the
Administrator menu. You should see a page with Setup instructions.

## Set the Markdown data source location

Select the `Options` button in the Toolbar and enter the absolute
path to your data source in the `Git source` field of the `Settings`
tab. You did remember it!

`Save & Close`

The Setup page should indicate that your data source is set (but
this is not verified).

## Enable the Plugin

To populate the database you need to enable the plg_jdocmanual plugin.
It is not enabled by default as it is only used to populate the database
from the command line.

Go to the list of system plugins, find the Jdocmanual plugin and enable it.

## Database Population - Command Line Method

The database jdm_articles and jdm_menus tables are populated by reading
the data files. This can take a long time - at least a couple of minutes
and perhaps much longer on slow hosts. Proceed as follows:

Open a terminal window and cd into the cli folder within your Joomla
installation root. Here is an example:

```bash
cd /home/username/public_html/optional-path-to-joomla/cli
```

Issue the command to convert data from the markdown source files to HTML
in the #__jdm_articles table of the database:

```bash
php joomla.php jdocmanual:action buildarticles all all
```

Issue the command to create the menus:

```bash
php joomla.php jdocmanual:action buildmenus all all
```

If you encounter **out of memory** problems or **out of time**
problems you can replace the first `all` parameter with a single
manual name, one of `developer`, `help` or `user` and/or the second
`all` parameter with a language code, one of
`de en es fr nl pt pt-br ru`. Using that method you can build the
database manual by manual and/or language by language.

## Database Population - Cron Method

If you do not have access to the command line, common with shared
hosting, you should be able to call these commands from a cron job.
Make sure you give the full path to the php executable, example:

```bash
/usr/local/opt/php@8.1/bin/php /home/username/path/to/joomla/cli/joomla.php \
jdocmanual:action buildarticles all all
```

You need to find out where the php executable is located on your
host operating system.

## Database Population - Import Method

There are two sql.zip files available that you can download and import with
phpMyAdmin. The tables in these files are imported as #__jdm_articles and
#__jdm_menus. You need to delete your existing (empty) tables and rename
the newly imported tables using the database prefix for your site.

The files are available from ...

## Help Proxy Server

If you wish to run your own Help server you can use the following
CLI command to generate Help files:

```bash
php joomla.php jdocmanual:action buildproxy all all
```

The help files will be placed in a folder named `proxy` in the root
of your site. You then need to copy help.css, index.php and
key-index.php from components/com_jdocmanual/proxy to your
site_root/proxy (ToDo: automate this).

Then change the $help url in your configuration.php file to point to
you server. Example:

```php
	public $helpurl = 'https://localhost/path-to-site-root/proxy?keyref=Help{major}{minor}:{keyref}&lang={langcode}';
```

## Test

That is it! Select the Joomla Administrator Components/Jdocmanual/Manual
menu item and expect to see the default Manual selected in English.

## Site Menu

If you want to show the Manuals on the site just create a JDOC Manual
menu item. Note the single page is for search results but it has not
been implemented.

You may wish to place the menu on a page without side modules so that
the full width of the page may be used for content.

## Libraries

Two libraries are included in the component libraries folder.

In the edition that features source management two libraries are
required, one to convert Markdown to HTML and a second to provide
a diff view of proposed changes to source files.

- league/commonmark is used to convert Markdown to HTML.
- jfcherng/php-diff is used to display diffs.

PHP 8.1 is required by ...

## User Groups

If you wish to allow others to help maintain content you need to
create two User Groups:

- **JDM Author**: allowed to edit content in English and other languages.
- **JDM Publisher**: allowed to commit and publish updated content.

The **JDM Author** group should have Public as its parent. The **JDM Publisher**
group should have **JDM Author** as its parent. **JDM Author** should be set
to the Special Viewing Access level.

### Global Options

In the Global Options form select the Permissions tab and then the
**JDM Author** item. Set Administrator login to Allowed.

If you now login as a user in the **JDM Author** group you will see the
Home Dashboard with some modules not relevant for Jdocmanual.

### Turn off the Help menu item

Go to the list of Administrator modules and find the Administrator
Menu module. In the Module tab set the Help Menu item to Hide.

### Unpublish or restrict Access to modules

In the Administrator modules list find the Logged-in Users item used
in the cpanel position (not the cpanel-users position). Either
Unpublish it or set Access to Super Users.

Find and unpublish the Popular Articles and Recently Added Articles
items for the cpanel position (not the cpanel-content position).

There may be other modules needing similar treatment.

The Home Dashboard should now be empty for a **JDM Author**.

### Jdocmanual Options

From the JDOC Manual, Manual page select the Options button. In the
Permissions list select **JDM Author** and set the following to Allowed:
- Access Administration Interface
- Create
- Delete
- Edit

Select **JDM Publisher** and set the following to Allowed:
- Publish

Save and Close

## Who can do what?

**JDM Author** and **JDM Publisher** can login but should only have
access to the the Home Dashboard and the Jdocmanual component.

**JDM Author** does not have access to the Commit button in the
Article Edit page toolbar so cannot update the git repository or
displayed page. Otherwise each can use all other features.

**Manager** and **Administrator** can login but will not see the
Jdocmanual component.

**Author**, **Editor** and **Publisher** do not have access to
the Administrator interface.

**Super Users** have complete access.
