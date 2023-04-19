<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\FormController;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use Joomla\Database\ParameterType;
use Joomla\Utilities\ArrayHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\Markdown2html;

/**
 * Controller for a single source
 *
 * @since  1.6
 */
class MenuheadingsController extends FormController
{
	protected $text_prefix = 'COM_JDOCMANUAL_GFMFILES';
	protected $app;
    protected $nitems = 0;
    protected $titems = 0;
	protected $menu = [];

	/**
	 * Update a heading display_title with Javascript call from Menu Headings list
	 * 
	 */
	public function update() {
		Session::checkToken( 'get' ) or die( 'Is your session expired? Try a page reload!'); //|Invalid Token' );
		$app = Factory::getApplication();
		$db = Factory::getDbo();

		$field = $app->input->get('field', '', 'string');
		$display_title = $app->input->get('value', '', 'string');
		$item_id = $app->input->get('item_id', 0, 'int');
		if (empty($item_id)) {
			// If the item it is 0 this must be a new item and there should be an original id.
			$original_id = $app->input->get('original_id', 0, 'int');
			// Check this is really a translation.
			if (empty($original_id)) {
				die( 'NOT OK: No original id!');
			}
			$language = $app->input->get('language', '', 'string');
			if (empty($language)) {
				die( 'NOT OK: No language!');
			}

			// Get data from the original id.
			$query = $db->getQuery(true);
			$query->select($db->quoteName(array('manual', 'heading')))
			->from($db->quoteName('#__jdocmanual_menu_headings'))
			->where('id = :id')
			->bind(':id', $original_id, ParameterType::INTEGER);
			$db->setQuery($query);
			$row = $db->loadObject();

			// Make a new entry.
			$query = $db->getQuery(true);
			$query->insert($db->quoteName('#__jdocmanual_menu_headings'))
			->set($db->quoteName('manual') . ' = :manual')
			->set($db->quoteName('language') . ' = :language')
			->set($db->quoteName('heading') . ' = :heading')
			->set($db->quoteName('display_title') . ' = :display_title')
			->bind(':manual', $row->manual, ParameterType::STRING)
			->bind(':language', $language, ParameterType::STRING)
			->bind(':heading', $row->heading, ParameterType::STRING)
			->bind(':display_title', $display_title, ParameterType::STRING);
			$db->setQuery($query);
			$result = $db->execute();
			$last_insert = $db->insertid();
			exit('OK 2:' . $last_insert);
		}
		$query = $db->getQuery(true);
		$query->update($db->quoteName('#__jdocmanual_menu_headings'))
		->set($db->quoteName('display_title') . ' = :display_title')
		->where('id = :id')
		->bind(':display_title', $display_title, ParameterType::STRING)
		->bind(':id', $item_id, ParameterType::INTEGER);
		$db->setQuery($query);
		$result = $db->execute();
		exit('OK 1: ' . $result);
	}

	/**
	 * The menu list is stored in md form in the sources table. Edit 
	 * with the sources form. Let the menu be converted to an array,
	 * the first item in each is the heading.
	 * array(36) {
	 * [0]=>
	 *		array(13) {
     *		[0]=>
     * 		string(15) "getting-started"
     * 		[1]=>
     * 		string(28) "J4.x:Introduction_to_Joomla!"
     *		[2]=>
     *		string(25) "J4.x:Joomla_Core_Features"
	 */

