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
		$connection = new mysqli("mysql.cs.iastate.edu", "u30919", "pkMDpK6Rh", "db30919");
		
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
		$connection = new mysqli("mysql.cs.iastate.edu", "u30919", "pkMDpK6Rh", "db30919");
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
			$results = $connection->query($cmd);
		}
		else
		{
			$results = $connection->query("Call ".$procedureName."();");
		}
		return $results;
	}
}
?>
