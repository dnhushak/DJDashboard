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
		header("Location: index.php");
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
			<li class="cursor"><a id="manage-readers">Manage Readers</a></li>
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
			if (isset($_SESSION ['pOnAirSignOn']) && ($_SESSION ['pOnAirSignOn'] == "1")) {
				echo '<li class="cursor"><a id="on-air">On-Air</a></li>';
				echo '<li class="cursor"><a id="profile">Profile</a></li>';
			}
			
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			if ((isset($_SESSION ['pPsaManage']) && ($_SESSION ['pPsaManage'] == "1")) || (isset($_SESSION ['pGrantEdit']) && ($_SESSION ['pGrantEdit'] == "1")) || (isset($_SESSION ['pManageUsers']) && ($_SESSION ['pManageUsers'] == "1")) || (isset($_SESSION ['pPermissionEdit']) && ($_SESSION ['pPermissionEdit'] == "1")) || (isset($_SESSION ['plibrarymanage']) && ($_SESSION ['plibrarymanage'] == "1"))) {
				
				$htmlStr = '<li id="admin" class="cursor dropdown"><a id="dropdown-toggle" data-toggle="dropdown" href="#">Admin<span class="caret"></span></a><ul class="dropdown-menu">';
				if (isset($_SESSION ['pManageUsers']) && ($_SESSION ['pManageUsers'] == "1")) {
					$htmlStr .= '<li><a id="manage-user">Manage Users</a></li>';
					$htmlStr .= '<li><a class="cursor" id="view-exceptions">View Exceptions</a></li>';
				}
				if (isset($_SESSION ['pPermissionEdit']) && ($_SESSION ['pPermissionEdit'] == "1")) {
					$htmlStr .= '<li><a class="cursor" id="manage-user-types">Manage User Types</a></li>';
				}
				if (isset($_SESSION ['pLibraryManage']) && ($_SESSION ['pLibraryManage'] == "1")) {
					$htmlStr .= '<li><a class="cursor" id="analytics">Analytics</a></li>';
				}
				$htmlStr .= '</ul></li>';
				echo $htmlStr;
			}
			?>
		</ul>
		<div id="content"></div>

		<div id="footer">
			Copyright &copy; 2014 88.5 KURE Ames Alternative. All Rights
			Reserved. KURE is Funded by <a target="_BLANK" href="http://www.stugov.iastate.edu">Student
				Government</a>. <a style="float: right" href="index.php"><button
					id="logout" class="btn btn-default"
					style="position: relative; top: -8px">Logout</button></a>
			<?php
			if (session_status() == PHP_SESSION_NONE) {
				session_start();
			}
			if (isset($_SESSION ['pPermissionEdit']) && ($_SESSION ['pPermissionEdit'] == "1")) {
				$htmlStr = '<a style="float:right; margin-right:10px" href="debug.php"><button id="debug" class="btn btn-default" style="position:relative; top:-8px ">Debug</button></a>';
				echo $htmlStr;
			}
			?>
		</div>
	</div>
</body>
</html>