    public function buildmenu()
    {
        // Get some the currently selected manual.
        $manual = $this->app->input->get('filter')['manual'];

		// Get the menu in markdown format.
        $db = Factory::getDbo();
        $query = $db->getQuery(true);
		$query->select($db->quoteName('mdmenu'))
		->from($db->quoteName('#__jdocmanual_sources'))
		->where($db->quoteName('manual') . ' = :manual')
		->bind(':manual', $manual, ParameterType::STRING);
		$db->setQuery($query);
		$menu = $db->loadResult();

		// Split the menu into lines.
		$lines = preg_split("/((\r?\n)|(\r\n?))/", $menu);
		$count = count($lines);
		$count_headings = -1;
		$count_articles = 0;
		$heading_pattern = '/#{1,}\s{1,}(.*)/';
		$article_pattern = '/-{1,}\s{1,}(.*)/';
		foreach ($lines as $line){
			// If the line starts with ### start a new accordion
			if (preg_match($heading_pattern, $line, $matches)) {
				$count_headings += 1;
				// if the user put a space rather than menus, change it.
				$matches[1] = trim($matches[1]);
				$matches[1] = str_replace(' ', '-', $matches[1]);
				$this->menu[$count_headings][] = $matches[1];
			}
			// if the line starts with a - add it to the current accordion.
			if (preg_match($article_pattern, $line, $matches)) {
				// if the user put a space rather than underline, change it.
				$matches[1] = trim($matches[1]);
				$matches[1] = str_replace(' ', '_', $matches[1]);
				array_push($this->menu[$count_headings], $matches[1]);
				$count_articles += 1;
			}
		}

		// Get a list of languages.
		$query = $db->getQuery(true);
		$query->select($db->quoteName('code'))
		->from($db->quoteName('#__jdocmanual_languages'))
		->where($db->quoteName('state') . ' = 1')
		->order($db->quoteName('id'));
		$db->setQuery($query);
		$languages = $db->loadObjectList();
		$nspattern = array('J4.x:', 'Help4.x:');
		$man = ucwords($manual);
		$summary_text = "{$man} manual, number of articles translated in each language:<br>\n";

		foreach ($languages as $language) {
			$html = '';
			// Make a copy of the base menu for translation.
			$menuitems = $this->menu;
			$total_items = 0;
			$total_translated = 0;
			foreach ($menuitems as $accordionid => $menuitem) {
				// Get the translation for the heading - the first item in the array
				$query = $db->getQuery(true);
				$query->select($db->quoteName('display_title'))
				->from($db->quoteName('#__jdocmanual_menu_headings'))
				->where($db->quoteName('manual') . ' = :manual')
				->where($db->quoteName('language') . ' = :language')
				->where($db->quoteName('heading') . ' = :heading')
				->bind(':manual', $manual, ParameterType::STRING)
				->bind(':language', $language->code, ParameterType::STRING)
				->bind(':heading', $menuitem[0], ParameterType::STRING);
				$db->setQuery($query);
				$display_title = $db->loadResult();

				if (empty($display_title)) {
					// In case there is no translation available.
					$display_title = str_replace('_', ' ', $menuitem[0]);
					$display_title = ucwords($display_title);
					if ($language->code == 'en') {
						// Make a new entry in the #__jdocmanual_menu_headings table.
						$query = $db->getQuery(true);
						$query->insert($db->quoteName('#__jdocmanual_menu_headings'))
						->set($db->quoteName('manual') . ' = :manual')
						->set($db->quoteName('language') . ' = ' . $db->quote('en'))
						->set($db->quoteName('heading') . ' = :heading')
						->set($db->quoteName('display_title') . ' = :display_title')
						->bind(':manual', $manual, ParameterType::STRING)
						->bind(':heading', $menuitem[0], ParameterType::STRING)
						->bind(':display_title', $display_title, ParameterType::STRING);
						$db->setQuery($query);
						$db->execute();
						$summary_text .= "English item added for heading: {$menuitem[0]}<br>\n";
					}
				}
				// Output an accordion heading.
				$html .= $this->accordion_start($accordionid, $display_title);

				// The rest of the array contains jdoc_key values.
				foreach ($menuitem as $i => $article) {
					if ($i == 0) {
						continue;
					}
					// Get the menu data in English.
					$query = $db->getQuery(true);
					$query->select($db->quoteName(array('id', 'jdoc_key', 'display_title')))
					->from($db->quoteName('#__jdocmanual_gfmindex'))
					->where($db->quoteName('language') . ' = ' . $db->quote('en'))
					->where($db->quoteName('jdoc_key') . ' = :jdoc_key')
					->bind(':jdoc_key', $article, ParameterType::STRING);
					$db->setQuery($query);
					$row = $db->loadObject();
					$display_title = $row->display_title;
					$gfmfile_id = $row->id;
					$jdoc_key = $row->jdoc_key;

					// If there is no English original create a new entry.
					if (empty($row)) {
						$display_title = str_replace('_', ' ', $article);
						$display_title = ucwords($display_title);
						$display_title = str_replace($nspattern, '', $display_title);
						// If the language is English create an entry in #__jdocmanual_gfmindex here.
						$heading = $menuitem[0];
						$filename = str_replace('_', '-', $article);
						$filename = strtolower($filename) . '.md';
						$query = $db->getQuery(true);
						$query->insert($db->quoteName('#__jdocmanual_gfmindex'))
							->set($db->quoteName('jdoc_key') . ' = :jdoc_key')
							->set($db->quoteName('manual') . ' = :manual')
							->set($db->quoteName('language') . ' = ' . $db->quote('en'))
							->set($db->quoteName('heading') . ' = :heading')
							->set($db->quoteName('filename') . ' = :filename')
							->set($db->quoteName('display_title') . ' = :display_title')
							->bind(':jdoc_key', $article, ParameterType::STRING)
							->bind(':manual', $manual, ParameterType::STRING)
							->bind(':heading', $heading, ParameterType::STRING)
							->bind(':filename', $filename, ParameterType::STRING)
							->bind(':display_title', $display_title, ParameterType::STRING);
						echo "{$article}/{$manual}/{$heading}/{$filename}/{$display_title} " . $query->__tostring();die();
						$db->setQuery($query);
						$db->execute();
						$summary_text .= "English item added for file: {$filename}<br>\n";
						$gfmfile_id = $db->insertid();
					}

					// If the language is not English try to get display data in the selected language.
					if ($language->code != 'en') {
						$query = $db->getQuery(true);
						$query->select($db->quoteName(array('id', 'jdoc_key', 'display_title')))
						->from($db->quoteName('#__jdocmanual_gfmindex'))
						->where($db->quoteName('language') . ' = :language')
						->where('jdoc_key = :jdoc_key')
						->bind(':language', $language->code, ParameterType::STRING)
						->bind(':jdoc_key', $article, ParameterType::STRING);
						$db->setQuery($query);
						$row = $db->loadObject();
						if (!empty($row)) {
							$display_title = $row->display_title;
							$none_englis_gfmfile_id = $row->id;
							$jdoc_key = $row->jdoc_key;
							$total_translated += 1;
						}
					} else {
						$total_translated += 1;
					}
					$total_items += 1;

					// Add the article to the menu.
					$html .= $this->accordion_item($article, $display_title, $gfmfile_id, $jdoc_key);
				}
				$html .= $this->accordion_end();
			}
			$summary_text .= "{$language->code}: {$total_translated}/{$total_items}<br>\n";
			$this->save_menu($db, $manual, $language->code, $html);
		}
		$this->app->enqueueMessage("{$summary_text}", 'success');
		$this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=menuheadings', false));
	}

