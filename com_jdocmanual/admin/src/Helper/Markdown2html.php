<?php

/**
 * @package     jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   Copyright (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Helper;

use Joomla\Database\ParameterType;
use Joomla\CMS\Factory;
require JPATH_ROOT . '/administrator/components/com_jdocmanual/libraries/vendor/autoload.php';
use League\CommonMark\Environment\Environment;
use League\CommonMark\Extension\CommonMark\CommonMarkCoreExtension;
use League\CommonMark\Extension\GithubFlavoredMarkdownExtension;
use League\CommonMark\Extension\HeadingPermalink\HeadingPermalinkExtension;
use League\CommonMark\Extension\TableOfContents\TableOfContentsExtension;
use League\CommonMark\MarkdownConverter;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Convert Markdown text to html
 *
 * @since  1.0
 */
class Markdown2html
{
    /**
     * Entry point to convert Markdown to HTML.
     *
     * @param string $md    The text in Markdown format.
     *
     * @return string   The text in HTML format
     *
     * @since 1.0
     */
    public static function go($md)
    {
        // Define your configuration, if needed
        $config = [
            'table_of_contents' => [
                'html_class' => 'table-of-contents',
                'position' => 'top',
                'placeholder' => '[TOC]',
                'style' => 'bullet',
                'min_heading_level' => 1,
                'max_heading_level' => 6,
                'normalize' => 'relative',
            ],
            'heading_permalink' => [
                'html_class' => 'heading-permalink',
                'insert' => 'after',
                'symbol' => '¶',
                'title' => "Permalink",
                'aria_hidden' => false,
            ],
        ];

        // Configure the Environment with all the CommonMark and GFM parsers/renderers
        $environment = new Environment($config);
        $environment->addExtension(new CommonMarkCoreExtension());
        $environment->addExtension(new GithubFlavoredMarkdownExtension());
        $environment->addExtension(new HeadingPermalinkExtension());
        $environment->addExtension(new TableOfContentsExtension());

        $converter = new MarkdownConverter($environment);
        return $converter->convert($md);
    }

    /**
     * Save an article in Markdown format.
     *
     * @param string    $html   The text in HTML format.
     * @param array     $data   The article data.
     *
     * @return void
     *
     * @since 1.0
     */
    public static function store($html, $data)
    {
        $db = Factory::getContainer()->get('DatabaseDriver');

        $query = $db->getQuery(true);
        // If id is 0 this must be a new document.
        if (empty($data['page_id'])) {
            $query->insert($db->quoteName('#__jdm_articles'))
            ->set($db->quoteName('jdoc_key') . ' = :jdoc_key')
            ->set($db->quoteName('manual') . ' = :manual')
            ->set($db->quoteName('language') . ' = :language')
            ->set($db->quoteName('heading') . ' = :heading')
            ->set($db->quoteName('filename') . ' = :filename')
            ->set($db->quoteName('display_title') . ' = :display_title')
            ->bind(':jdoc_key', $data['jdoc_key'], ParameterType::STRING)
            ->bind(':manual', $data['manual'], ParameterType::STRING)
            ->bind(':language', $data['language'], ParameterType::STRING)
            ->bind(':heading', $data['heading'], ParameterType::STRING)
            ->bind(':filename', $data['filename'], ParameterType::STRING)
            ->bind(':display_title', $data['display_title'], ParameterType::STRING);
        } else {
            $query->update($db->quoteName('#__jdm_articles'))
            ->where($db->quoteName('id') . ' = :id')
            ->bind(':id', $data['page_id'], ParameterType::INTEGER);
        }
        $query->set($db->quoteName('html') . ' = :html')
        ->bind(':html', $html, ParameterType::STRING);
        $db->setQuery($query);
        $db->execute();
    }
}
