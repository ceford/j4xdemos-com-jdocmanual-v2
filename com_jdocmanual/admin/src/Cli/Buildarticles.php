<?php

/**
 * @package     Jdocmanual
 * @subpackage  Cli
 *
 * @copyright   Copyright (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Cli;

use Joomla\CMS\Factory;
use Joomla\CMS\Component\ComponentHelper;
use Joomla\Database\ParameterType;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\Markdown2html;

// phpcs:disable PSR1.Files.SideEffects
\defined('JPATH_PLATFORM') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Build the jdm_articles table.
 *
 * @since  1.0.0
 */
class Buildarticles
{
    /**
     * Path to local source of markdown files.
     *
     * @var     string
     * @since   1.0.0
     */
    protected $gfmfiles_path;

    /**
     * Regex pattern to select first GFM H1 (#) string.
     *
     * @var     string;
     * @since   1.0.0
     */
    protected $pattern1 = '/\n[#]([\w| ].*)/m';

    /**
     * Regex pattern to select Display title from GFM comment string.
     *
     * @var     string
     * @since  1.0.0
     */
    protected $pattern2 = '/<!-- Filename:.*Display title:(.*)? -->/m';

    /**
     * Path fragment of manual to process.
     *
     * @var     string
     * @since  1.0.0
     */
    protected $manualtodo;

    /**
     * Path fragment of language to process.
     *
     * @var     string
     * @since  1.0.0
     */
    protected $languagetodo;

    /**
     * Content of menu index file.
     *
     * @var     string
     * @since  1.0.0
     */
    protected $tmp;

    /**
     * Entry point to convert md to html and save.
     *
     * @param   $manual     The path fragment of the manual to process.
     * @param   $language   The path fragment of the language to process.
     *
     * @return  $string     A message reporting the outcome.
     *
     * @since   1.0.0
     */
    public function go($manual, $language)
    {
        $time_start = microtime(true);

        // The echo items appear in the CLI but not in Joomla.
        echo "\n\nBegin Build Articles in Database\n";

        $this->manualtodo = $manual;
        $this->languagetodo = $language;

        // The memory limit needs to be quite large to build all of the articles.
        $memlimit = ini_get('memory_limit');
        ini_set("memory_limit", "2048M");

        $summary = $this->build();

        echo "\nEnd Build Articles\n\n";

        $time_end = microtime(true);
        $execution_time = $time_end - $time_start;

        $summary .= 'Total Execution Time: ' . number_format($execution_time, 2) . ' Seconds' . "\n\n";

        return $summary;
    }

    /**
     * Cycle over manuals and languages to convert md to html and save.
     *
     * @return  $string     A message reporting the outcome.
     *
     * @since   1.0.0
     */
    protected function build()
    {
        // Get the data source path from the component parameters.
        $this->gfmfiles_path = ComponentHelper::getComponent('com_jdocmanual')->getParams()->get('gfmfiles_path', ',');
        if (empty($this->gfmfiles_path)) {
            return "\nThe Git Source could not be found: {$this->gfmfiles_path}. Set in Jdocmanual configuration.\n";
        }

        // Get a list of manual folders in /Users/ceford/data/manuals/
        $manuals = array_diff(scandir($this->gfmfiles_path), array('..', '.', '.DS_Store'));
        $summary = '';

        foreach ($manuals as $manual) {
            // Skip of not all manuals are being updated
            if (!($this->manualtodo === 'all' || $this->manualtodo === $manual)) {
                continue;
            }

            // Read in articles-index.txt
            $articles_index = $this->gfmfiles_path . $manual . '/articles-index.txt';
            if (!file_exists($articles_index)) {
                $summary .= "Skipping {$manual} - file does not exists: {$articles_index}\n";
                continue;
            }
            // Read in the articles_index
            $this->tmp = file_get_contents($articles_index);

            // Get a list of the language folders in a manual
            $languages = array_diff(scandir($this->gfmfiles_path . $manual), array('..', '.', '.DS_Store'));
            foreach ($languages as $language) {
                // Skip of not all languages are being updated
                if (!($this->languagetodo === 'all' || $this->languagetodo === $language)) {
                    continue;
                }
                if (is_dir($this->gfmfiles_path . $manual . '/' . $language)) {
                    $count = $this->html4lingo($manual, $language);
                    $summary .= "Summary: {$manual}/{$language} number of articles: {$count}\n";
                }
            }
        }
        return $summary;
    }

