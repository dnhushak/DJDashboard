<?php
/*
 * Created on Mar 24, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
   include_once('../admin/PlayManager.php');
 include_once('../publisher.php');

	
register_shutdown_function( "Publisher::fatalHandler" );

$manager = new PlayManager();

$arr = $manager->getPlays();

echo json_encode($arr, JSON_PRETTY_PRINT);

?>
