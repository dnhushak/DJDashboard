<?php
/*
 * Created on Mar 24, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 include_once('../admin/PlayManager.php');
 
 $manager = new PlayManager();
 echo json_encode($manager->getTypes());
?>
