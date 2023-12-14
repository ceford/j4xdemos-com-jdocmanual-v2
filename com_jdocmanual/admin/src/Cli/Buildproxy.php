<?php

/**
 * @package     Jdocmanual
 * @subpackage  Cli
 *
 * @copyright   Copyright (C) 2003 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Cli;

use Joomla\CMS\Factory;
use Joomla\CMS\Component\ComponentHelper;
use J4xdemos\Component\Jdocmanual\Administrator\Helper\Markdown2html;
use Joomla\CMS\Filesystem\File;

// phpcs:disable PSR1.Files.SideEffects
\defined('JPATH_PLATFORM') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Build the Joomla help html files used by the proxy server.
 *
 * @since  1.0.0
 */
class Buildproxy
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
     * The top section of a Help page.
     *
     * @var     string
     * @since  1.0.0
     */
    protected $top;

    /**
     * The bottom section of a Help page.
     *
     * @var     string
     * @since  1.0.0
     */
    protected $bottom;

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

        echo "\n\nBegin Build Articles for Proxy server\n";

        $this->manualtodo = 'help';
        $this->languagetodo = $language;

        $memlimit = ini_get('memory_limit');
        ini_set("memory_limit", "2048M");
        echo $this->build();

        echo "\nEnd Build Articles for Proxy\n\n";
        //ini_set("memory_limit", $memlimit);
        // Warning: Failed to set memory limit to 536870912 bytes
        //(Current memory usage is 1470103552 bytes) in [redacted]/Buildhtml.php on line 139

        $time_end = microtime(true);
        $execution_time = $time_end - $time_start;

        echo 'Total Execution Time: ' . number_format($execution_time, 2) . ' Seconds' . "\n\n";
    }

    /**
     * Cycle over manuals and languages to convert txt to html and save.
     * Skip all manuals except help.
     *
     * @return  $string     A message reporting the outcome.
     *
     * @since   1.0.0
     */
    protected function build()
    {
        // Get the data source path from the component parameters
        $this->gfmfiles_path = ComponentHelper::getComponent('com_jdocmanual')->getParams()->get('gfmfiles_path', ',');
        if (empty($this->gfmfiles_path)) {
            return "\nThe Git Source could not be found: {$this->gfmfiles_path}. Set in Jdocmanual configuration.\n";
        }
        $this->settop();
        $this->setbottom();

        // Get a list of manual folders in /Users/ceford/data/manuals/
        $manuals = array_diff(scandir($this->gfmfiles_path), array('..', '.', '.DS_Store'));
        foreach ($manuals as $manual) {
            // Skip of not all manuals are being updated
            if (!($this->manualtodo === 'all' || $this->manualtodo === $manual)) {
                continue;
            }
            // Read in articles-index.txt
            $articles_index = $this->gfmfiles_path . $manual . '/articles-index.txt';
            if (!file_exists($articles_index)) {
                echo "Skipping {$manual} - file does not exists: {$articles_index}\n";
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
                    echo "Summary: {$manual}/{$language} available: {$count}\n";
                }
            }
        }
    }

    /**
     * Convert help md files to html and save.
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
        $count = 0;
        $db = Factory::getContainer()->get('DatabaseDriver');

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
            // Get the title from the contents
            // Look for h1 (in md that is # at the start of a line)
            $test = preg_match($this->pattern1, $contents, $matches);

            if (empty($test)) {
                //Look for Display Title
                //<!-- Filename: J4.x:Http_Header_Management / Display title: HTTP Header Verwaltung -->
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

            $html = $this->top;
            $html .= Markdown2html::go($contents);
            $html .= $this->bottom;

            $outfile = str_replace('.md', '.html', $filename);
            File::write(JPATH_ROOT . '/proxy/' . $language . '/' . $outfile, $html);

            // for testing - do one file from each language
            //return;

            $count += 1;
        }
        return $count;
    }

    /**
     * Set the top part of a Help page.
     *
     * @return  $html   The required html code.
     *
     * @since   1.0.0
     */
    protected function settop()
    {
        $this->top = <<<EOF
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Joomla! Help Screens</title>
        <link rel="stylesheet" href="https://help.joomla.org/media/css/help.css">
        <link rel="stylesheet" href="/proxy/help.css">
    </head>
    <body>
        <main>
            <a name="Top" id="Top"></a>
EOF;
    }

    /**
     * Set the bottom part of a Help page.
     *
     * @return  $html   The required html code.
     *
     * @since   1.0.0
     */
    protected function setbottom()
    {
        $this->bottom = <<<EOF
            <div id="footer-wrapper">
                <div id="license">
                    License: <a href="https://docs.joomla.org/JEDL" target="_blank">
                        Joomla! Electronic Documentation License
                    </a>
                </div>
                <div id="source-page">
                    Source page:
                    <a href="https://docs.joomla.org/Help5.x:Articles/en" target="_blank">
                        https://docs.joomla.org/Help5.x:Articles/en
                    </a>
                </div>
                <div id="copyright">
                    Copyright &copy; 2023 <a href="https://www.opensourcematters.org" target="_blank">
                    Open Source Matters, Inc.</a> All rights reserved.
                </div>
            </div>
            <hr/>
            <a href="#Top">Top</a>
        </main>
    </body>
</html>
EOF;
    }
}
