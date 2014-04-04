<?php

/*
 * Created on Apr 1, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */

include_once ('../library/UserManager.php');
include_once ('../publisher.php');
include_once ('../sqlconnect.php');
include_once ('User.php');

class ProfileManager {
	private $spGetDJs;
	private $spGetProfile;

	public function __construct() {
		$this->initialize();
	}

	/**
	 * Build constant procedure names
	 */
	private function initialize() {
		$this->spGetDJs = "GetDJs";
		$this->spGetProfile = "GetUserProfile";
	}

	/**
	 * Gets all of the DJs that have a profile.
	 * Every DJ should have a profile.
	 */
	public function getDJs() {
		$conn = new sqlConnect();

		$results = $conn->callStoredProc($this->spGetDJs, null);

		$djArr = array ();

		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$djArr[] = User :: setFromTable($rowInfo);
		}
		
		return $djArr;

	}

	/**
	 * Gets all profile information based on userID
	 */
	public function getProfile($userID) {
		//TODO
	}
}
?>
