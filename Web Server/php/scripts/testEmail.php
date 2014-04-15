<?php

include_once ('../library/UserManager.php');
$manager = new UserManager();

$email = "ctvandyke24@gmail.com";
$username = "caleb";
$pass = "pass";

var_dump( $manager->SendWelcomeEmail($email, $username, $pass) );


?>