    /**
     * Convert a single md file to html and save.
     *
     * @param   $manual     The path fragment of the manual to process.
     * @param   $language   The path fragment of the language to process.
     *
     * @return  $int        Count of the number of files.
     *
     * @since   1.0.0
     */
    protected function html4lingo($manual, $language)
    {
        $db = Factory::getContainer()->get('DatabaseDriver');
        $count = 0;

        foreach (preg_split("/((\r?\n)|(\r\n?))/", $this->tmp) as $line) {
            if (empty($line)) {
                continue;
            }
            list ($heading, $jdoc_key, $filename) = explode('=', $line);

            $gfm_file = $this->gfmfiles_path . $manual . '/' . $language . '/' . $heading . '/' . $filename;
            if (!file_exists($gfm_file)) {
                continue;
            }

            $contents = file_get_contents($gfm_file);

            // Get the title from the contents.
            // Look for h1 (in md that is # at the start of a line).
            $test = preg_match($this->pattern1, $contents, $matches);

            if (empty($test)) {
                // Look for Display Title.
                // <!-- Filename: J4.x:Http_Header_Management / Display title: HTTP Header Verwaltung -->
                $test = preg_match($this->pattern2, $contents, $matches);
                if (empty($test)) {
                    echo "Warning {$manual}/{$language}/{$heading}/{$filename} does not contain h1\n";
                    $fn = substr($filename, 0, strpos($filename, '.md'));
                    $display_title = ucwords(str_replace('_', ' ', $fn));
                } else {
                    $display_title = $matches[1];
                }
            } else {
                $display_title = $matches[1];
            }

            $html = Markdown2html::go($contents);

            // Check if there is an entry for this article.
            $query = $db->getQuery(true);
            $query->select($db->quotename('id'))
            ->from($db->quotename('#__jdm_articles'))
            ->where($db->quotename('manual') . ' = :manual')
            ->where($db->quotename('language') . ' = :language')
            ->where($db->quotename('heading') . ' = :heading')
            ->where($db->quotename('filename') . ' = :filename')
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':heading', $heading, ParameterType::STRING)
            ->bind(':filename', $filename, ParameterType::STRING);
            $db->setQuery($query);
            $id = $db->loadResult();

            $query = $db->getQuery(true);
            if (empty($id)) {
                // If id was empty do an insert.
                $query->insert($db->quotename('#__jdm_articles'));
            } else {
                // Otherwise do an update.
                $query->update($db->quotename('#__jdm_articles'));
                $query->where($db->quotename('id') . ' = ' . $id);
            }

            $query->set($db->quotename('jdoc_key') . ' = :jdoc_key')
            ->set($db->quotename('manual') . ' = :manual')
            ->set($db->quotename('language') . ' = :language')
            ->set($db->quotename('heading') . ' = :heading')
            ->set($db->quotename('filename') . ' = :filename')
            ->set($db->quotename('display_title') . ' = :display_title')
            ->set($db->quotename('html') . ' = :html')
            ->bind(':jdoc_key', $jdoc_key, ParameterType::STRING)
            ->bind(':manual', $manual, ParameterType::STRING)
            ->bind(':language', $language, ParameterType::STRING)
            ->bind(':heading', $heading, ParameterType::STRING)
            ->bind(':filename', $filename, ParameterType::STRING)
            ->bind(':display_title', $display_title, ParameterType::STRING)
            ->bind(':html', $html, ParameterType::STRING);
            $db->setQuery($query);
            $db->execute();

            // For testing - do one file from each manual and language.
            // return;

            $count += 1;
        }
        return $count;
    }
}
