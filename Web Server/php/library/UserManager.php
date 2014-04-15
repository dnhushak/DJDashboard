<?php
include_once ('../sqlconnect.php');
include_once ('../publisher.php');
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
	private $spEndSession;
	private $spStartOnAirSession;
	private $spCurrentOnAirUser;
	private $spGetAllUserTypes;

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
		$this->spEndSession = "EndUserSession";
		$this->spCurrentOnAirUser = "GetCurrentOnAirUser";
		$this->spGetAllUserTypes = "GetAllUserTypes";
	}

	public function SendWelcomeEmail($email, $userName, $password){
		$subject = "Your KURE DJ Dashboard Account";
		$message = "Welcome to KURE DJ Dashboard\r\n\r\n" .
				"An account has been created for you at the KURE DJ Dashboard\r\n" .
				"Your Username is: " . $userName . "\r\n" .
				"Your Password is: " . $password . "\r\n\r\n" .
				"Upon your first login you will be prompted to change your password.";
		$headers = "From: ctvandyke24@gmail.com";
		$headers .= "Reply-To: ctvandyke24@gmail.com";
		echo $email; 
		echo "<br>";
		echo $headers;
		echo "<br>";
		echo $subject; 
		echo "<br>";
		echo $message;
		echo "<br>";

		return mail($email, $subject, $message, $headers);
	}

	public function addUser($user, $pass, $type, $first, $last, $email){
		$salt = authUtil::makeSalt(saltSize);
		$hash = authUtil::makePassHash(hashAlgo, $salt, $user, $pass);
		$proc = "AddUser";
		$conn = new SqlConnect();
		$arr = array (
				$user,
				$hash,
				$salt,
				"NULL",
				$first,
				$last,
				$type,
				$email);
		$results = $conn->callStoredProc($this->spAddUser, $arr);
		$error = mysqli_fetch_assoc($results);
		if($error['Error'] == 0 || $error['Error'] == '0'){
			$this->SendWelcomeEmail($email, $user, $pass);
		}
		return $error;
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
			//adding in user error logging, we want to keep track of failed logins.
			Publisher::publishUserError(0, $user.' tried logging in; Username and password did not match', 'UserManager.php -> login');
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
			//Modified stored proc to only take in userID, since this is being done already in php.
			//rclabou - 3/26/2014
			$conn->freeResults();
			$results = $conn->callStoredProc($this->spUserLogin, array ($_SESSION ['userid']));
			if ($results === true || $results === false) {
				Publisher::publishException('UserManager : '.mysqli_connect_errno($conn), 'Session did not start correctly', $_SESSION['userid']);
			}
			else
			{
				$row = mysqli_fetch_assoc($results);
				$_SESSION ['sessionid'] = $row['ID'];
				$_SESSION['usertypename'] = $row['UserTypeName'];
				$_SESSION['plibraryview'] = $row['LibraryView'];
				$_SESSION['plibrarymanage'] = $row['LibraryManage'];
				$_SESSION['ppsaview'] = $row['PSAView'];
				$_SESSION['ppsamanage'] = $row['PSAEdit'];
				$_SESSION['pgrantview'] = $row['GrantView'];
				$_SESSION['pgrantedit'] = $row['GrantEdit'];
				$_SESSION['pmanageusers'] = $row['ManageUsers'];
				$_SESSION['pplaylistedit'] = $row['PlaylistEdit'];
				$_SESSION['ppermissionedit'] = $row['EditPermissions'];
				$_SESSION['peditusertype'] = $row['EditUserType'];
				$_SESSION['ponairsignon'] = $row['OnAirSignOn'];
			}			
			exit();
			
		}
		
		// Incorrect password for username
		else {
			echo json_encode(array (
					"error" => "Username and password did not match." ));
			session_unset();
		}
	}
	public static function endSession($sessionID)
	{
		$conn = new SqlConnect();
		
		$results;
		// Get all information by username
		$results = $conn->callStoredProc($this->spEndSession, array (
				$sessionID ));
		if ($results === true || $results === false) {
			Publisher::publishException($_SESSION['userid'], 'Session did not end correctly', 'UserManager -> (static) endSession');
		}
	}
	
	public function startOnAirSession()
	{
		$conn = new SqlConnect();
		//$results = $conn->callStoredProc($this->spOnAirLogin, array($_SESSION['userid']));
		//if ($results === true || $results === false) {
			//Publisher::publishException($_SESSION['userid'], 'OnAir Session did not start correctly', 'UserManager -> (static) startOnAirSession');
		//}
		$results = $conn->executeScalar($this->spOnAirLogin, array($_SESSION['userid']), 'OnAirID');
		$_SESSION['onairid'] = $results;
		return $results;
	}
	
	public static function endOnAirSession()
	{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->spOnAirLogoff, array($_SESSION['userid']));
		if ($results === true || $results === false) {
			Publisher::publishException($_SESSION['userid'], 'OnAir Session did not end correctly', 'UserManager -> (static) startOnAirSession');
		}
	}
	
	public function getOnAirUser()
	{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->spCurrentOnAirUser, null);
		if ($results === true || $results === false) {
			Publisher::publishException($_SESSION['userid'], 'Session did not end correctly', 'UserManager -> (static) endSession');
			return false;
		}
		$row = mysqli_fetch_assoc($results);
		$ret = array();
		$ret['UserID'] = utf8_encode($row['UserID']);
		$ret['UserName'] = utf8_encode($row['UserName']);
		$ret['FirstName'] = utf8_encode($row['FirstName']);
		$ret['LastName'] = utf8_encode($row['LastName']);
		return $ret;
	}
	public function isOnAir(){
		$onAirID =  $this->getOnAirUser()['UserID'];
		if (session_status() == PHP_SESSION_NONE) {
	    	session_start();
		}
		if($_SESSION['userid'] == $onAirID){
			return true;
		}else{
			return false;
		}
	}
	public static function generateRandomPassword($length = 8){
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    	$randomString = '';
    	for ($i = 0; $i < $length; $i++) {
       	 	$randomString .= $characters[rand(0, strlen($characters) - 1)];
    	}
    	return $randomString;
	}
	public function GetAllUserTypes(){
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->spGetAllUserTypes, null);
		$typeArr = array();
		while($rowInfo = mysqli_fetch_assoc($results)){
			$userTypeID = $rowInfo['idusertype'];
			$typeName = $rowInfo['usertypename'];
			$plibraryview = $rowInfo['plibraryview'];
			$plibrarymanage = $rowInfo['plibrarymanage'];
			$ppsaview = $rowInfo['ppsaview'];
			$ppsamanage = $rowInfo['ppsamanage'];
			$pgrantview = $rowInfo['pgrantview'];
			$pgrantedit = $rowInfo['pgrantedit'];
			$pmanageusers = $rowInfo['pmanageusers'];
			$pplaylistedit = $rowInfo['pplaylistedit'];
			$ppermissionedit = $rowInfo['ppermissionedit'];
			$peditusertype = $rowInfo['peditusertype'];
			$onairsignon = $rowInfo['onairsignon'];
			$tempArray = array("UserTypeID" => $userTypeID,
						  "UserTypeName" => $typeName, 
						  "PLibraryView" => $plibraryview,
						  "PLibraryManage" => $plibrarymanage,
						  "PPSAView" => $ppsaview,
						  "PPSAManage" => $ppsamanage,
						  "PGrantView" => $pgrantview,
						  "PGrantEdit" => $pgrantedit,
						  "PManageUsers" => $pmanageusers,
						  "PPlaylistEdit" => $pplaylistedit,
						  "PPermissionEdit" => $ppermissionedit,
						  "PEditUserType" => $peditusertype,
						  "OnAirSignOn" => $onairsignon);
			$typeArr[] = $tempArray;
		}
		return $typeArr;
	}
}

?>