var ALERT_MINUTE = 12;
var HOUR_IN_MS = 3600000;
var MINUTE_IN_MS = 60000;
var SECOND_IN_MS = 1000;

var time = setTime(ALERT_MINUTE, false);
var timeoutTime = time + (10 * MINUTE_IN_MS);

function setTime(targetMin, cleared)
{
	var date = new Date();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	var targetMinMS = targetMin * MINUTE_IN_MS;
	var currentMS = (minutes * MINUTE_IN_MS) + (seconds * SECOND_IN_MS);
	
	if((minutes == targetMin) && !cleared)
	{
		return 0;
	}
	else if(minutes < targetMin)
	{	
		return targetMinMS - currentMS;
	}
	else
	{
		return HOUR_IN_MS - (currentMS - targetMinMS);
	}
}

var timer = setInterval(function(){grantpsaDisplay()},time);
var timeout = setInterval(function(){grantpsaTimeout()},timeoutTime);

function setGrantpsaDisplay()
{
	document.getElementById("grant_psa").innerHTML = "<div id='title'></div><div id='output' style='line-height:3em;overflow:auto;padding:5px;color:#714D03;border:4px double #411414;'></div><button style='float: right' onclick='readGrantpsa()'>Mark Read</button>";
}

function grantpsaDisplay()
{
	clearInterval(timer);
	setGrantpsaDisplay();
	var read = Math.floor(Math.random() * 2);
	if(read == 0)
	{
		$.post("../php/scripts/getGrants.php", {count: 1}, function(data)
		{                      
			var grant = JSON.parse(data);
			$('#title').html("Grant: " + grant[0]['GrantName']);
			$('#output').html(grant[0]['Message']);
		});
	}
	else
	{
		$.post("../php/scripts/getPSA.php", {count: 1}, function(data)
		{                      
			var grant = JSON.parse(data);
			$('#title').html("PSA: " + grant[0]['Name']);
			$('#output').html(grant[0]['Message']);
		});
	}
}

function grantpsaTimeout()
{
	clearInterval(timeout);
	time = setTime(ALERT_MINUTE, true);
	timer = setInterval(function() {grantDisplay()}, time)
	timeoutTime = time + (10 * MINUTE_IN_MS);
	timeout = setInterval(function() {grantTimeout()}, timeoutTime);
	clearGrantpsaDisplay();
}

function readGrantpsa()
{
	clearInterval(timeout);
	time = setTime(ALERT_MINUTE, true);
	timer = setInterval(function() {grantDisplay()}, time)
	timeoutTime = time + (10 * MINUTE_IN_MS);
	timeout = setInterval(function() {grantTimeout()}, timeoutTime);
	clearGrantpsaDisplay();
}

function clearGrantpsaDisplay()
{
	document.getElementById("grant_psa").innerHTML = "";
}