<?php
include ('../library/UserManager.php');

$manager = new UserManager();

$user = $_POST ['user'];

if(isset($_POST['pass'])){
	$pass = $_POST ['pass'];
}else{
	$pass = $manager->generateRandomPassword();
}

$first = $_POST ['first'];
$email = $_POST ['email'];
$last = $_POST ['last'];
$type = $_POST ['type'];

echo json_encode($manager->addUser($user, $pass, $type, $first, $last, $email));

?>