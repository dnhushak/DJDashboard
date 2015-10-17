var albums = new Array();
var artists = new Array();
var genres = new Array();
var onAirSongs = new Array();
var artistsHTML = '';
var albumsHTML = '';
var isOnAir = false;

$(document).ready(function() {

    showErrorOnHome = function(errorName, errorMessage){
        changeActive('home');
        $.ajax({
            url : 'home.html',
            type : 'POST',
            success : function() {
            }
        }).done(function(html) {
            $("#content").html(html);
            $("#content").css("height", "initial");
            $("#errorLabel").html(errorName);
            $(".error-message").html(errorMessage);
            $("#errorModal").modal("show");
        });

    };
//    $.ajax({
//        url: '../php/scripts/getInitialInfo.php',
//        type: 'GET',
//        success: function(){}
//    }).done(function(data){
//        var initial;
//        try{
//            initial = JSON.parse(data);
//        }catch(e){
//            console.log('Error loading initial info');
//            console.log(data);
//            return;
//        }
//        var allArtists = initial['Artists'];
//        var allAlbums = initial['Albums'];
//        var allGenres = initial['Genres'];
//        albumsHTML += '<li class="active-item item" id="all">All</li>';
//        for(var i = 0; i < allAlbums.length; i++){
//            albums[parseInt(allAlbums[i]['ID'])] = new Album(allAlbums[i]['Name'], parseInt(allAlbums[i]['ID']), allAlbums[i]['PrimaryGenre'], allAlbums[i]['SecondaryGenre']);
//        	albumsHTML += '<li class="item" id="'+allAlbums[i]['ID']+'">'+allAlbums[i]['Name']+'</li>';
//        }
//        artistsHTML += '<li class="active-item item" id="all">All</li>';
//        for(var i = 0; i < allArtists.length; i++){
//            artists[parseInt(allArtists[i]['ID'])] = new Artist(allArtists[i]['Name'], parseInt(allArtists[i]['ID']));
//        	artistsHTML += '<li class="item" id="'+allArtists[i]['ID']+'">'+allArtists[i]['Name']+'</li>';
//        }
//        genres[0] = " ";
//        for(var i = 0; i < allGenres.length; i++){
//            genres[parseInt(allGenres[i]['ID'])] = allGenres[i]['Name'];
//        }
//    });
    
    $('.on-air-display').hide();
    
//    $('#off-air-button').on('click', function(evt){
//    	$.ajax({
//            url: '../php/scripts/endOnAirSession.php',
//            type: 'GET'
//        });
//        $('.on-air-display').hide();
//        isOnAir = false;
//        changeActive('home');
//        $.ajax({
//            url : 'home.html',
//            type : 'POST',
//            success : function() {
//            }
//        }).done(function(html) {
//            $("#content").html(html);
//            $("#content").css("height", "initial");
//        });
//        evt.stopPropagation();
//        evt.preventDefault();
//    });
    
//    $.ajax({
//        url: '../php/scripts/isOnAir.php',
//        type: 'GET'
//    }).done(function(data){
//        var temp;
//        try{
//            temp = $.parseJSON(data)['IsOnAir'];
//            isOnAir = temp;
//            if(isOnAir){
//                $('.on-air-display').show();
//            }
//        }catch(e){
//            return;
//        }
//    });
});