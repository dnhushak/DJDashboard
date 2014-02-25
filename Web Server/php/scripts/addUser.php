<?php
include_once ("../classes/authConfig.php");
include_once ("../classes/authUtil.php");
include_once ("../sqlconnect.php");
$attemptuser = $_GET ['username'];
$attemptpass = $_GET ['password'];
$attemptfirstname = $_GET ['first'];
$attemptlastname = $_GET ['last'];
$salt = authUtil::makeSalt(saltSize);
echo "<br/>" . $salt . "<br/>";
$hash = authUtil::makePassHash(hashAlgo, $salt, $attemptuser, $attemptpass);
// $attemptuser = 100;
$proc = "AddUser";
echo $attemptuser . "<br/>";
$conn = new SqlConnect();
$arr = array (
		$attemptuser,
		$hash,
		$salt,
		"NULL",
		$attemptfirstname,
		$attemptlastname,
		"1" );
var_dump($arr);
$results;
$results = $conn->callStoredProc($proc, array (
		$attemptuser,
		$hash,
		$salt,
		"NULL",
		$attemptfirstname,
		$attemptlastname,
		"1" ));
// if (!$userinfo = mysqli_fetch_assoc($results)) {
// error
// }
?>