<!DOCTYPE html>
<html>
<head>
<title>Kure 88.5 Ames Alternative</title>
<link rel="stylesheet" type="text/css" media="all"
	href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" media="all"
	href="../css/main.css">
<link type="text/css" href="../jplayerSkin/jplayer.css" rel="stylesheet"
	media="all" />
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="../js/libraries/bootstrap.min.js"></script>
<script src="../js/scripts/PageLoad.js"></script>
<script src="../js/scripts/initialLoad.js"></script>
<script src="../js/classes/Artist.js"></script>
<script src="../js/classes/Album.js"></script>
<script src="../js/classes/Track.js"></script>
<script src="../js/libraries/typeahead.js"></script>
<script src="../js/libraries/handlebars.js"></script>
<script src="../js/scripts/exceptionView.js"></script>

</head>
<body>
	<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	if (!isset($_SESSION ['user'])) {
		echo("session variable user not set!");
		//header("Location: index.php");
		exit();
	}
	?>
	<nav class="navbar navbar-default navbar-fixed-top on-air-display"
		role="navigation" style="border: 0;">
		<div class="container-fluid" style="background-color: #9FF781;">
			<div class="navbar-header">
				<span class="navbar-brand" style="color: black;">ON AIR</span>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#" id="off-air-button">Go Off Air</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="header">
			<img alt="Logo" src="../resources/logo.png">
		</div>
		<ul class="nav nav-tabs nav-justified">
			<li class="cursor active"><a id="home" style="cursor: pointer">Home</a></li>
			<?php
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			if (isset($_SESSION ['pLibraryView']) && ($_SESSION ['pLibraryView'] == "1")) {
				echo '<li class="cursor"><a id="library">Library</a></li>';
			}
			?>
			<?php
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			if (isset($_SESSION ['ponairsignon']) && ($_SESSION ['ponairsignon'] == "1")) {
				echo '<li class="cursor"><a id="on-air">On-Air</a></li>';
				echo '<li class="cursor"><a id="profile">Profile</a></li>';
			}
			?>
			<?php
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			if ((isset($_SESSION ['ppsamanage']) && ($_SESSION ['ppsamanage'] == "1")) || (isset($_SESSION ['pgrantedit']) && ($_SESSION ['pgrantedit'] == "1")) || (isset($_SESSION ['pmanageusers']) && ($_SESSION ['pmanageusers'] == "1")) || (isset($_SESSION ['peditusertype']) && ($_SESSION ['peditusertype'] == "1")) || (isset($_SESSION ['plibrarymanage']) && ($_SESSION ['plibrarymanage'] == "1"))) {
				
				$htmlStr = '<li id="admin" class="cursor dropdown"><a id="dropdown-toggle" data-toggle="dropdown" href="#">Admin<span class="caret"></span></a><ul class="dropdown-menu">';
				if (isset($_SESSION ['ppsamanage']) && ($_SESSION ['ppsamanage'] == "1")) {
					$htmlStr .= '<li><a class="cursor" id="manage-psa">Manage PSAs</a></li>';
				}
				if (isset($_SESSION ['pgrantedit']) && ($_SESSION ['pgrantedit'] == "1")) {
					$htmlStr .= '<li><a class="cursor" id="manage-grant">Manage Grants</a></li>';
				}
				if (isset($_SESSION ['pmanageusers']) && ($_SESSION ['pmanageusers'] == "1")) {
					$htmlStr .= '<li><a id="manage-user">Manage Users</a></li>';
					$htmlStr .= '<li><a class="cursor" id="view-exceptions">View Exceptions</a></li>';
				}
				if (isset($_SESSION ['peditusertype']) && ($_SESSION ['peditusertype'] == "1")) {
					$htmlStr .= '<li><a class="cursor" id="manage-user-types">Manage User Types</a></li>';
				}
				if (isset($_SESSION ['plibrarymanage']) && ($_SESSION ['plibrarymanage'] == "1")) {
					$htmlStr .= '<li><a class="cursor" id="analytics">Analytics</a></li>';
				}
				$htmlStr .= '</ul></li>';
				echo $htmlStr;
			}
			?>
		</ul>
		<div id="content"></div>
		<div id="footer">
			<a>Copyright © 2014 KURE 88.5 Ames Alternative. All Rights Reserved.
				KURE is Funded by the Government of the Student Body.</a> <a
				style="float: right;" href="index.php">Logout</a>
			<?php
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			if (isset($_SESSION ['ppermissionedit']) && ($_SESSION ['ppermissionedit'] == "1")) {
				$htmlStr .= '<a style="float: right;" href="debug.php">Debug</a>';
			}
			?>
		</div>
	</div>
</body>
</html>
