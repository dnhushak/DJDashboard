<?php
include ('../libraryBrowser.class.php');
$lib = new libraryBrowser;
$lib->setPlaylist("All");
$lib->getArtists();
$json = $lib->getJson();
echo $json;
?>