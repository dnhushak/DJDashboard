<?php
include_once ('subsonicBrowser.php');
$sub = new subsonicBrowser('http://kure-automation.stuorg.iastate.edu/', "kuredj", "kuredj", "1.8.0", "KURE DJ Dash", "json");
// $args = array(id => "300");
// echo $sub->sendRequest(getArtists, $args, FALSE);
$ping = $sub->ping();
if ($ping) {
	$artistid = $sub->getArtistidByName("Alkaline Trio");
	$albumlist = $sub->getAlbumsByArtist($artistid);
	//echo $albumlist [0] ["id"];
	$tracklist = $sub->getTracksByAlbum($albumlist [4] ["id"]);
	 //$tracklist = $sub->getTracksByAlbum(595);
	var_dump($tracklist);

	$track = $sub->getTrackidByNames("Alkaline Trio", "From Here To Infirmary", "Bloodied Up");
	echo $track;
}
?>