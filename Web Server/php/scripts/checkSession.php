<?php
if (session_status() != PHP_SESSION_NONE) {
	throw new Exception('Direct script access');
}
?>