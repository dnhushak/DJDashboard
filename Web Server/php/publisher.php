<?php
/*
 * Created 2/18/2014 Author: Robert Clabough PUBLISHER Used to publish errors and exceptions to database. Can also retrieve a list of errors given a time frame or user ID. Work with the (future) user class to retrieve user IDs
 */
include_once ('sqlconnect.php');
class Publisher {
	private static $spLogException = "LogException";
	private static $spLogError = "LogError";
	private static $spUserExceptions = "GetExceptionsByUserID";
	private static $spGetExceptions = "GetExceptions";
	
	// publish an exception to the db
	public static function publishException($stacktrace, $message, $userID) {
		//Access the session if userID is null, may still be null if session is not set
		if($userID == null)
		{
			$userID = $_SESSION['userid']; //This may, in turn, throw an exception if session is not set.
		}
		$conn = new SqlConnect ();
		$results = $conn->callStoredProc ( Publisher::$spLogException, array (
				$userID,
				$message,
				$stacktrace 
		) );
	}
	
	// Retrieve all exceptions when user was logged in.
	public static function getExceptionsByUser(int $userID) {
		$conn = new SqlConnect ();
		$results = $conn->callStoredProc ( $this->spUserExceptions, array (
				$userID 
		) );
		return $results;
	}
	public static function publishUserError($userID, $stacktrace, $message) {
		try {
			$conn = new SqlConnect ();
			$results = $conn->callStoredProc ( Publisher::$spLogError, array (
					$userID,
					$message,
					$stacktrace 
			) );
			return $results;
		} catch ( Exception $e ) {
			Publisher::publishException ( $e->getTraceAsString (), $e->getMessage (), $userID );
		}
	}
	// Fatal error handler for PHP, can be called using register_shutdown_function( "Publisher::fatalHandler" );
	// Will call publish exception, but this handles PHP exceptions
	public static function fatalHandler() {
		$errfile = "unknown file";
		$errstr = "shutdown";
		$errno = E_CORE_ERROR;
		$errline = 0;
		
		$error = error_get_last ();
		
		if ($error !== NULL) {
			$errno = $error ["type"];
			$errfile = $error ["file"];
			$errline = $error ["line"];
			$errstr = $error ["message"];
		}
		
		// Shutdown error, ignore this one, don't log.
		if ($errno == 16) {
			return;
		}
		
		$trace = "File: " . $errfile . " Line: " . $errline;
		$errstr = "ErrorNum: " . $errno . " ErrorString: " . $errstr;
		Publisher::publishException ( $trace, $errstr, 0 );
	}
	
	/**
	 * Get all of the latest errors and display them in an array[][]
	 * 
	 * @param unknown $size
	 *        	How many errors to get
	 */
	public static function getLatestExceptions() {
		try {
			$conn = new sqlConnect ();
			$results = $conn->callStoredProc ( Publisher::$spGetExceptions, null );
			if ($results == false) {
				throw new exception ( "AlbumResults are null in LibraryManager.GetTracksLike()" );
			}
			$exceptionArr = array();
			while ( $rowInfo = mysqli_fetch_assoc ( $results ) ) {
				$tempArr = array();
				$tempArr['ExceptionLogID'] = utf8_encode ( $rowInfo ['ExceptionLogID'] ) ;
				$tempArr['Message'] = utf8_encode ( $rowInfo ['message'] ) ;
				$tempArr['StackTrace'] = utf8_encode ( $rowInfo ['stacktrace'] ) ;
				$tempArr['CreateDate'] = utf8_encode ( $rowInfo ['createdate'] ) ;
				$tempArr['UserID'] = utf8_encode ( $rowInfo ['UserID'] ) ;
				$tempArr['UserName'] = utf8_encode ( $rowInfo ['UserName'] ) ;
				$tempArr['LastName'] = utf8_encode ( $rowInfo ['LastName'] ) ;
				$tempArr['FirstName'] = utf8_encode ( $rowInfo ['FirstName'] ) ;
				$exceptionArr[] = $tempArr;
			}
			return $exceptionArr;
		} catch ( Exeption $e ) {
			Publisher::publishException ( $e->getTraceAsString (), $e->getMessage (), 0 );
		}
	}
}

?>