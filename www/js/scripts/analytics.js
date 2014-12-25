$(document).ready(function(){

	var LoadDJs = function(){
		$.ajax({
			url : '../php/scripts/getDJs.php',
			type : 'GET',
			success : function() {
			}
		}).done(function(data) {
			var initial;
			try {
				initial = JSON.parse(data);
			} catch (e) {
				console.log('Error loading initial info');
				console.log(data);
				return;
			}
			var djHTML = "";
			// Limit to 25 lines

			for (var i = 0; i < initial.length; i++) {

				$('#user-plays').append('<option value="' + initial[i]['UserID'] + '">' + initial[i]['UserName'] + '</option>')
			}
		});
	}
	var LoadPlaysByTrack = function(startDate, endDate, userID){
		$.ajax({
			url : '../php/scripts/getPlaysByTimeSpanAndUserID.php',
			data : {'StartDate' : startDate, 'EndDate' : endDate, 'UserID' : userID},
			type : 'GET'
		}).done(function(data) {
			var plays;
			try {
				plays = JSON.parse(data);
			} catch (e) {
				console.log('Error loading initial info');
				console.log(data);
				return;
			}
			for(var i = 0; i < plays.length && i < 50; i++){
				var playsHtml = '<tr>';
				var trackName = plays[i]['TrackName'];
				var playCount = plays[i]['PlayCount'];
				playsHtml += "<td>" + trackName + "</td>";
				playsHtml += "<td>" + playCount + "</td>";
				$(".plays").append(playsHtml + '</tr>');
			}
		});
	}
	var LoadPlaysByAlbum = function(startDate, endDate, userID){
		$.ajax({
			url : '../php/scripts/getAlbumPlaysByTimeSpanAndUserID.php',
			data : {'StartDate' : startDate, 'EndDate' : endDate, 'UserID' : userID},
			type : 'GET'
		}).done(function(data) {
			var plays;
			try {
				plays = JSON.parse(data);
			} catch (e) {
				console.log('Error loading initial info');
				console.log(data);
				return;
			}
			for(var i = 0; i < plays.length && i < 50; i++){
				var playsHtml = '<tr>';
				var albumName = plays[i]['AlbumName'];
				var playCount = plays[i]['PlayCount'];
				playsHtml += "<td>" + albumName + "</td>";
				playsHtml += "<td>" + playCount + "</td>";
				$(".plays").append(playsHtml + '</tr>');
			}
		});
	}

	$('.load').on('click', function(evt){
		$(".plays").html('');
		var userID = $('#user-plays').val();
		var endDate = $('#end-date').val();
		var startDate = $('#start-date').val();
		if($('#count-by').val() == 'track'){
			$('#selected').text('Track Name');
			LoadPlaysByTrack(startDate, endDate, userID);
		}else{
			$('#selected').text('Album Name');
			LoadPlaysByAlbum(startDate, endDate, userID);
		}
		evt.stopPropagation();
		evt.preventDefault();
	})

	var now = new Date();

	var day = ("0" + now.getDate()).slice(-2);
	var month = ("0" + (now.getMonth() + 1)).slice(-2);

	var today = now.getFullYear()+"-"+(month)+"-"+(day) ;

	$('#end-date').val(today);
	$('#start-date').val(today);

	LoadDJs();
})