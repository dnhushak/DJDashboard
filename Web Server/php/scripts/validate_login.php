<?php
	include_once '../classes/sqlconnect.php';
	include_once '../classes/Util.php';

	$socket = new Connect();
	$con = $socket->getConnection();

	$username = $_POST["username"];
	$password = $_POST["password"];

	$selectAll = $con->prepare("SELECT * FROM user WHERE username = :username LIMIT 1");
	if(!$selectAll->execute(array(':username' => $username))) 
	{
		echo "Error selecting: ";
		print_r($selectAll->errorInfo());
		die();
	}

	$results = $selectAll->fetchAll();

	if(count($results) <= 0) 
	{
	 	echo json_encode(array('error' => true,
								'message' => 'That account does not exist. Enter a different username..'));
	} 
	else
	{
		$row = $results[0];
		if(Util::verifyPass($row['pass_hash'], $password, $username))
		{
			session_start();
			$_SESSION['id'] = $row['id'];
			$_SESSION['username'] = $username;
			echo json_encode(array(
				'error' => false,
				'username' => $_SESSION['username'],
				'id' => $_SESSION['id']
			));
		}
		else
		{
			echo json_encode(array('error' => true,
									'message' => "Incorrect Password"));
			//header('Location: ../../index.php');
		}

	}