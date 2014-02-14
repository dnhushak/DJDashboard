<?php
echo "PHP v" . phpversion() . " is active<br/>";
$database='db30919';
$username='u30919';
$password='pkMDpK6Rh';
$hostname='mysql.cs.iastate.edu';
$db = new mysqli($hostname, $username, $password, $database);
echo $db->client_version . " " . $db->client_info . "<br/>";
if($db->connect_errno > 0){
	die('Unable to connect to database [' . $db->connect_error . ']');
}
else{
	die('Connection is active');
}
?>