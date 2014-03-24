<?php
include_once '../sqlconnect.php';
include_once '../publisher.php';
include_once ("../classes/authConfig.php");
include_once ("../classes/authUtil.php");

class UserManager {
	private $spOnAirLogin;
	private $spOnAirLogout;
	private $spUserLogin;
	private $spUserLogout;
	private $spAddUser;
	private $spAddUserType;
	private $spGetUserFromName;

	public function __construct(){
		$this->initialize();
	}

	/**
	 * Build constant procedure names
	 */
	private function initialize(){
		// Register failure procedure
		register_shutdown_function("Publisher::fatalHandler");
		
		$this->spOnAirLogin = "OnAirLogin";
		$this->spOnAirLogout = "OnAirLogout";
		$this->spUserLogin = "UserLogin";
		$this->spUserLogout = "UserLogout";
		$this->spAddUser = "AddUser";
		$this->spAddUserType = "AddUserType";
		$this->spGetUserFromName = "GetUserFromName";
	}

	public function login($user, $pass){
		
		// Connect to the database
		$conn = new SqlConnect();
		
		$results;
		// Get all information by username
		$results = $conn->callStoredProc($this->spGetUserFromName, array (
				$user ));
		
		// If username does not exist
		if ($results === true || $results === false) {
			echo json_encode(array (
					"error" => "Username and password did not match." ));
			session_unset();
			exit();
		}
		
		if (!$userinfo = mysqli_fetch_assoc($results)) {
			// error
		}
		
		// Get stored username, hashed password, and salt
		else {
			$user = $userinfo ['username'];
			$hash = $userinfo ['passwordhash'];
			$salt = $userinfo ['salt'];
		}
		
		// Verify supplied username hash and salt
		$success = authUtil::verifyPass(hashAlgo, $hash, $salt, $user, $pass);
		
		// Successful login, start a new session with all info
		if ($success) {
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			$_SESSION ['user'] = $userinfo ['username'];
			$_SESSION ['userid'] = $userinfo ['iduser'];
			$_SESSION ['usertype'] = $userinfo ['idusertype'];
			$_SESSION ['firstname'] = $userinfo ['firstname'];
			$_SESSION ['lastname'] = $userinfo ['lastname'];
			$results = $conn->callStoredProc($this->spUserLogin, array (
					$_SESSION ['userid'],
					$hash,
					0 ));
		}
		
		// Incorrect password for username
		else {
			echo json_encode(array (
					"error" => "Username and password did not match." ));
			session_unset();
		}
	}
}

?>