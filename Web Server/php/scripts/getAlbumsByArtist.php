<?php
include('../classes/libraryBrowser.php');
$browser = new libraryBrowser();

$ArtistID = $_GET['ArtistID'];

$json_string = json_encode($browser->getAlbumsByArtist($ArtistID), JSON_PRETTY_PRINT);

echo $json_string;

?>