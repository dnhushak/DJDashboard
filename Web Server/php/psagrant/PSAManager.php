<?php
/*
 * Created on Mar 15, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 /**
  * Created to manage all PSAs.  Used for creating, managing, and deleting PSAs.
  * rclabou 3/15/14
  */
 class PSAManager
 {
 	
 	/**
 	 * Retrieves n number of PSAs to the calling application.  The exact amount is given by $numberOfPSA while this method retrieves
 	 * the highest priority ones from the DB.  Returns an array of PublicServiceAnnouncement objects.
 	 */
 	public function getPSAs($numberOfPSA)
 	{
 		//todo
 		//Initial call: Get all PSAs that are eligible
 		
 		//Second call, take highest n PSAs and return them in an array.
 	}
 	
 	
 	/**
 	 * Used to add a PSA to the database.  $psa must be a PublicServiceAnnouncement object already, then this prepares it for the sql call
 	 * rclabou 3/15/14
 	 */
 	public function addPSA($psa)
 	{
 		//todo
 		
 	}
 	
 }
?>
