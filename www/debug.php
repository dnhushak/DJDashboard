<?php
if (session_status() == PHP_SESSION_NONE) {
	session_start();
}
	echo('<h1>Session Variables</h1>');

	
	foreach(array_keys($_SESSION) as $key){
		echo "<h3>".$key."</h3>  ".$_SESSION[$key]."<br>";
	}
?>