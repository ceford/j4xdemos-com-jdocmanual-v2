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
class ContentController extends BaseController
{
	protected $app;
	protected $manual_id;
	protected $item_id;
	protected $page_language_code;
	protected $index_language_code;
	protected $update = false;
	protected $renew = false;
	protected $page_updated;
	protected $lang_unavailable = false;
	protected $interval = 0;

	protected function setjdocmanualcookie($name, $value, $days)
	{
		if (!empty($days))
		{
			$offset = time() + $days*24*60*60;
		}
		else
		{
			$offset = 0;
		}
		$cookie_domain = $this->app->get('cookie_domain', '');
		$cookie_path   = $this->app->get('cookie_path', '/');
		$cookie = session_get_cookie_params();
		setcookie($name, $value, $offset, $cookie_path, $cookie_domain, $cookie['secure'], true);
	}

	public function update()
	{
		$this->setRedirect(Route::_('index.php?option=com_jdocmanual&view=jdocmanual', false));
		// data for the page comes from the request
		if (!Session::checkToken('post'))
		{
			// if the session has expired a login form will appear
			// but the token will be invalid so redirect to jdocmanual page
			return;
		}
		// data for update is in the form
		$jform = $this->app->input->get('jform', array(), 'array');
		$this->manual_id = $jform['manual_id'];
		$this->item_id = $jform['page_path'];
		$this->index_language_code = $jform['index_language_code'];
		$this->page_language_code = $jform['page_language_code'];
		$this->update = true;
		$this->renew = true;
		$this->fill();
	}

	public function fillpanel()
	{
		$this->manual_id = $this->app->input->get('manual_id', 0, 'int');
		$this->item_id = $this->app->input->get('item_id', '', 'string');
		$page_language_code = $this->app->input->get('page_language_code', '', 'string');
		$this->page_language_code = empty($page_language_code) ? 'en' : $page_language_code;
		$this->fill();
	}

	protected function get_localpage($item_id, $page_language_code)
	{
		$db = Factory::getDbo();
		// is the required page already downloaded?
		$query = $db->getQuery(true);

		$query->select('jp.jdoc_key, jp.content, jp.last_update')
		->from('#__jdocmanual_pages AS jp')
		->where('jp.jdoc_key = :itemId')
		->where('jp.language_code = :page_language_code')
		->bind(':itemId', $item_id, ParameterType::STRING)
		->bind(':page_language_code', $page_language_code, ParameterType::STRING);
		$db->setQuery($query);
		$row = $db->loadObject();
		if (!empty($row))
		{
			// was the last update more than xxx ago
			$now = date_create("now");
			$last_update = date_create($row->last_update);
			$this->interval = date_diff($last_update, $now)->d;
		}
		return $row;
	}

