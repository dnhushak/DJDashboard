<?php
include ('../library/UserManager.php');
$user = $_POST ['user'];
$pass = $_POST ['pass'];
$first = $_POST ['first'];
$last = $_POST ['last'];
$type = $_POST ['type'];

$manager = new UserManager();
$manager->addUser($user, $pass, $type, $first, $last);

?>