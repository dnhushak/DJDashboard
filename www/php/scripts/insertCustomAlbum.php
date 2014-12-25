<?php
/*
 * Created on Mar 3, 2014
 *
 * Used to create custom artists not already in the KURE library.  This will allow DJs to play their own music
 * and keep an acitve log of it.
 * 
 * Created by Caleb Van Dyke
 */
 
include_once('../publisher.php');
include_once('../library/LibraryEditor.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

$album = new Album();
$album->setName($_GET['AlbumName']);
$album->setArtistID($_GET['ArtistID']);
$album->setPrimaryGenre($_GET['PGenre']);
$album->setSecondaryGenre($_GET['SGenre']);

if($album->getPrimaryGenre() == 0){
	$album->setPrimaryGenre(null);
}
if($album->getSecondaryGenre() == 0){
	$album->setSecondaryGenre(null);
}

$editor = new LibraryEditor();

$newAlbumID = $editor->insertCustomAlbum($album);

echo $newAlbumID;
 
?>
