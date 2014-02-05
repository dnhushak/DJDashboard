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
	 * Can also be ran statically
	 */
	public static function dbConnect($cmd)
	{
		$conn = new SqlConnect();
	}
	/**
	 * Grab default values
	 */
	public function __construct()
	{
		initialize();
	}	
	
	/**
	 * Private function so it can't be called whenever
	 */
	private function initialize()
	{
		$connection = mysqli_connect("skynet.from-ia.com:4002", "rclabough", "Spart416", "db30919");
		
		if(mysqli_connect_errno())
		{
			throw new exception("Failure to connect");
		}
	}



}
?>
