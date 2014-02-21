var albums = new Array();
var artists = new Array();
var genres = new Array();
var artistsHTML = '';
var albumsHTML = '';
$(document).ready(function() {

    $.ajax({
        url: '../php/scripts/getInitialInfo.php',
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
        var allArtists = initial['Artists'];
        var allAlbums = initial['Albums'];
        var allGenres = initial['Genres']
        albumsHTML += '<li class="active-item item" id="all">All</li>';
        for(var i = 0; i < allAlbums.length; i++){
            albums[parseInt(allAlbums[i]['ID'])] = new Album(allAlbums[i]['Name'], parseInt(allAlbums[i]['ID']), 'Genre1', 'Genre2');
        	albumsHTML += '<li class="item" id="'+allAlbums[i]['ID']+'">'+allAlbums[i]['Name']+'</li>';
        }
        artistsHTML += '<li class="active-item item" id="all">All</li>';
        for(var i = 0; i < allArtists.length; i++){
            artists[parseInt(allArtists[i]['ID'])] = new Artist(allArtists[i]['Name'], parseInt(allArtists[i]['ID']));
        	artistsHTML += '<li class="item" id="'+allArtists[i]['ID']+'">'+allArtists[i]['Name']+'</li>'
        }
        genres[0] = "";
        for(var i = 0; i < allGenres.length; i++){
            genres[parseInt(allGenres[i]['ID'])] = allGenres[i]['Name'];
        }
        console.log(genres);
    });
});