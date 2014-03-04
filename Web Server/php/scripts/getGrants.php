<?php
/*
 * Created on Mar 3, 2014
 *
 * Script to return an eligible grant, uses algorithm to determine which grant to use
 */
 
 include('../psagrant/GrantManager.php');
 
 $count = $_GET['Count'];

if($count == null)
{
	$count = 1;
}

//Used to get all track data from track ID
$manager = new GrantManager();
 $results = $manager->getGrants($count);
 echo JSON_ENCODE($results, JSON_PRETTY_PRINT);
 
?>
