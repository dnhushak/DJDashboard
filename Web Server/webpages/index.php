<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN"> -->
<!DOCTYPE html>
<?php
session_start();
?>
<html>
<head>
<title>Kure 88.5 Ames Alternative</title>
<link rel="stylesheet" type="text/css" media="all"
	href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" media="all"
	href="../css/main.css">
	<link type="text/css" href="../jplayerSkin/jplayer.css" rel="stylesheet" media="all"/>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="../js/libraries/bootstrap.min.js"></script>
<script src="../js/scripts/login_verify.js"></script>

</head>
<body>
	<?php
		if (session_status() == PHP_SESSION_NONE) {
		    session_start();
		}
		session_unset();
	?>
	<div class="container">
		<div class="header">
			<img alt="Logo" src="../resources/logo.png">
		</div>
		<div id="content" style="border-top-left-radius: 4px; border-top-right-radius: 4px; margin-top: 10px;">
			<div class="col-md-12" style="margin-bottom: 20px;">
				<div class="alert alert-danger" id="login-error"></div>
				<form role="form">
					<div class="form-group">
						<label for="user-name">User Name</label>
						<input id="user-name" class="form-control" type="text" name="user">
					</div>
					<div class="form-group">
						<label for"password">Password</label>
						<input id="password" class="form-control" type="password"name="pass" />
					</div>
				</form>
				<button id="login" class="btn btn-default">Submit</button>
			</div>
		</div>
		<div id="footer">
			<a>Copyright © 2014 KURE 88.5 Ames Alternative. All Rights Reserved.
				KURE is Funded by the Government of the Student Body.</a>
		</div>
	</div>
</body>
</html>