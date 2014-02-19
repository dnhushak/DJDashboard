<?php
/*
 * Created on Jan 28, 2014
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
class SqlConnect
{
	private $connection;
	private $username;
	private $password;
	private $database;
	private $connUrl;
	
	/**
	 * Grab default values
	 */
	public function __construct()
	{
		$this->initialize();
	}	
	

	
	
	/**
	 * Private function so it can't be called whenever
	 */
	private function initialize()
	{
		$this->username = "u30919";
		$this->password = "pkMDpK6Rh";
		$this->database = "db30919";
		$this->connUrl = "mysql.cs.iastate.edu";
		$this->connection = new mysqli($this->connUrl, $this->username, $this->password, $this->database);
		
		if(mysqli_connect_errno())
		{
			throw new exception("Failure to connect");
		}
	}
	
	
	/**
	 * Calls a stored procedure by procedurename and arguments.  If there are no args, set args to null.
	 * args must be preformatted, for an example, string Jon Doe msut have quotes around it already.
	 */
	public function callStoredProc($procedureName, $args)
	{
		//Removing values here and replacing with what is in the initialize method.
		//$this->connection = new mysqli("mysql.cs.iastate.edu", "u30919", "pkMDpK6Rh", "db30919");
		if($args != null)//Each arg in order
		{
			$cmd = "Call ".$procedureName."(";
			$length = count($args);
			for($i = 0; $i < $length - 1; $i++)
			{
				if(is_string($args[$i])){
					$cmd = $cmd."'".$args[$i]."'".",";
				}else{
					$cmd = $cmd.$args[$i].",";
				}
			}
			if(is_string($args[$length-1])){
				$cmd = $cmd."'".$args[$i]."');";
			}else{
				$cmd = $cmd.$args[$length-1].");";
			}
			$results = $this->connection->query($cmd);
		}
		else
		{
			$results = $this->connection->query("Call ".$procedureName."();");
		}
		return $results;
	}
}
?>
