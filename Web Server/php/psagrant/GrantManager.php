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
	private $spGetAllGrantInfo;

	public function __construct() {
		$this->initialize();
	}

	public function initialize() {
		$this->spGetEligibleGrants = "GetEligibleGrants";
		$this->spGetAllGrantInfo = "GetAllGrantInfo";
	}

	/**
	 * Retrieves $numberOfGrant (int) number of grants back to the the calling program.  This will return an array of Grant objects.
	 */
	public function getGrants($numberOfGrants) {
		try {
			//Retrieve all eligible grants
			$conn = new sqlConnect();
			$results = $conn->callStoredProc($this->spGetEligibleGrants, null);
			if ($results == false) {
				throw new Exception("Error in SQL Query in GrantManager.getGrants()");
			}
			$eligibleGrants = array ();
			while ($rowInfo = mysqli_fetch_assoc($results)) {
				$tempGrant = new Grant();
				$tempGrant->setGrantID(utf8_encode($rowInfo['GrantID']));
				$tempGrant->setPlayCount(utf8_encode($rowInfo['PlayCount']));
				$tempGrant->setStartDate(utf8_encode($rowInfo['StartDate']));
				$tempGrant->setEndDate(utf8_encode($rowInfo['EndDate']));
				$tempGrant->setTimeLeft(utf8_encode($rowInfo['TimeLeft']));
				$tempGrant->setMaxPlayCount(utf8_encode($rowInfo['MaxPlayCount']));
				
				
				//Calculate the priority
				$playDiff = $tempGrant->getMaxPlayCount() - $tempGrant->getPlayCount();
				$dateDiff = $tempGrant->getTimeLeft();
				
				//RATIO
				$tempGrant->setPriority($playDiff * pow(10, 6) / $dateDiff);

				$eligibleGrants[] = $tempGrant;
			}
			$arrLen = count($eligibleGrants);
			$min = $numberOfGrants;
			if ($arrLen < $min) {
				$min = $arrLen;
			}

			//Sort them by priority
			usort($eligibleGrants, "Grant::cmp");

			$finalArr = array ();

			for ($i = 0; $i < $min; $i++) {
				//Call for rest of data.
				$conn->freeResults();
				$results = $conn->callStoredProc($this->spGetAllGrantInfo, array (
					$eligibleGrants[$i]->getGrantID()
				));
				while ($rowInfo = mysqli_fetch_assoc($results)) {
					$eligibleGrants[$i]->setGrantName(utf8_encode($rowInfo['GrantName']));
					$eligibleGrants[$i]->setMessage(utf8_encode($rowInfo['Message']));
				}
				$finalArr[] = $eligibleGrants[$i];
			}

			return $finalArr;

		} catch (Exception $e) {
			Publisher :: publishException($e->getTraceAsString(), $e->getMessage(), 0);
			return false;
		}

	}
}
?>
