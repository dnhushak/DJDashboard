<?php


	include_once ('../classes/subsonicBrowser.php');
	$artist = $_GET['Artist'];
	$album = $_GET['Album'];
	$track = $_GET['Track'];
	
	$sub = new subsonicBrowser('http://kure-automation.stuorg.iastate.edu/', "kuredj", "kuredj", "1.8.0", "KURE DJ Dash", "json");
	$ping = $sub->ping();
	if ($ping) {
		$url = $sub->getTrackPlayLinkByNames($artist, $album, $track);
		echo $url;
	}
?>
