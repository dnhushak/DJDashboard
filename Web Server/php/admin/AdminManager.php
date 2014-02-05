<?php

	class AdminManager
	{
		public function addUser($userName, $userTypeID)
		{
			$conn = new SqlConnect();
			$result = $conn->callProcedure("AddUser", array($userName, $userTypeID));
			
		}
		
		public function getUserTypes()
		{
			$conn = new SqlConnect();
			$result = $conn->callProcedure("GetUserTypes", array(
		}
	}
?>