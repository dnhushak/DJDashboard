<?php
/*
 * Created on Mar 3, 2014
 *
 * Used to create custom artists not already in the KURE library.  This will allow DJs to play their own music
 * and keep an acitve log of it.
 * 
 * Created by Robert Clabough
 */
 
include_once('../publisher.php');
include_once('../library/LibraryEditor.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );

$artist = new Artist();
$artist->setName($_GET['ArtistName']);

$editor = new LibraryEditor();


 
?>
