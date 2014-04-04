/**
 * Manages the profiles
 */


$('document').ready(function(){
	
	
	var getCurrentUsersProfile = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getRecentlyPlayed.php"
        }).done(function(data){
            var tracks;
            try{
                tracks = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
          //Limit to 25 lines
            var limit = tracks.length;
            if(limit > 25) limit = 25;
            for(var i = 0; i < limit; i++){
                $('.recentList').append('<li id="'+tracks[i]['TrackID']+'">' + tracks[i]['TrackName'] + ' - ' + tracks[i]['Artist'] +'</li>')
            }
        });
    }
	
	getRecentlyPlayed();
});

