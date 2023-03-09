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

use Joomla\Database\ParameterType;
use Joomla\CMS\Factory;
require JPATH_COMPONENT . '/libraries/vendor/autoload.php';
use League\CommonMark\Environment\Environment;
use League\CommonMark\Extension\CommonMark\CommonMarkCoreExtension;
use League\CommonMark\Extension\GithubFlavoredMarkdownExtension;
use League\CommonMark\MarkdownConverter;

class Markdown2html
{
	public static function go($md) {
		// Define your configuration, if needed
		$config = [];

		// Configure the Environment with all the CommonMark and GFM parsers/renderers
		$environment = new Environment($config);
		$environment->addExtension(new CommonMarkCoreExtension());
		$environment->addExtension(new GithubFlavoredMarkdownExtension());

		$converter = new MarkdownConverter($environment);
		//echo $converter->convert('Hello GFM!');
		return $converter->convert($md);
	}

	public static function store($html, $data) {
		$db = Factory::getDbo();
		$query = $db->getQuery(true);
		// If id is 0 this must be a new document.
		if (empty($data['page_id'])) {
			$query->insert('#__jdocmanual_gfmindex')
			->set('jdoc_key = :jdoc_key')
			->set('manual = :manual')
			->set('language = :language')
			->set('heading = :heading')
			->set('filename = :filename')
			->set('display_title = :display_title')
			->bind(':jdoc_key', $data['jdoc_key'], ParameterType::STRING)
			->bind(':manual', $data['manual'], ParameterType::STRING)
			->bind(':language', $data['language'], ParameterType::STRING)
			->bind(':heading', $data['heading'], ParameterType::STRING)
			->bind(':filename', $data['filename'], ParameterType::STRING)
			->bind(':display_title', $data['display_title'], ParameterType::STRING);
		} else {
			$query->update('#__jdocmanual_gfmindex')
			->where('id = :id')
			->bind(':id', $data['page_id'], ParameterType::INTEGER);
		}
		//echo $query->__tostring();die();
		$query->set('html = :html')
		->bind(':html', $html, ParameterType::STRING);
		$db->setQuery($query);
		$db->execute();
	}
}