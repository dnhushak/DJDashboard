<?php
include('../classes/libraryBrowser.php');

//Used to get all track data from track ID
$browser = new libraryBrowser();

$TrackID = $_GET['TrackID'];

$json_string = json_encode($browser->getTrackData($TrackID), JSON_PRETTY_PRINT);
echo $json_string;

?>