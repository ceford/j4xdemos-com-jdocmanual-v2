# JDOC Manual

This component can display pages from a Mediawiki server with
the aid of an index document. For example, you may wish to switch
from Joomla 4 documents to Joomla 3 documents and to see
documents for a custom component delivered by a custom
Mediawiki server. The sources and languages to use are stored
in component database tables. The default installation has indexes
for Joomla 4 and Joomla 4 Help Screens. The indexes need to be
updated regularly.

New in version 0.5: a Site page. Please uninstall any previous
version before installing this new version.

After installation you first need to fetch the index
document by selecting the <strong>Fetch Index</strong> button
in the toolbar. Each time you do this the index is fetched
and stored as html in a new entry in the database. This is
what appears in the component index panel at the left of the
content area.

With the index panel populated you can select an item from
the list. On first selection the page is fetched from the
document server, processed to make it suitable for display
in the JDOC Manual component, and saved in the database.
On a later request for that page it is fetched from the
database.

If you have reason to believe that the page may be out of
date you can select the <strong>Update Page</strong> button
to re-fetch the page from source.

If you want to see the page in a different language you need
to set up the language list and then select the language from
the <strong>Language</strong> button in the toolbar. If the
document is not available in the selected language you will
see the English version with a message to that effect at
the top. You can select the Index language and Document languages
separately but it will be a while before many indexes are
translated.

The version of the page displayed in the Manual differs
from the original as follows:

* Everything above the main content is removed.
* The footer and everything below is removed.
* All links are removed because they do not work as expected
in this context.

If you find a problem with the content of a page you could join
the documentation team and fix it yourself!

## Libraries

In the edition that features source management two libraries are
required, one to convert markdown to html and a second to provide
a diff view of proposed changes to source files.

From the terminal command in administrator/components/com_jdocmanual,
to convert GitHub Flavoured Markdown to HTML:

composer require league/commonmark

and to display a diff view:

composer require jfcherng/php-diff

The scripts create a vendor folder if one does not exist so you
may wish to create a libraries folder and do the installation
there,
