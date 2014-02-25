<?php
include_once ("../classes/authConfig.php");
include_once ("../classes/authUtil.php");
include_once ("../sqlconnect.php");
if (isset($_SESSION)) {
	session_unset();
}
// Get the posted user and password
$user = $_POST ['user'];
$pass = $_POST ['pass'];
// Name the stored procedure we're calling
$proc = "GetUserFromName";
$conn = new SqlConnect();
$results;
$results = $conn->callStoredProc($proc, array (
		$user ));
if (!$userinfo = mysqli_fetch_assoc($results)) {
	// error
}
else {
	$user = $userinfo ['username'];
	$hash = $userinfo ['passwordhash'];
	$salt = $userinfo ['salt'];
}
$success = authUtil::verifyPass(hashAlgo, $hash, $salt, $user, $pass);
if ($success) {
	$_SESSION ['user'] = $userinfo ['username'];
	$_SESSION ['userid'] = $userinfo ['iduser'];
	$_SESSION ['usertype'] = $userinfo ['idusertype'];
	$_SESSION ['firstname'] = $userinfo ['firstname'];
	$_SESSION ['lastname'] = $userinfo ['lastname'];
	echo "Success";
}
else {
	echo "Failure";
	session_unset();
}
echo "<br/><a href='../../webpages/djdashboard.php'>Back</a>"
?>