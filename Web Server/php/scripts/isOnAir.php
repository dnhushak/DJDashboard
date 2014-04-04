<?php

	if(session_status() == PHP_SESSION_NONE) {
	    session_start();
	}
	if(isset($_SESSION["onairid"])){
		echo json_encode(array("IsOnAir" => true));
	}else{
		echo json_encode(array("IsOnAir" => false));
	}

?>