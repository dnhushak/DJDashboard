<?php
/*
 * Created on Mar 15, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 include_once('../sqlconnect.php');
 include_once('PublicServiceAnnouncement.php');
 /**
  * Created to manage all PSAs.  Used for creating, managing, and deleting PSAs.
  * rclabou 3/15/14
  */
 class PSAManager
 {
 	
 	private $spInsertPSA;
 	
 	
 	public function __construct() {
		$this->initialize();
	}
	
	public function initialize()
	{
		$this->spInsertPSA = "AddPSA";
		
	}
 	
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
 	 * Used to add a PSA to the database.  $psa must be a PublicServiceAnnouncement object already, then this prepares it for the sql call.
 	 * Returns ID of new PSA.
 	 * rclabou 3/15/14
 	 */
 	public function addPSA($psa)
 	{
 		$args = array();
 		$args[] = $psa->getName();
 		$args[] = $psa->getMessage();
 		$args[] = $psa->getEndDate();
 		$args[] = $psa->getSponsor();
 		
 		$conn = new sqlConnect();
 		
 		$results = $conn->callStoredProc($this->spInsertPSA, $args);	
 		$id = 0;
 		while ($rowInfo = mysqli_fetch_assoc($results)) {
 			$id = utf8_encode($rowInfo['ID']);
 			
 		}
 		return $id;
 	}
 	
 }
?>