	protected function fill()
	{
		$db = Factory::getDbo();
		$params = ComponentHelper::getParams('com_jdocmanual');
		$update_period = (int) $params->get('update_period');

		if ($this->update === false)
		{
			$row = $this->get_localpage($this->item_id, $this->page_language_code);

			// if content is not empty echo and exit
			if (!empty($row->content))
			{
				if ($this->interval < $update_period)
				{
					$this->send_template($row->content);
				}
				else
				{
					$this->renew = true;
				}
			}
		}

		// fetch the page from source

		$query = $db->getQuery(true);
		$query->select('index_url')
		->from('#__jdocmanual_sources')
		->where('id = :id')
		->bind(':id', $this->manual_id);
		$db->setQuery($query);
		$url = $db->loadResult();

		$image_url = 'https://' . parse_url($url, PHP_URL_HOST);

		// keep everything up to the last /
		$url = substr($url, 0, strrpos($url,'/')+1);

		// if the language is not English add the language code
		$lang = ($this->page_language_code == 'en' ? '' : '/' . $this->page_language_code);

		// if the url contains proxy
		if (strpos($url, 'proxy') !== false)
		{
			$url .= '?page=';
			$lang = '&lang=' . $this->page_language_code;
		}

		//echo $this->app->enqueueMessage('Test= ' . $url . $this->item_id . $lang);
		// if the page does not exist the first header will be 404
		$local = InstallerHelper::downloadPackage($url . $this->item_id . $lang);

		if (empty($local))
		{
			// The page did not exist - clear the message queue
			$this->app->getMessageQueue(true);

			// Is it already downloaded in English
			$this->lang_unavailable = true;
			$row = $this->get_localpage($this->item_id, 'en');
			if (!empty($row->content))
			{
				if ($this->interval < $update_period)
				{
					$this->send_template($row->content);
				}
			}

			// Get the English contents
			$local = InstallerHelper::downloadPackage($url . $this->item_id);

			$this->page_language_code = 'en';

			if (empty($local))
			{
				echo 'Debug: ' . $url . $this->item_id . '<br />';
				echo Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_PAGE_FAIL');
				jexit();
			}
		}
		$content = file_get_contents(JPATH_SITE . '/tmp/' . $local);
		@unlink(JPATH_SITE . '/tmp/' . $local);

		$dom = new \DOMDocument;

		libxml_use_internal_errors(true);
		$dom->loadHTML($content, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
		libxml_clear_errors();

		$newdom = new \DOMDocument;
		$newdom->formatOutput = true;
		$node = $dom->getElementById('mw-content-text');

		// node could be empty so try to get the outermost div
		if (empty($node))
		{
			$node = $dom->getElementsByTagName('div')[0]; // 'mw-parser-output')[0];
		}

		$node = $newdom->importNode($node, true);

		// And then append it to the "<root>" node
		$newdom->appendChild($node);

		// remove nodes not relevant in the manual
		$xpath = new \DOMXPath($newdom);

		// not all of these nodes are in all documents
		foreach($xpath->query('//div[contains(attribute::class, "mw-pt-translate-header")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		foreach($xpath->query('//hr') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		foreach($xpath->query('//div[contains(attribute::class, "hf-nsheader")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		foreach($xpath->query('//div[contains(attribute::class, "hf-header")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		foreach($xpath->query('//div[contains(attribute::class, "mw-pt-languages")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		foreach($xpath->query('//div[contains(attribute::style, "clear:both")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		foreach($xpath->query('//div[contains(attribute::class, "toc")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		// remove the version div
		foreach($xpath->query('//div[contains(attribute::class, "metadata")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}
		// the [Edit] after a title
		foreach($xpath->query('//span[contains(attribute::class, "mw-editsection")]') as $e )
		{
			$e->parentNode->removeChild($e);
		}

		$content = $newdom->saveHTML();

		// remove empty paragraphs
		$pattern = '/<p>\s*(?:<br>)\s*/sm';
		$content = \preg_replace($pattern, '', $content);

		// imges need a full url src="/... to src="http.../
		$pattern = '/src="/';
		$replace =  'src="' . $image_url;
		$content = \preg_replace($pattern, $replace, $content);

		// tricky - do first item in srcset
		$pattern = '/srcset="/';
		$replace =  'srcset="' . $image_url;
		$content = \preg_replace($pattern, $replace, $content);

		// so any images with preceding space must be in a srcset
		$pattern = '/,\s\/images\//';
		$replace =  ', ' . $image_url . '/images/';
		$content = \preg_replace($pattern, $replace, $content);

		// but my mediawiki site is planting inline style
		$pattern = '/style="width:\d{1,}px;"/';
		$replace =  '';
		$content = \preg_replace($pattern, $replace, $content);

		// remove links from around images
		$pattern = '/<a .*?href="\/File:.*?>.*?(<img .*?>).*?<\/a>/';
		$content = preg_replace($pattern, '$1', $content);

		// links are to the local site - so if left in they must be
		// changed to absolute links.
		$content = preg_replace('/href="/', 'target="_blank" href="' . substr($url, 0, -1), $content);

		// but external links in the original are now corrpted. E.g.
		// https://docs.joomla.orghttps//www.apachefriends.org/index.html
		$content = preg_replace('/https:\/\/docs.joomla.orghttps/', 'https', $content);

		// or remove links - this seems a better practical solution
		/*$pattern = '/<a .*?>(.*?)<\/a>/';*/
		//$content = preg_replace($pattern, '<u>$1</u>', $content);

		// change class="alert-box" to class="alert alert-info" role="alert"
		$pattern = '/class="alert-box"/';
		$replace = '/class="alert alert-info" role="alert"/';
		$content = preg_replace($pattern, $replace, $content);

		// and store it locally
		$query = $db->getQuery(true);
		if ($this->renew)
		{
			$query->update('#__jdocmanual_pages')
			->where('jdoc_key = :id')
			->where('language_code = :language_code')
			->bind(':id', $this->item_id)
			->bind(':language_code', $this->page_language_code);
		} else {
			$query->insert('#__jdocmanual_pages')
			->set('jdoc_key = :id')
			->bind(':id', $this->item_id);
		}
		$query->set('language_code = ' . $db->quote($this->page_language_code))
		->set('content = ' . $db->quote($content))
		->set('last_update = NOW()');
		$db->setQuery($query);
		$db->execute();
		$this->page_updated = true;
		$this->send_template($content);
	}

	protected function send_template($content)
	{
		// add some messages before content
		$mod = '';

		if ($this->lang_unavailable)
		{
			$mod = '<div class="alert alert-info">';
			$mod .= Text::_('COM_JDOCMANUAL_JDOCMANUAL_FETCH_PAGE_FAIL_LANGUAGE');
			$mod .= "</div>\n";
		}

		if ($this->page_updated)
		{
			$mod = '<div class="alert alert-info">';
			$mod .= Text::_('COM_JDOCMANUAL_JDOCMANUAL_UPDATE_PAGE_SUCCESS');
			$mod .= "</div>\n";
		}

		echo '<div id="scroll-panel">';

		echo $mod . $content;

		echo '</div>';

		if ($this->update)
		{
			return;
		}
		jexit();
	}
}