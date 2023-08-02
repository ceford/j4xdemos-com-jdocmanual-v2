<?php

// Get the query string
//https://help.joomla.org/proxy?keyref=Help50:Modules&lang=en
//http://localhost/proxy/index.php?keyref=Help50:Modules&lang=en

$keyref = $_GET['keyref'];
$lang = $_GET['lang'];

// Get the keyref to filename table
require_once __DIR__ . '/key-index.php';

// break the keyref at the first colon
list ($version, $key) = explode(':', $keyref, 2);

// check that the $version is Help50
if (!('Help40'  !== $version || 'Help50'  !== $version)) {
    echo "\nThere is no Help data available here for Joomla version {$version}\n";
    exit();
}

// Compose the file path for the requested file
$filename = __DIR__ . '/' . $lang . '/' . $key_index[$key];
if (file_exists($filename)) {
    // Send it
    echo file_get_contents($filename);
    exit;
}

// If the requested file language was not English try the English version
$filename = __DIR__ . '/en/' . $key_index[$key];
if (file_exists($filename)) {
    // Send it
    $contents = file_get_contents($filename);
    // Add a message after the <main> tag.
    // This should be translated into the selected language.
    $msg = "<main>\n";
    $msg .= '<div class="language-substitute">';
    $msg .= "\nThe page you requested was not available in your preferred language.\n";
    $msg .= "This is the English version.\n";
    $msg .= "</div>\n";

    $contents = str_replace('<main>', $msg, $contents);
    echo $contents;

    exit;
}

// Otherwise send an error message
echo "\n\nThe Help page you requested was not available in the original language or in English.";

exit();
