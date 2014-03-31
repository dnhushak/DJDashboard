<?php
/*
 * Created on Mar 28, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 /**
  * Created to provide the current user who is on air
  * 
  */
  include_once('../library/UserManager.php');
  
  return JSON_ENCODE(UserManager::getOnAirUser(), JSON_PRETTY_PRINT);
?>
