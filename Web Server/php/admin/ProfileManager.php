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
include_once ('Profile.php');

class ProfileManager {
	private $spGetDJs;
	private $spGetProfile;
	private $spGetAllUsers;

	public function __construct() {
		$this->initialize();
	}

	/**
	 * Build constant procedure names
	 */
	private function initialize() {
		$this->spGetDJs = "GetDJs";
		$this->spGetProfile = "GetUserProfile";
		$this->spGetAllUsers = "GetAllUsers";
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
	
	
	public function getAllUsers(){
		$conn = new sqlConnect();
		
		$results = $conn->callStoredProc($this->spGetAllUsers, null);

		$users = array ();

		while ($rowInfo = mysqli_fetch_assoc($results)) {
			$users[] = User :: setFromAllUser($rowInfo);
		}
		
		return $users;
	}

	/**
	 * Gets all profile information based on userID
	 */
	public function getProfile($userID) {
		$conn = new sqlConnect();
		$result = $conn->callStoredProc($this->spGetProfile, array($userID));
		//Only gets one row back
		$rowInfo = mysqli_fetch_assoc($result);
		$prof = new Profile();
		$prof->setProfileID(utf8_encode($rowInfo['UserProfileID']));
		$prof->setUserID(utf8_encode($rowInfo['UserID']));
		$prof->setNickname(utf8_encode($rowInfo['NickName']));
		$prof->setBio(utf8_encode($rowInfo['Bio']));
		$prof->setMotto(utf8_encode($rowInfo['Motto']));
		$prof->setOnAir(utf8_encode($rowInfo['OnAir']));
		return $prof;
	}
}
?>
