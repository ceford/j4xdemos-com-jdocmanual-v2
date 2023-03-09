<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Controller;

\defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Installer\InstallerHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Controller\BaseController;
use Joomla\Database\ParameterType;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use Joomla\CMS\Uri\Uri;

/**
 * Jdocmanual Component Controller
 *
 * @since  4.0.0
 */
class IndexController extends BaseController
{
	protected $app;

	/**
	 * Method to fetch, parse and store the Manual contents from docs.joomla.org
	 */
	public function fetch()
	{
		$jform = $this->app->input->get('jform', array(), 'array');
		$manual_id = $jform['manual_id'];
		$index_language_code = $jform['index_language_code'];

		$db = Factory::getDbo();
		$this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=jdocmanual', false));

		// Get url from the sources table
		$query = $db->getQuery(true);
		$query->select('index_url')
		->from('#__jdocmanual_sources')
		->where('id = :id' )
		->bind(':id', $manual_id);
		$db->setQuery($query);
		$url = $db->loadResult();

		// Check if pages are being delivered by a proxy
		$proxy = true;
		if (strpos($url, '/proxy/') === false)
		{
			$proxy = false;
		}


		// if the language is not English add the language code
		$lang = ($index_language_code == 'en' ? '' : '/' . $index_language_code);

		// if the page does not exist the first header will be 404
		$local = InstallerHelper::downloadPackage($url . $lang);

		if (empty($local))
		{
			if ($lang != 'en')
			{
				// check whether English content exists
				$query = $db->getQuery(true);
				$query->select('id')
				->from('#__jdocmanual_menu')
				->where('source_id = :source_id')
				->where('language_code = ' . $db->quote('en'))
				->bind(':source_id' , $manual_id);
				$db->setQuery($query);
				$fetched = $db->loadResult();
				if ($fetched)
				{
					$this->app->enqueueMessage(Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_INDEX_ENGLISH'), 'warning');
					return false;
				}
			}
			// fetch the index in English
			$local = InstallerHelper::downloadPackage($url);
			if (empty($local))
			{
				$this->app->enqueueMessage(Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_INDEX_FAIL'), 'warning');
				return false;
			}
		}

		$content = file_get_contents(JPATH_SITE . '/tmp/' . $local);
		@unlink(JPATH_SITE . '/tmp/' . $local);

		$dom = new \DOMDocument;

		libxml_use_internal_errors(true);
		$dom->loadHTML($content, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
		libxml_clear_errors();

		$node = $dom->getElementById('jdocmanual-index');

		$newdom = new \DOMDocument;
		$newdom->loadXML("<root><someelement>text in some element</someelement></root>");

		$node = $newdom->importNode($node, true);
		$newdom->documentElement->appendChild($node);

		$id = 0;
		$html = '<div class="accordion" id="accordionJdoc">';

		// to use h3 plus single level ul
		foreach($newdom->getElementsByTagName('*') as $element) {
			if ($element->nodeType === XML_ELEMENT_NODE)
			{
				if ($element->nodeName == 'h3')
				{
					// close the previous accordian
					if ($id > 0)
					{
						$html .= $this->accordion_end ();
					}
					$id += 1;
					// The title is in the first span
					$child = $element->getElementsByTagName('span')[0];
					// open a new accordian
					$html .= $this->accordion_start ($id, $child->textContent);
				}
				if ($element->nodeName == 'li' && !empty($id))
				{
					$child = $element->getElementsByTagName('a')[0];
					if (!empty($child))
					{
						$href = $child->getAttribute('href');
						// if the url contains the domain, remove it
						$path = parse_url($href, PHP_URL_PATH);
						// if the path contains S:MyLanguage or Special:MyLanguage remove it
						$path = str_replace(array('S:MyLanguage/','Special:MyLanguage/'), '', $path);
						$html .= $this->accordion_item($path, $child->nodeValue);
					}
				}
			}
		}
		$html .= "\n</ul>\n</div>\n</div>\n</div>\n</div>\n";

		// save the menu in the database
		$query = $db->getQuery(true);
		$query->insert('#__jdocmanual_menu')
		->set('language_code = :index_language')
		->set('source_id = :source_id')
		->set('menu = :menu')
		->bind(':index_language', $index_language_code, ParameterType::STRING)
		->bind(':source_id', $manual_id)
		->bind(':menu', $html, ParameterType::STRING);
		$db->setQuery($query);
		$db->execute();
		$this->app->enqueueMessage(Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_SUCCESS'), 'success');
	}

	protected function accordion_start ($id, $label)
	{
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
		return "\n</ul>\n</div>\n</div>\n</div>\n";
	}

	protected function accordion_item($link, $value)
	{
		$link = preg_replace('/\/Special:MyLanguage\//', '', $link);
		// remove any leading '/'
		if (strpos($link, '/') === 0)
		{
			$link = substr($link, 1);
		}
		// remove leading J4.x, J3.x or Main: from the value
		if (strpos($value, 'J4.x ') === 0)
		{
			$value = substr($value, 5);
		}
		elseif (strpos($value, 'J3.x ') === 0)
		{
			$value = substr($value, 5);
		}
		elseif (strpos($value, 'Main: ') === 0)
		{
			$value = substr($value, 6);
		}
		elseif (strpos($value, 'JDOC: ') === 0)
		{
			$value = substr($value, 6);
		}
		$html ='<li><span class="icon-file-alt icon-fw icon-jdocmanual" aria-hidden="true"></span>';
		$html .= '<a href="#" class="content-link" data-content-id="' . $link . '">';
		$html .= $value . '</a></li>' . "\n";
		return $html;
	}

}