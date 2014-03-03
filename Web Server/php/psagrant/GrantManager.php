<?php

/*
 * Created on Mar 3, 2014
 *
 * Created by Robert Clabough
 */

include_once '../sqlconnect.php';
include_once 'Grant.php';
include_once '../publisher.php';

/**
 * Created to take care of grants and modify them.
 */
class GrantManager {

	private $spGetEligibleGrants;

	public function __construct() {
		$this->initialize();
	}

	public function initialize() {
		$this->spGetEligibleGrants = "getEligibleGrants";
	}

	public function getGrants($numberOfGrants) {
		try {
			//Retrieve all eligible grants
			$conn = new sqlConnect();
			$results = $conn->callStoredProc($this->spGetEligibleGrants, null);
			if($results == false)
			{
				throw new Exception("Error in SQL Query in GrantManager.getGrants()");
			}
			$eligibleGrants = array();
			while($rowInfo = mysqli_fetch_assoc($results)){
				$tempGrant = new Grant();
				$tempTrack->setArtist(utf8_encode($rowInfo['idArtist']));
				$trackList[] = $tempTrack;
			}	
			
			
		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}

	}
}
?>
