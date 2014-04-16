<?php
if (session_status() == PHP_SESSION_NONE) {
	session_start();
}
	echo(JSON_ENCODE($_SESSION));
?>