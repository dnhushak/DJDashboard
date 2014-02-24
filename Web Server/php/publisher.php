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
 
 include_once('sqlconnect.php');
 
 
 class Publisher
 {
	private static $spLogException = "LogException";
	private static $spLogError = "LogError";
	private static $spUserExceptions = "GetExceptionsByUserID";
 
 
	//publish an exception to the db
	public static function publishException($stacktrace, $message, $userID)
	{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc(Publisher::$spLogException, array($userID, $message, $stacktrace));
	}
	
	//Retrieve all exceptions when user was logged in.
	public static function getExceptionsByUser(int $userID)
	{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc($this->spUserExceptions, array($userID));
		return $results;
	}
 
	public static function publishUserError($userID, $stacktrace, $message)
	{
		try
		{
		$conn = new SqlConnect();
		$results = $conn->callStoredProc(Publisher::$spLogError, array($userID, $message, $stacktrace));
		return $results;
		}
		catch (Exception $e)
		{
			Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $userID);
		}
	}
	//Fatal error handler for PHP, can be called using register_shutdown_function( "Publisher::fatalHandler" );
	//Will call publish exception, but this handles PHP exceptions
	public static function fatalHandler()
	{
		
		$errfile = "unknown file";
		$errstr  = "shutdown";
		$errno   = E_CORE_ERROR;
		$errline = 0;

		$error = error_get_last();

		if( $error !== NULL) {
			$errno   = $error["type"];
			$errfile = $error["file"];
			$errline = $error["line"];
			$errstr  = $error["message"];
		}
		
		//Shutdown error, ignore this one, don't log.
		if($errno == 16)
		{
			return;
		}
		
		$trace = "File: ".$errfile." Line: ".$errline;
		$errstr = "ErrorNum: ".$errno." ErrorString: ".$errstr;
		Publisher::publishException($trace, $errstr, 0);

		

	}
 
 }
 
 
 
 ?>