<?php

	include_once('../library/UserManager.php');
  
  	$manager = new UserManager();

	if(session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
	if($manager->isOnAir()){
		echo json_encode(array("IsOnAir" => true));
	}else{
		echo json_encode(array("IsOnAir" => false));
	}

?>