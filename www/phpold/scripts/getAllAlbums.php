<?php
	include('../classes/libraryBrowser.php');
	$browser = new libraryBrowser();
	$json_string = json_encode($browser->getAlbums(false), JSON_PRETTY_PRINT);
	echo $json_string;
?>