/**
 * 
 */

$('document').ready(function(){
	$.ajax({
        url: '../php/scripts/getDJs.php',
        type: 'GET',
        success: function(){}
    }).done(function(data){
        var initial;
        try{
            initial = JSON.parse(data);
        }catch(e){
            console.log('Error loading initial info');
            console.log(data);
            return;
        }
        var djHTML = "";
        //Limit to 25 lines
        var limit = initial.length;
        if(limit > 25) limit = 25;
        for(var i = 0; i < limit; i++){
           djHTML += '<li id="'+initial[i]['UserID']+'">'+initial[i]['FirstName']+' '+initial[i]['LastName']+'</li>';
        }
        $('.djList').html(djHTML);
    });
	
	
	var getRecentlyPlayed = function(){
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

