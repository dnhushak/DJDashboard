var GRANT_ALERT_MINUTE = 40;
var PSA_ALERT_MINUTE = 15;
var HOUR_IN_MS = 3600000;
var MINUTE_IN_MS = 60000;
var SECOND_IN_MS = 1000;
var GRANT = false;

var grantTime = setTime(GRANT_ALERT_MINUTE, false);
var grantTimeoutTime = grantTime + (10 * MINUTE_IN_MS);
var psaTime = setTime(PSA_ALERT_MINUTE, false);
var psaTimoutTime = psaTime + (10 * MINUTE_IN_MS);

var grantTimer = setInterval(function(){grantDisplay()},grantTime);
var grantTimeout = setInterval(function(){grantTimeout()},grantTimeoutTime);
var psaTimer = setInterval(function() {psaDisplay()},psaTime);
var psaTimeout = setInterval(function() {psaTimeout()}, psaTimeoutTime);

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

function grantDisplay()
{
	clearInterval(grantTimer);
	setGrantOrPsaDisplay();
	GRANT = true;
	$.post("../php/scripts/getGrants.php", {count: 1}, function(data)
	{                      
		var grant = JSON.parse(data);
		$('#title').html("Grant: " + grant[0]['GrantName']);
		$('#output').html(grant[0]['Message']);
	});
}

function psaDisplay()
{
	clearInterval(psaTimer);
	setGrantOrPsaDisplay();
	GRANT = false;
	$.post("../php/scripts/getPSA.php", {count: 1}, function(data)
	{                      
		var psa = JSON.parse(data);
		$('#title').html("PSA: " + psa[0]['Name']);
		$('#output').html(psa[0]['Message']);
	});
}

function setGrantOrPsaDisplay()
{
	document.getElementById("grant_psa").innerHTML = "<div id='title'></div><div id='output' style='line-height:3em;overflow:auto;padding:5px;color:#714D03;border:4px double #411414;'></div><button style='float: right' onclick='readGrantOrPsa()'>Mark Read</button>";
}

function grantTimeout()
{
	clearInterval(grantTimeout);
	grantTime = setTime(GRANT_ALERT_MINUTE, true);
	grantTimer = setInterval(function() {grantDisplay()}, grantTime)
	grantTimeoutTime = time + (10 * MINUTE_IN_MS);
	grantTimeout = setInterval(function() {grantTimeout()}, grantTimeoutTime);
	GRANT = false;
	clearDisplay();
}

function psaTimeout()
{
	clearInterval(psaTimeout);
	psaTime = setTime(PSA_ALERT_MINUTE, true);
	psaTimer = setInterval(function() {psaDisplay()}, psaTime)
	psaTimeoutTime = time + (10 * MINUTE_IN_MS);
	psaTimeout = setInterval(function() {psaTimeout()}, psaTimeoutTime);
	clearDisplay();
}

function readGrantOrPsa()
{
	if(GRANT)
	{
		grantTimeout();
	}
	else
	{
		psaTimeout();
	}
}

function clearDisplay()
{
	document.getElementById("grant_psa").innerHTML = "";
}