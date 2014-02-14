<?php
include('../classes/libraryBrowser.php');
$browser = new libraryBrowser();

$AlbumID = $_GET['AlbumID'];

$json_string = json_encode($browser->getTracksByArtist($AlbumID), JSON_PRETTY_PRINT);

echo $json_string;

?>