<?php
/*
 * Created on Jan 28, 2014
*
* To change the template for this generated file go to
* Window - Preferences - PHPeclipse - PHP - Code Templates
*/

include_once('publisher.php');
include_once('constants.php');
include_once('scripts/stringFunctions.php');

class SqlConnect
{
	private $connection;
	private $username;
	private $password;
	private $database;
	private $connUrl;
	private $lastCommand;
	public static $lastException;
	private $CONFIG_FILE_LOC = __DIR__;
	/**
	 * Grab default values
	 */
	public function __construct()
	{
		// Fatal error handler for PHP
		//ister_shutdown_function("Publisher::fatalHandler");
		$this->initialize();
	}




	/**
	 * Private function so it can't be called whenever
	 *	Hides all connection info
	 */
	private function initialize()
	{
		try
		{
			/**$xml = simplexml_load_file($this->CONFIG_FILE_LOC . '/config.xml');
			 foreach($xml->children() as $key=>$value){
			if($key=='database'){
			$attr = $value->attributes();
			$this->connUrl = $attr['connectionString'];
			$this->username = $attr['username'];
			$this->password = $attr['password'];
			$this->database = $attr['schema'];
			}
			}**/
			/**
			$this->connUrl = 'mysql.cs.iastate.edu';
			$this->username = 'u30919';
			$this->database = 'db30919';
			$this->password = 'pkMDpK6Rh';**/
			
			$this->connUrl = SQL_URL;
			$this->username = SQL_USERNAME;
			$this->database = SQL_SCHEMA;
			$this->password = SQL_PASSWORD;



			$this->connection = new mysqli($this->connUrl, $this->username, $this->password, $this->database);

			if(mysqli_connect_errno())
			{
				throw new Exception("Failure to connect");
			}
		}
		catch (Exception $e)
		{
			//Zero is the default user, used for very low errors

				
			//Publisher::publishException($e->getTraceAsString(), $e->getMessage(), 0);
			SqlConnect::$lastException = $e;
			var_dump($this);
			return false;
		}
	}


	/**
	 * Calls a stored procedure by procedurename and arguments.  If there are no args, set args to null.
	 * args must be preformatted, for an example, string Jon Doe msut have quotes around it already.
	 */
	public function callStoredProc($procedureName, $args)
	{
		//Free result before next query.

			
		//Removing values here and replacing with what is in the initialize method.
		//$this->connection = new mysqli("mysql.cs.iastate.edu", "u30919", "pkMDpK6Rh", "db30919");
		try
		{
			if($args != null)//Each arg in order
			{
				//Check for SQL Injection.  If so, we will throw errors.
				//$args = normalizeStringArray($args);


				$cmd = "Call ".$procedureName."(";
				$length = count($args);
				//Append first arguments, do not append the last one (no final comma)
				for($i = 0; $i < $length - 1; $i++)
				{
					if(is_string($args[$i]))
					{
						$cmd = $cmd."'".$args[$i]."'".",";
					}
					else if($args[$i] === null)
					{
						$cmd = $cmd."null,";
					}
					else
					{
						$cmd = $cmd.$args[$i].",";
					}
				}
				//Append final argument (with no final comma)
				if(is_string($args[$length-1]))
				{
					//$args[$i] = mysqli_real_escape_string($args[$i]);
					$cmd = $cmd."'".$args[$i]."');";
				}
				else if($args[$i] === null)
				{
					$cmd = $cmd."null);";
				}
				else
				{
					$cmd = $cmd.$args[$i].");";
				}
				//Check for error in query, if there is, throw an exception
				if ($this->connection->error)
				{
					throw new Exception($this->connection->error);
				}
				$this->lastCommand = $cmd;
				$results = $this->connection->query($cmd);
			}
			else
			{
				$results = $this->connection->query("Call ".$procedureName."();");
			}

			return $results;
		}
		catch (Exception $e)
		{
			//Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $_SESSION['userid']);
			return false;
		}
	}
	/**
	 * Calls a stored procedure by procedurename and arguments.  If there are no args, set args to null.
	 * args must be preformatted, for an example, string Jon Doe msut have quotes around it already.
	 */
	public function callStoredProcWithDate($procedureName, $args)
	{

		try
		{
			if($args != null)//Each arg in order
			{
				//Check for SQL Injection.  If so, we will throw errors.
				//$args = normalizeStringArray($args);


				$cmd = "Call ".$procedureName."(";
				$length = count($args);
				//Append first arguments, do not append the last one (no final comma)
				for($i = 0; $i < $length - 1; $i++)
				{
					if($args[$i] == null)
					{
						$cmd = $cmd."null,";
					}
					else
					{
						$cmd = $cmd.$args[$i].",";
					}
				}
				if($args[$i] == null)
				{
					$cmd = $cmd."null);";
				}
				else
				{
					$cmd = $cmd.$args[$length-1].");";
				}
				//Check for error in query, if there is, throw an exception
				if ($this->connection->error)
				{
					throw new Exception($this->connection->error);
				}
				$this->lastCommand = $cmd;
				$results = $this->connection->query($cmd);
			}
			else
			{
				$results = $this->connection->query("Call ".$procedureName."();");
			}
			//Free results for multiple uses
			//mysqli_free_result(); NEVERMIND! DO NOT PUT IT HERE


			return $results;
		}
		catch (Exception $e)
		{
			//Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $_SESSION['userid']);
			return false;
		}
	}

	public function executeScalar($storedProcName, $args, $fieldName)
	{
		$results = $this->callStoredProc($storedProcName, $args);
		if($results == false){
			Publisher::publishException("ExecuteScalar","Resultset is boolean [false]",$_SESSION['userid']);
		}
		$row = mysqli_fetch_assoc($results);

		$field = $row[$fieldName];
		$field = utf8_encode($field);
		return $field;

	}

	public function getLastCommand()
	{
		return $this->lastCommand;
	}

	public function freeResults()
	{
		if(mysqli_more_results($this->connection))
		{
			$this->connection->next_result();
		}
	}

}



?>
