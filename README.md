# JDOC Manual

This component displays pages obtained from the Joomla documentation 
site. The pages have been converted from Mediawiki format markdown to
GitHub flavoured markdown and then saved as HTML for delivery to end
users. Only pages relevant to Joomla 4 are included. The pages are 
organised into three Manuals aimed at different types of user:

- The Joomla 4 User Manual
- The Joomla 4 Help Pages
- The Joomla 4 Developer Manual

## Installation

The JDOC Manual component may be installed in the same way as any 
other component. However, it needs extra set up to create a working
installation.

**Important:** Updating git repository markdown files uses the PHP exec 
function which is unlikely to be allowed on shared hosting.

### Markdown files

Obtain the Markdown format files and store them in a place outside the
web tree but in a place that can be read by php. This works on linux 
systems:

/home/username/j4docs - place to store the markdown files.
/home/username/public_html - this is your public web tree.

The markdown files are here: https://github.com/ceford/j4xdemos-data-jdocmanual

### Set the Options

With the JDocmanual component installed and Markdown files uploaded,
select the Options button from the GFM Files administrator page.

Set the Git source path to the location on your server where your
markdown files are located. The path should end with manuals/

Set the Update HTML batch size to a suitable value: 100 for shared
hosting or 250 for your own laptop or VPS.

Save & Close

### Populate the database with HTML

In the GFM Files page select the Update HTML button many times! The
Markdown files are converted to HTML and stored in the database in
batches of from 50 to 250. You will see the starting number of the 
batch on each batch.

Keep repeating until the number of fields updated drops to less than
the batch size.

### Build the Menus

In the Menu Headings page, select the Build Menus button in the Toolbar.
This will build the menus in each language for the selected manual. The
default is the User manual.

Select the Help manual and then the Build Menus button.

Select the Developer manual and then the Build Menus button.

## Test

That is it! You should now select the Manual menu item and expect to see
the default Manual selected in English.

## Site Menu

If you want to show the Manuals on the site just create a JDOC Manual
menu item. Note the single page is for search results but it has not 
been implemented.

You may wish to place the menu on a page without side modules so that
the full width of the page may be used for content.

## Libraries

Two libraries are included in the component libraries folder.

In the edition that features source management two libraries are
required, one to convert markdown to html and a second to provide
a diff view of proposed changes to source files.

- league/commonmark is used to convert Markdown to HTML.
- jfcherng/php-diff is used to display diffs.

PHP 8.1 is required by ...

## User Groups

If you wish to allow others to help maintain content you need to 
create two User Groups:

- Translator: allowed to edit content in English and other languages.
- Committer: allowed to commit and publish updated content.

The Translator group should have Public as its parent. The Committer
group should have Translator as its parent. Translator should be set
to the Special Viewing Access level.

### Global Options

In the Global Options form select the Permissions tab and then the
Translator item. Set Administrator login to Allowed.

If you now login as a user in the Translator group you will see the
Home Dashboard with some modules not relevant for Jdocmanual.

### Turn off the Help menu item.

Go to the list of Administrator modules and find the Administrator
Menu module.In the Module tab set the Help Menu item to Hide.

### Unpublish modules

In the Administrator modules list find the Logged-in Users item used
in the cpanel position (not the cpanel-users position). Unpublish it.

Find and unpublish the Popular Articles and Recently Added Articles
items for the cpanel position (not the cpanel-content position).

The Home Dashboard will now be empty for a Translator.

### Jdocmanual Options

From the JDOC Manual, Manual page select the Options button. In the
Permissions list select Translator and set the following to Allowed:
- Access Administration Interface
- Edit

Select Committer and set the following to Allowed:
- Create
- Delete

Save and Close

## Who can do what?

At the moment, a Translator does not have access to the Commit button
In the GFM Edit page toolbar so cannot update the git repository or
displayed page. Otherwise each can use all other features. 

Also, at the moment it is relatively easy to use an existing manual or
create a new one but it is not so easy to change the structure of an
existing manual. That may change in future release.