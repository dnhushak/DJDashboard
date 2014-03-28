<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN"> -->

<!DOCTYPE html>
<html>
<head>
<title>Kure 88.5 Ames Alternative</title>
<link rel="stylesheet" type="text/css" media="all"
	href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" media="all"
	href="../css/main.css">
	<link type="text/css" href="../jplayerSkin/jplayer.css" rel="stylesheet" media="all"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../js/libraries/bootstrap.min.js"></script>
<script src="../js/scripts/PageLoad.js"></script>
<script src="../js/scripts/initialLoad.js"></script>
<script src="../js/classes/Artist.js"></script>
<script src="../js/classes/Album.js"></script>
<script src="../js/classes/Track.js"></script>
<script src="../js/libraries/typeahead.js"></script>
<script src="../js/libraries/handlebars.js"></script>

</head>
<body>
	<?php
		if (session_status() == PHP_SESSION_NONE) {
		    session_start();
		}
		if(!isset($_SESSION['user'])){
			header("Location: index.php");
			exit();
		}
	?>
<!-- 	<nav class="navbar navbar-default navbar-fixed-top on-air-nav" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
			<span class="navbar-brand" style="color: black;">ON AIR</span>
		</div>
	</nav> -->
	<div class="container">
		<div class="header">
			<img alt="Logo" src="../resources/logo.png">
		</div>
		<ul class="nav nav-tabs nav-justified">
			<li class="active"><a id="home" style="cursor: pointer">Home</a></li>
			<li><a id="library" style="cursor: pointer">Library</a></li>
			<li><a id="on-air" style="cursor: pointer">On-Air</a></li>
			<li><a id="profile" style="cursor: pointer">Profile</a></li>
		</ul>
		<div id="content"></div>
		<div id="footer">
			<a>Copyright © 2014 KURE 88.5 Ames Alternative. All Rights Reserved.
				KURE is Funded by the Government of the Student Body.</a>
			<a style="float: right;" href="index.php">Logout</a>
		</div>
	</div>
</body>
</html>