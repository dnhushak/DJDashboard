<?php
include_once ('subsonicBrowser.php');
$sub = new subsonicBrowser('http://kure-automation.stuorg.iastate.edu/', "kuredj", "kuredj", "1.8.0", "KURE DJ Dash", json);
// $args = array(id => "300");
// echo $sub->sendRequest(getArtists, $args, FALSE);
$ping = $sub->ping();
if ($ping) {
	$artistid = $sub->getArtistidByName("Pink Floyd");
	$albumlist = $sub->getAlbumsByArtist($artistid);
	$tracklist = $sub->getTracksByAlbum($albumlist[0]["id"]);
	//var_dump($tracklist);
}
?>