<?php
include_once ('subsonicBrowser.php');
$sub = new subsonicBrowser('http://kure-automation.stuorg.iastate.edu/', "kuredj", "kuredj", "1.8.0", "KURE DJ Dash", "json");
// $args = array(id => "300");
// echo $sub->sendRequest(getArtists, $args, FALSE);
$ping = $sub->ping();
if ($ping) {
	$artistid = $sub->getArtistidByName("Pink Floyd");
	$albumlist = $sub->getAlbumsByArtist($artistid);
	// var_dump($albumlist);
	//echo $albumlist [0] ["id"];
	$tracklist = $sub->getTracksByAlbum($albumlist [0] ["id"]);
	 //$tracklist = $sub->getTracksByAlbum(595);
	// var_dump($tracklist);

	$track = $sub->getTrackPlayLinkByNames("Pink Floyd", "The Division Bell", "Marooned");
	echo $track;
}
?>