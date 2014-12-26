<?php
include ('./classes/authConfig.php');

// Get the posted user and password
$user = $_POST ['user'];
$pass = $_POST ['pass'];

// Connect to the database
$conn = new SqlConnect();

$results;
// Get all information by username
$results = $conn->callStoredProcArr($this->spGetUserFromName, array (
		$user ));

// If username does not exist
if ($results === true || $results === false) {
	echo json_encode(array (
			"error" => "Username and password did not match." . $user ));
	// adding in user error logging, we want to keep track of failed logins.
	Publisher::publishUserError(0, $user . ' tried logging in; Username and password did not match', 'UserManager.php -> login');
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
	echo "Success";
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
	$results = $conn->callStoredProc($this->spUserLogin, array (
			$_SESSION ['userid'] ));
	if ($results === true || $results === false) {
		Publisher::publishException('UserManager : ' . mysqli_connect_errno($conn), 'Session did not start correctly', $_SESSION ['userid']);
	}
	else {
		$row = mysqli_fetch_assoc($results);
		$_SESSION ['sessionid'] = $row ['ID'];
		$_SESSION ['UserType'] = $row ['UserTypeName'];
		$_SESSION ['pLibraryView'] = $row ['LibraryView'];
		$_SESSION ['pLibraryManage'] = $row ['LibraryManage'];
		$_SESSION ['pPsaView'] = $row ['PSAView'];
		$_SESSION ['pPsaManage'] = $row ['PSAEdit'];
		$_SESSION ['pGrantBiew'] = $row ['GrantView'];
		$_SESSION ['pGrantEdit'] = $row ['GrantEdit'];
		$_SESSION ['pManageUsers'] = $row ['ManageUsers'];
		$_SESSION ['pPermissionEdit'] = $row ['EditPermissions'];
		$_SESSION ['pUserTypeEdit'] = $row ['EditUserType'];
		$_SESSION ['pOnAirSignOn'] = $row ['OnAirSignOn'];
		$_SESSION ['isFirstLogin'] = $row ['IsFirstLogin'];
		$_SESSION ['pEditSchedule'] = $row ['EditSchedule'];
	}
	exit();
}

// Incorrect password for username
else {
	echo json_encode(array (
			"error" => "Username and password did not match." ));
	session_unset();
}
?>