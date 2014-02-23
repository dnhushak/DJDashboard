/**
 *  @requires Artist.js
 *  @requires Album.js
 *  @requires Track.js
 *  @requires initialLoad.js
 */

$(document).ready(function() {


    //Global variables
    var mainViewWidth = 98;
    var expansionOffset = 14;
    var filtersExpanded = false;
    var playlistExpanded = false;
    var initialTrackHTML = '';
    var lastTrack = '';
    var firstLastTrack = '';
    var keepScrolling = true;
    var filters = new Array();

    //USEFULL FUNCTION
    loadTrackChunk = function(lastTrack){
        if((lastTrack == "" || lastTrack == undefined || lastTrack == null) && initialTrackHTML != ""){
            setLastTrack(firstLastTrack);
            clearTrackList();
            $('.track-view').html(initialTrackHTML);
            return;
        }
        $.ajax({
            url: '../php/scripts/getTracksByChunk.php',
            type: 'GET',
            data: {'LastTrack' : lastTrack},
            success: function() {}
        }).done(function(data){
            var tracks;
            var currentTrack = "";
            try{
                tracks = JSON.parse(data);
            }catch(e){
                console.log('Error getting track chunk lastTrack=' + lastTrack);
				PublishError(e);
                return;
            }
            for(var i = 0; i < tracks.length; i++){
                var album = tracks[i]['Album'];
                var artist = tracks[i]['Artist'];
                var genre1 = genres[(parseInt(tracks[i]['PrimaryGenre']))];
                var genre2 = genres[(parseInt(tracks[i]['SecondaryGenre']))];
                var songName = tracks[i]['Name'];
                var songID = tracks[i]['ID'];
                var reco = tracks[i]['reco'];
                var FCC = tracks[i]['FCC'];
                $('.track .tracks').append('<li class="item ' + songID + '">'+ songName +'</li>');   
                $('.artist .tracks').append('<li class="item ' + songID + '">'+ artist +'</li>');
                $('.album .tracks').append('<li class="item ' + songID + '">'+ album +'</li>'); 
                $('.primary-genre .tracks').append('<li class="item '+ songID +'">'+ genre1 +'</li>');
                $('.secondary-genre .tracks').append('<li class="item '+ songID +'">'+ genre2 +'</li>');
                if(reco == 1){
                    $('.' + songID).addClass('reco');
                }
                if(FCC == 1){
                    $('.' + songID).addClass('FCC');
                }
                if(lastTrack == "" || lastTrack == undefined || lastTrack == null){
                    initialTrackHTML = $('.track-view').html();
                }
                currentTrack = songName;
            }
            setLastTrack(currentTrack);
            keepScrolling = true;
        })
    }
    setLastTrack = function(str){
        if(lastTrack == ''){
            firstLastTrack = str;
        }
        lastTrack = str;
    }
    initialize = function(){
        $('#albums .selection').html(albumsHTML)
        $('#artists .selection').html(artistsHTML);
        $('.filter-view').hide();
        $('.playlist-view').hide();
        loadTrackChunk();
    }
	formatClass = function(str){
		str = str.replace(/ /g, '.');
		return '.' + str;
	}
    clearTrackList = function(){
        $('.track .tracks').html('');   
        $('.artist .tracks').html('');
        $('.album .tracks').html(''); 
        $('.primary-genre .tracks').html('');
        $('.secondary-genre .tracks').html(''); 
    }
    getAlbumsByArtist = function(id){
        $.ajax({
            url: '../php/scripts/getAlbumsByArtist.php',
            type: 'GET',
            data: {'ArtistID': id},
            success: function() {}
        }).done(function(data){
            var albums;
            try{
                albums = JSON.parse(data);
            }catch(e){
                console.log('Error getting albums by artist');
                console.log(data);
				PublishError(e);
                return;
            }
            if(albums['error'] == true){

            }else{
                $('#albums .selection').html('<li class="active-item item" id="all">All</li>');
                for (var i = 0; i < albums.length; i++){
                    $('#albums .selection').append('<li class="item" id="'+albums[i]['ID']+'">'+albums[i]['Name']+'</li>')
                }
            }
        })
    }
    getTracksByArtist = function(id){
        if(artists[id] != undefined){
            if(artists[id]['albums'].length != 0){
                //Item was cached so do not hit database
                artistAlbums = artists[id]['albums'];
                clearTrackList();
                var artist = artists[id]['Name'];
                for(var i = 0; i < artistAlbums.length; i++){
                    var album = artistAlbums[i]['Name'];
                    for(var j = 0; j < artistAlbums[i]['tracks'].length; j++){
                        var genre1 = artistAlbums[i]['tracks'][j]['PrimaryGenre'];
                        var genre2 = artistAlbums[i]['tracks'][j]['SecondaryGenre'];
                        var songName = artistAlbums[i]['tracks'][j]['Name'];
                        var songID = artistAlbums[i]['tracks'][j]['ID'];
                        var reco = artistAlbums[i]['tracks'][j]['reco'];
                        var FCC = artistAlbums[i]['tracks'][j]['FCC'];
                        $('.track .tracks').append('<li class="item ' + songID + '">'+ songName +'</li>');   
                        $('.artist .tracks').append('<li class="item ' + songID + '">'+ artist +'</li>');
                        $('.album .tracks').append('<li class="item ' + songID + '">'+ album +'</li>'); 
                        $('.primary-genre .tracks').append('<li class="item '+ songID +'">'+ genre1 +'</li>');
                        $('.secondary-genre .tracks').append('<li class="item '+ songID +'">'+ genre2 +'</li>');
                        if(reco){
                            $('.' + songID).addClass('reco');
                        }
                        if(FCC){
                            $('.' + songID).addClass('FCC');
                        }
                    }
                }
                return;
            }
        }
        $.ajax({
            url: '../php/scripts/getTracksByArtist.php',
            type: 'GET',
            data: {'ArtistID': id},
            success: function() {}
        }).done(function(data){
            var songs;
            try{
                songs = JSON.parse(data);
            }catch(e){
                console.log('Error getting tacks by artist');
                console.log(data);
				PublishError(e);
                return;
            }
            if(songs['error'] == true){

            }else{
                clearTrackList();
                for (var i = 0; i < songs.length; i++){
                    var albumID = parseInt(songs[i]['AlbumID']);
                    artists[id].addAlbum(albums[albumID]);

                    var songID = songs[i]['ID'];
                    var songName = songs[i]['Name'];
                    var reco = false;
                    var FCC = false;
                    var artist = $('#artists .active-item').text();
                    var album = songs[i]['Album'];
                    var pGenre = genres[parseInt(songs[i]['PrimaryGenre'])];
                    var sGenre = genres[parseInt(songs[i]['SecondaryGenre'])];

                    $('.track .tracks').append('<li class="item ' + songID + '">'+ songName +'</li>');   
                    $('.artist .tracks').append('<li class="item ' + songID + '">'+ artist +'</li>');
                    $('.album .tracks').append('<li class="item ' + songID + '">'+ album +'</li>'); 
                    $('.primary-genre .tracks').append('<li class="item '+ songID +'">'+ pGenre +'</li>');
                    $('.secondary-genre .tracks').append('<li class="item '+ songID +'">'+ sGenre +'</li>');
                    if(songs[i]['Recommended'] == 1){
                        reco = true;

                        $('.' + songID).addClass('reco');
                    }
                    if(songs[i]['FCC'] == 1){
                        FCC = true;
                        $( '.' + songID).addClass('FCC');
                    }
                    albums[albumID].addTrack(new Track(songName, songID, reco, FCC, artist, album, pGenre, sGenre));
                }
            }
        })
    }
    getTracksByAlbum = function(id) {
        if(albums[id] != undefined){
            if(albums[id]['tracks'].length != 0){
                var trackList = albums[id]['tracks'];
                clearTrackList();
                for(var i = 0; i < trackList.length; i++){
                    var album = trackList[i]['Album'];
                    var artist = trackList[i]['Artist'];
                    var genre1 = trackList[i]['PrimaryGenre'];
                    var genre2 = trackList[i]['SecondaryGenre'];
                    var songName = trackList[i]['Name'];
                    var songID = trackList[i]['ID'];
                    var reco = trackList[i]['reco'];
                    var FCC = trackList[i]['FCC'];
                    $('.track .tracks').append('<li class="item ' + songID + '">'+ songName +'</li>');   
                    $('.artist .tracks').append('<li class="item ' + songID + '">'+ artist +'</li>');
                    $('.album .tracks').append('<li class="item ' + songID + '">'+ album +'</li>'); 
                    $('.primary-genre .tracks').append('<li class="item '+ songID +'">'+ genre1 +'</li>');
                    $('.secondary-genre .tracks').append('<li class="item '+ songID +'">'+ genre2 +'</li>');
                    if(reco){
                        $('.' + songID).addClass('reco');
                    }
                    if(FCC){
                        $('.' + songID).addClass('FCC');
                    }
                }
                return;
            }
        }
        $.ajax({
            url: '../php/scripts/getTracksByAlbum.php',
            type: 'GET',
            data: {'AlbumID': id},
            success: function() {}
        }).done(function(data){
            var songs;
            try{
                songs = JSON.parse(data);
            }catch(e){
                console.log("Error getting tacks by album");
                console.log(data);
				PublishError(e);
                return;
            }
            if(songs['error'] == true){

            }else{
                clearTrackList();

                for (var i = 0; i < songs.length; i++){
                    var songName = songs[i]['Name'];
                    var songID = songs[i]['ID'];
                    var artist = songs[i]['Artist'];
                    var album = $('#albums .active-item').text();
                    var reco = false;
                    var FCC = false;
                    var pGenre = genres[parseInt(songs[i]['PrimaryGenre'])];
                    var sGenre = genres[parseInt(songs[i]['SecondaryGenre'])];
                    $('.track .tracks').append('<li class="item '+ songID +'">'+ songName +'</li>');   
                    $('.artist .tracks').append('<li class="item '+ songID +'">'+ artist +'</li>');
                    $('.album .tracks').append('<li class="item '+ songID +'">'+ album +'</li>'); 
                    $('.primary-genre .tracks').append('<li class="item '+ songID +'">'+ pGenre +'</li>');
                    $('.secondary-genre .tracks').append('<li class="item '+ songID +'">'+ sGenre +'</li>');  
                    if(songs[i]['Recommended'] == 1){
                        reco = true;
                        $('.' + songs[i]['ID']).addClass('reco');
                    }
                    if(songs[i]['FCC'] == 1){
                        FCC = true;
                        $('.' + songs[i]['ID']).addClass('FCC');
                    }
                    albums[id].addTrack(new Track(songName, songID, reco, FCC, artist, album, pGenre, sGenre));
                }
            }
        })
    }
    getAllArtists = function() {
        $.ajax({
            url: '../php/scripts/getAllArtists.php',
            type: 'GET',
            success: function(){}
        }).done(function(data){
            var artists;
            try{
                artists = JSON.parse(data);

            }catch(e){
                console.log('Error loading all artists');
                console.log(data);
				PublishError(e);
                return;
            }
            $('#artists .selection').html('<li class="active-item item" id="all">All</li>');
            for(var i = 0; i < artists.length; i++){
                $('#artists .selection').append('<li class="item" id="'+artists[i]['ID']+'">'+artists[i]['Name']+'</li>'); 
            }
        });
    }
    resetAlbums = function(){
        $('#albums .selection').html(albumsHTML);
    }
    fillGenres = function(){
        for(var i = 1; i < genres.length; i++){
            $("#filter-form").append('<div class="checkbox"><label><input type="checkbox" name="' + genres[i] + '">' + genres[i] + '</label></div>')
        }
    }
    
	//Error Publisher
	PublishError = function(e){
		console.log("Logging exception to database");
		var stack = e.stack;
		if((e.stack == "" || e.stack == undefined))
		{
			stack = "No stack available";
		}
		
		var ajaxCall = $.ajax({
			type: "GET",
			async:true,
			url: "../php/scripts/logException.php",
			data: {'Message' : e.message, 'StackTrace' : stack, 'userID' : '0'},
        });
	
	}
	
	
    //Event Handlers
	$(document).on('click', '.select-column', function(){
		$('.active-column').removeClass('active-column');
		$(this).addClass('active-column');
	});
	$(document).on('click', '.selection .item', function(){
		$(this).siblings('.active-item').removeClass('active-item');
		$(this).addClass('active-item');
	});
	$(document).on('click', '.tracks .item', function(){
		$('.tracks .active-item').removeClass('active-item');
		$(formatClass($(this).attr('class'))).addClass('active-item');
	});
    $(document).on('click', '#artists .item', function(){
        if($(this).attr('id') == 'all'){
            resetAlbums();
            lastTrack = '';
            loadTrackChunk(lastTrack);
            keepScrolling = true;
        }else{
            getAlbumsByArtist($(this).attr('id'));
            getTracksByArtist($(this).attr('id'));
            keepScrolling = false;
        }
    })
    $(document).on('click', '#albums .item', function(){
        if($(this).attr('id') == 'all'){
            if($('#artists .active-item').attr('id') == 'all'){
                resetAlbums();
                lastTrack = '';
                loadTrackChunk(lastTrack);
                keepScrolling = true;
            }else{
                getTracksByArtist($('#artists .active-item').attr('id'));
                keepScrolling = false;
            }
        }else{
            keepScrolling = false;
            getTracksByAlbum($(this).attr('id'));
        }
    })
    $("#filters").on('click', function(){
        if(!filtersExpanded){
            $('.filter-view').show();
            mainViewWidth -= expansionOffset;
            $(".main-view").css('width', mainViewWidth.toString() + '%');
            $('.filter-view').css('width', '14%');
            $('.filter-view').css('height', '100%');
            filtersExpanded = true;
        }else{
            $('.filter-view').hide();
            mainViewWidth += expansionOffset;
            $(".main-view").css('width', mainViewWidth.toString() + '%');
            $('.filter-view').css('width', '0px');
            $('.filter-view').css('height', '0px');
            filtersExpanded = false;
        }
    });
    $("#current-playlist").on('click', function(){
        if(!playlistExpanded){
            $('.playlist-view').show();
            mainViewWidth -= expansionOffset;
            $(".main-view").css('width', mainViewWidth.toString() + '%');
            $('.playlist-view').css('width', '14%');
            $('.playlist-view').css('height', '100%');
            playlistExpanded = true;
        }else{
            $('.playlist-view').hide();
            mainViewWidth += expansionOffset;
            $(".main-view").css('width', mainViewWidth.toString() + '%');
            $('.playlist-view').css('width', '0px');
            $('.playlist-view').css('height', '0px');
            playlistExpanded = false;
        }
    });
    $(".track-view").scroll(function(){
        if(keepScrolling && $(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight - 5){
            keepScrolling = false;
            loadTrackChunk(lastTrack);
        }
    });
    $("#filter-form").on('click', function(){
        $('input:checked').each(function() {
            //selected.push($(this).attr('name'));
        });
    });
    //ON PAGE LOAD
    fillGenres();
    initialize();
})