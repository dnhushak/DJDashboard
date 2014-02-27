$(document).ready(function(){
	$("#jquery_jplayer_1").jPlayer({
		swfPath : "../js/",
		supplied : "mp3" 
	});
	$(document).on('dblclick', '.tracks .item', function(){
		var songID = $(this).attr('class').match(/\d+/);
		var artist = $('.artist ' + '.' + songID).text();
		var album = $('.album ' + '.' + songID).text();
		var track = $('.track ' + '.' + songID).text();
		$.ajax({
			url: '../php/scripts/getTrackPlayURL.php',
            type: 'GET',
            data: {'Artist' : artist, 'Album': album, 'Track': track},
            success: function(){}
		}).done(function(data){
			console.log(data);
			try{
				var error = $.parseJSON(data);
				alert(error['error']);
			}catch(e){
				$("#jquery_jplayer_1").jPlayer("setMedia", {mp3: data});
				$("#jquery_jplayer_1").jPlayer("play");
				$("#song-title").text(track + ' - ' + artist);
			}
		});
	});
});