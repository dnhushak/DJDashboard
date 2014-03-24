<?php
include('../library/UserManager.php');
// Get the posted user and password
$user = $_POST ['user'];
$pass = $_POST ['pass'];
$manager = new UserManager();
$manager->login($user, $pass);
?>