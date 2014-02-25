<?php
include_once ("../library/Track.php");
// $msg = new HttpRequest('http://kure-automation.stuorg.iastate.edu/rest/stream.view', HttpRequest::METH_GET);
/*
 * $msg->addQueryData(array ( 'c' => "KUREDJDASH", 'u' => "kuredj", 'p' => "kuredj", 'v' => "1.8.0", 'id' => "5000" ));
 */
// Initialize the cURL session with the request URL
$session = curl_init('http://kure-automation.stuorg.iastate.edu/rest/stream.view?c=KUREDJDASH&u=kuredj&p=kuredj&v=1.8.0&id=5000');
// Tell cURL to return the request data
curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
// Set the HTTP request authentication headers
$headers = array (
		'DecibelAppID: ',
		'DecibelAppKey: ',
		'DecibelTimestamp: ' );
$tempFP = fopen('/Users/dnhushak/Documents/test.mp3', 'w+');
curl_setopt($session, CURLOPT_FILE , $tempFP);
curl_setopt($session, CURLOPT_HTTPHEADER, $headers);
curl_setopt($session, CURLOPT_BINARYTRANSFER, 1);
// Execute cURL on the session handle
$response = curl_exec($session);
// Close the cURL session
curl_close($session);
?>