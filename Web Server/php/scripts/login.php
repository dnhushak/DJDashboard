<?php
include_once ("../classes/authConfig.php");
include_once ("../classes/authUtil.php");
include_once ("../sqlconnect.php");
// Get the posted user and password
$user = $_POST ['user'];
$pass = $_POST ['pass'];
// Name the stored procedure we're calling
$proc = "GetUserFromName";
// Connect to the database
$conn = new SqlConnect();
$results;
$results = $conn->callStoredProc($proc, array ( $user ));

if($results === true || $results === false){
	echo json_encode(array("error" => "Username and password did not match."));
	session_unset();
	exit();
}

if (!$userinfo = mysqli_fetch_assoc($results)) {
	// error
}
else {
	$user = $userinfo['username'];
	$hash = $userinfo['passwordhash'];
	$salt = $userinfo['salt'];
}
$success = authUtil::verifyPass(hashAlgo, $hash, $salt, $user, $pass);
if ($success) {
	if (session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
	$_SESSION ['user'] = $userinfo ['username'];
	$_SESSION ['userid'] = $userinfo ['iduser'];
	$_SESSION ['usertype'] = $userinfo ['idusertype'];
	$_SESSION ['firstname'] = $userinfo ['firstname'];
	$_SESSION ['lastname'] = $userinfo ['lastname'];
	exit();
}
else {
	echo json_encode(array("error" => "Username and password did not match."));
	session_unset();
}