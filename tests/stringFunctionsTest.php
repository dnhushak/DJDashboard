<?php
include ('../stringFunctions.php');
echo "Testing string normalization functions...<br/><br/>Periods are placed to show extra spaces<br/><br/>";
$str [1] = "cApiTaliZAtIon tEST";
$str [2] = "!@#$%^&*()-=+[]{}\|/'\";:?.,><`~ Björk çäñ't séê án¥thîng";
$str [3] = " ";
$str [4] = "";
$str [5] = "The Le Les Articles Test";
$str [6] = " Leading Space Test";
$str [7] = "Trailing Space Test   ";
$str [8] = " Weird    Spaces 		Test     ";
$str [9] = "DROP TABLE *";
foreach ($str as $val) {
	echo "." . $val . "." . "  ->  " . "." . normalizeAll($val) . "." . "<br/>";
}
?>