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
use Joomla\Database\DatabaseAwareTrait;
use Joomla\CMS\Filesystem\File;

// phpcs:disable PSR1.Files.SideEffects
\defined('JPATH_PLATFORM') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Build the Joomla help html files used by the proxy server.
 *
 * @since  1.0.0
 */
class Checkhistory
{
    use DatabaseAwareTrait;
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

        echo "\n\nBegin Check History\n";

        $this->manualtodo = 'help';
        $this->languagetodo = $language;

        // Check that the database table exists.
        $db    = Factory::getDbo();
        $query = $db->getQuery(true);
        $query->select('id, jdoc_key, last_update')
        ->from($db->quotename('#__jdm_articles_history'))
        ->where('state = 1');
        $db->setQuery($query);
        $rows = $db->loadObjectList();
        $base_url = 'https://docs.joomla.org/api.php?action=query&prop=revisions&titles=';
        $params = '&rvslots=main&rvprop=timestamp|user|comment&format=json';
        foreach ($rows as $row) {
            // Get last update date for this document
            $url = $base_url . $row->jdoc_key . $params;
            // https://docs.joomla.org/api.php?action=query&prop=revisions&titles=J4.x:Adding_a_New_Article&rvslots=main&rvprop=timestamp|user|comment
            $data = json_decode(file_get_contents($url), true);
            if (!isset($data['query']['pages'][key($data['query']['pages'])]['revisions'][0]['timestamp'])) {
                continue;
            }
            $date = $data['query']['pages'][key($data['query']['pages'])]['revisions'][0]['timestamp'];
            // "2022-05-11T02:02:27Z"
            $date = str_replace('T', ' ', $date);
            $date = str_replace('Z', '', $date);
            $user = $data['query']['pages'][key($data['query']['pages'])]['revisions'][0]['user'];
            $comment = $data['query']['pages'][key($data['query']['pages'])]['revisions'][0]['comment'];
            if (true || empty($row->last_update) || $row->last_update < $date) {
                $query = $db->getQuery(true);
                $query->update($db->quoteName('#__jdm_articles_history'))
                ->set($db->quoteName('last_update') . ' = ' . $db->quote($date))
                ->set($db->quoteName('user') . ' = ' . $db->quote($user))
                ->set($db->quoteName('comment') . ' = ' . $db->quote($comment))
                ->where($db->quoteName('id') . ' = ' . $row->id);
                $db->setQuery($query);
                $db->execute();
                //echo "Record {$row->id} set to {$date}\n";
                echo ".";
            }
            //break;
        }

        $time_end = microtime(true);
        $execution_time = $time_end - $time_start;

        echo 'Total Execution Time: ' . number_format($execution_time, 2) . ' Seconds' . "\n\n";
    }

}