	protected function save_menu($db, $manual, $language, $html) {
        // Check if there is a menu for this manual and language
        $query = $db->getQuery(true);
        $query->select($db->quoteName('id'))
            ->from($db->quoteName('#__jdocmanual_menu'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = :language')
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING);
        $db->setQuery($query);
        $id = $db->loadResult();

        $query = $db->getQuery(true);
        if (empty($id)) {
            // Use an insert query.
            $query->insert($db->quoteName('#__jdocmanual_menu'));
        } else {
            // Use an update query.
            $query->update($db->quoteName('#__jdocmanual_menu'))
                ->where($db->quoteName('id') . ' = ' . $id);
        }

        $query->set($db->quoteName('manual') . ' = :manual')
            ->set($db->quoteName('language') . ' = :language')
            ->set($db->quoteName('menu') . ' = :menu')
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':menu', $html, ParameterType::STRING);
        $db->setQuery($query);
        $db->execute();
    }

    protected function accordion_start ($id, $label)
	{
		$html = "<details class=\"jdm\">\n<summary>{$label}</summary>\n<ul>\n";
		return $html;

		$html =<<<EOF
<div class="accordion-item">
<a href="#" class="accordion-header accordion-button jdocmenu-item" id="item_{$id}" data-bs-toggle="collapse" data-bs-target="#collapse_{$id}" aria-expanded="false" aria-controls="collapse_{$id}">
{$label}
</a>
<div id="collapse_{$id}" class="accordion-collapse collapse" aria-labelledby="item_{$id}" data-bs-parent="#accordionJdoc">
<div class="jdocmanual-accordion-body">
<ul>
EOF;
		return $html;
	}

	protected function accordion_end ()
	{
		return "\n</ul>\n</details>\n"; //</div>\n</div>\n</div>\n";
	}

	protected function accordion_item($link, $value, $gfmfile_id, $jdoc_key)
	{
		// escape any " character in the link
		$link = str_replace('"', '', $link);
		$html = ''; //'<li><span class="icon-file-alt icon-fw icon-jdocmanual" aria-hidden="true"></span>';
		// Including the view here causes the sef router not to break!
		$route = 'index.php?option=com_jdocmanual&id=' . $gfmfile_id;
		$html .= '<li id="gfmfile-' . $gfmfile_id . '">';
		$html .= '<a href="' . $route . '" class="content-link" data-content-id="' . $jdoc_key . '">';
		$html .= $value . '</a></li>' . "\n";
		return $html;
	}

    public function updatehtml()
    {
        // Set the return path.
        $this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=gfmfiles', false));

        // Get the path to .md documents.
		$params = ComponentHelper::getParams('com_jdocmanual');
		$sitepath = $params->get('gfmfiles_path');
        // Check the site path has been set.
        if (empty($sitepath)) {
            $this->app->enqueueMessage('The path to git repo has not been set. Please select Options to set it', 'warning');
            return false;
        }

        // Get records from the database and fill the html field where it is empty
		$db = Factory::getDbo();

		$query = $db->getQuery(true);
        $query->select($db->quoteName(array('id', 'jdoc_key', 'manual', 'language', 'heading', 'filename', 'display_title')))
            ->from($db->quoteName('#__jdocmanual_gfmindex'))
            ->where('html IS NULL OR html =""');
		$db->setQuery($query, 0, 250);
		$rows = $db->loadAssocList();
        $start_at = $rows[0]['id'];
        foreach ($rows as $row) {
            $path = $sitepath . implode('/', array($row['manual'], $row['language'], $row['heading'], $row['filename']));
            $mdfile = file_get_contents($path);
            // problems with encoding.
            //$mdfile = iconv(mb_detect_encoding($mdfile, mb_detect_order(), true), "UTF-8", $mdfile);
            if (empty($mdfile)) {
                $this->app->enqueueMessage('Empty file, skipping: ' . $path, 'success');
                continue;
            }
            $html = Markdown2html::go($mdfile);
            // store in the database.
            $row['page_id'] = $row['id'];
            Markdown2html::store($html, $row);
        }
        $this->app->enqueueMessage('Number of html fields updated: ' . count($rows) . '. Starting at ' . $start_at, 'success');
    }
}
