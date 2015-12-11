<?php
include ('./classes/authConfig.php');
include ('./classes/authUtil.php');
include ('./sqlconnect.php');
// Get the posted user and password
$user = $_POST ['user'];
$pass = $_POST ['pass'];

// Connect to the database
$conn = new SqlConnect();

$results;
// Get all information by username
$results = $conn->callStoredProcArr("GetUserFromName", $user);

// Grab first (and hopefully only) row of user info
$userinfo = $results [0];

// If username does not exist
if ($results === true || $results === false) {
	echo json_encode(array (
			"error" => "Username and password did not match." ));
	// adding in user error logging, we want to keep track of failed logins.
	Publisher::publishUserError(0, $user . ' tried logging in; Username did not exist', 'login.php');
	session_unset();
	exit();
}

// Get stored username, hashed password, and salt
else {
	$user = $userinfo ['username'];
	$hash = $userinfo ['passwordhash'];
	$salt = $userinfo ['salt'];
}

// Verify supplied username hash and salt
$success = authUtil::verifyPass(HASHALGO, $hash, $salt, $user, $pass);

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
	// Modified stored proc to only take in userID, since this is being done already in php.
	$conn->freeResults();
	$results = $conn->callStoredProcArr("UserLogin", $_SESSION ['userid']);
	
	if ($results === true || $results === false) {
		Publisher::publishException('UserManager : ' . mysqli_connect_errno($conn), 'Session did not start correctly', $_SESSION ['userid']);
		exit();
	}
	else {
		// Grab first row of results
		$results = $results [0];
		$_SESSION ['sessionid'] = $results ['ID'];
		$_SESSION ['UserType'] = $results ['UserTypeName'];
		$_SESSION ['pLibraryView'] = $results ['LibraryView'];
		$_SESSION ['pLibraryManage'] = $results ['LibraryManage'];
		$_SESSION ['pPsaView'] = $results ['PSAView'];
		$_SESSION ['pPsaManage'] = $results ['PSAEdit'];
		$_SESSION ['pGrantView'] = $results ['GrantView'];
		$_SESSION ['pGrantEdit'] = $results ['GrantEdit'];
		$_SESSION ['pManageUsers'] = $results ['ManageUsers'];
		$_SESSION ['pPermissionEdit'] = $results ['EditPermissions'];
		$_SESSION ['pUserTypeEdit'] = $results ['EditUserType'];
		$_SESSION ['pOnAirSignOn'] = $results ['OnAirSignOn'];
		$_SESSION ['isFirstLogin'] = $results ['IsFirstLogin'];
		$_SESSION ['pEditSchedule'] = $results ['EditSchedule'];
		var_dump($_SESSION);
	}
	exit();
}

// Incorrect password for username
else {
	echo json_encode(array (
			"error" => "Username and password did not match." ));
	Publisher::publishUserError(0, $user . ' tried logging in; Incorrect password', 'login.php');
	session_unset ();
	exit();
}
?>