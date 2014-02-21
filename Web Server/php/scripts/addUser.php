<?php  

	/**
	 * @requires connect.php 
	 * @requires util.php
	 * @requires db.php
	 */
	require '../classes/user.php';

	session_start();

	try 
	{
		$player = new User($_POST['email'], $_POST['password'], $_POST['username'], 'rgb(255, 255, 255)');
		$player->push();

		// set the sessions
		$_SESSION['username'] = $player->__get('username');
		$_SESSION['id'] = $player->__get('id');

		echo json_encode(array(
			'player' => $player->serialize()
		));

		//header('Location: ../../main.php');
	} 
	catch(Exception $e) 
	{
		 echo json_encode(array(
		 	'error' => true,
		 	'message' => $e->getMessage(),
		 ));
	}