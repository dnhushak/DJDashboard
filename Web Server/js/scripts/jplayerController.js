$(document).ready(function(){

    var getSubsonicID = function(trackID, track, artist){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getSubsonicID.php",
            data: {'TrackID': trackID}
        }).done(function(data){
            var subID;
            try{
            	subID = $.parseJSON(data)['SubsonicID'];
            }catch(e){
            	return;
            }
            if(subID == null || subID == 'null'){
            	$(".error-message").html(track + " could not be found in the SubSonic database.<br>If it should be there or you would like it to be added please contact the music director");
		 		$("#errorModal").modal("show");
            }else{
            	var url = "http://kure-automation.stuorg.iastate.edu/rest/stream.view?u=kuredj&p=kuredj&v=1.8.0&c=KURE+DJ+Dash&f=json&id=" + subID + "&format=mp3";
            	$("#jquery_jplayer_1").jPlayer("setMedia", {mp3: url});
				$("#jquery_jplayer_1").jPlayer("play");
				$("#song-title").text(track + ' - ' + artist);
            }
        });
    }

	$("#jquery_jplayer_1").jPlayer({
		swfPath : "../js/",
		supplied : "mp3" 
	});
	$(document).on('dblclick', '.tracks .item', function(){
		var songID = parseInt($(this).attr('class').match(/\d+/));
		var artist = $('.artist ' + '.' + songID).text();
		var album = $('.album ' + '.' + songID).text();
		var track = $('.track ' + '.' + songID).text();
		getSubsonicID(songID, track, artist);
	});
	$('.jp-stop').on('click', function(){
		$("#jquery_jplayer_1").jPlayer("clearMedia");
		$("#song-title").html('');
	});
});
