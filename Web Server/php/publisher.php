<?php
/*
 * Created 2/18/2014
 * Author: Robert Clabough
 *
 *
 *  PUBLISHER
 *  Used to publish errors and exceptions to database.
 *  Can also retrieve a list of errors given a time frame or user ID.
 *  Work with the (future) user class to retrieve user IDs
 **/

 
 class Publisher
 {
	private static $spLogException = "LogException";
	private static $spLogError = "LogError";
	private static $spUserExceptions = "GetExceptionsByUserID";
 
 
	//publish an exception to the db
	public static function publishException(string $stacktrace, string $message, int $userID)
	{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->spLogException, array($userID, $message, $stacktrace));
	}
	
	//Retrieve all exceptions when user was logged in.
	public static function getExceptionsByUser(int $userID)
	{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->spLogException, array($userID));
	}
 
 
 
 }
 
 
 
 ?>