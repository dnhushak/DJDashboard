<?php


include('../library/UserManager.php');
include_once('../publisher.php');

	//Fatal error handler for PHP
register_shutdown_function( "Publisher::fatalHandler" );


try
{
 	$typeID = $_GET['TypeID'];
	$libView = ($_GET['LibraryView'] == 'true' ? 1 : 0);
	$libEdit = ($_GET['LibraryEdit'] == 'true' ? 1 : 0);
	$PSAView = ($_GET['PSAView'] == 'true' ? 1 : 0);
	$PSAEdit = ($_GET['PSAEdit'] == 'true' ? 1 : 0);
	$grantView = ($_GET['GrantView'] == 'true' ? 1 : 0);
	$grantEdit = ($_GET['GrantEdit'] == 'true' ? 1 : 0);
	$manageUsers = ($_GET['ManageUsers'] == 'true' ? 1 : 0);
	$plEdit = ($_GET['PlaylistEdit'] == 'true' ? 1 : 0);
	$permEdit = ($_GET['PermissionEdit'] == 'true' ? 1 : 0);
	$userTypeEdit = ($_GET['UserTypeEdit'] == 'true' ? 1 : 0);
	$onAirSignon = ($_GET['OnAirSignOn'] == 'true' ? 1 : 0);
	
	
	$manager = new UserManager();
	$id = $manager->UpdateUserType($typeID, $libView, $libEdit, $PSAView, $PSAEdit,
	 						$grantView, $grantEdit, $manageUsers, $plEdit,
	 						$permEdit, $userTypeEdit, $onAirSignon);
	echo json_encode($id);
}
catch (Exception $e)
{
	Publisher::publishException($e->getTraceAsString(), $e->getMessage(), $UserID);
	return false;
}
	
 
?>
