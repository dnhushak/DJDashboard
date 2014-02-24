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
    var filters = { recommended: 0, genre: 'All' };
    var isFiltered = false;
    var filteredData;
    var lastFiltered = 100;

    //USEFULL FUNCTION
    updateWithFilter = function() {
        $.ajax({
            url: '../php/scripts/getTracksByGenre.php',
            type: 'GET',
            data: {'GenreID' : filters['genre']},
            success: function() {}
        }).done(function(data){
            var tracks;
            var currentTrack = "";
            try{
                tracks = JSON.parse(data);
            }catch(e){
                console.log('Error getting tracks by genre. GenreID=' + filters['genre']);
                PublishError(e);
                return;
            }
            $('#artists .selection').html('<li class="active-item item" id="all">All</li>');
            $('#albums .selection').html('<li class="active-item item" id="all">All</li>');
            clearTrackList();
            filteredData = tracks;
            lastFilterd = 100;
            var genreArtists = {};
            var genreAlbums = {};
            for(var i = 0; i < tracks.length && i < 100; i++){
                var albumID = parseInt(tracks[i]['AlbumID']);
                var artistID = parseInt(tracks[i]['ArtistID']);
                var album = albums[albumID]['Name'];
                var artist = artists[artistID]['Name'];

                genreAlbums[album] = albumID;
                genreArtists[artist] = artistID;

                // $('#artists .selection').append('<li class="item" id="' + artistID + '">' + artist + '</li>');
                // $('#albums .selection').append('<li class="item item" id="' + albumID + '">' + album + '</li>');
                
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
            }
            uniqueArtists = new Array()
            for(var art in genreArtists){
                uniqueArtists.push([art, genreArtists[art]])
            }
            uniqueAlbums = new Array()
            for(var alb in genreAlbums){
                uniqueAlbums.push([alb, genreAlbums[alb]])
            }
            uniqueArtists.sort(function(a, b){
                if (a[0] < b[0]){
                    return -1;
                }
                else if (a[0] > b[0]){
                    return 1;
                }else{
                    return 0;
                }
            })
            uniqueAlbums.sort(function(a, b){
                if (a[0] < b[0]){
                    return -1;
                }
                else if (a[0] > b[0]){
                    return 1;
                }else{
                    return 0;
                }
            })
            for(var i = 0; i < uniqueAlbums.length; i++){
                $('#albums .selection').append('<li class="item item" id="' + uniqueAlbums[i][1] + '">' + uniqueAlbums[i][0] + '</li>');
            }
            for(var i = 0; i < uniqueArtists.length; i++){
                $('#artists .selection').append('<li class="item" id="' + uniqueArtists[i][1] + '">' + uniqueArtists[i][0] + '</li>');
            }
        });
    }
    loadFilteredChunk = function(){
        var max = lastFiltered + 100;
        for(var i = lastFiltered; i < filteredData.length && i < max; i++){
            var album = albums[parseInt(filteredData[i]['AlbumID'])]['Name'];
            var artist = artists[parseInt(filteredData[i]['ArtistID'])]['Name'];
            var genre1 = genres[(parseInt(filteredData[i]['PrimaryGenre']))];
            var genre2 = genres[(parseInt(filteredData[i]['SecondaryGenre']))];
            var songName = filteredData[i]['Name'];
            var songID = filteredData[i]['ID'];
            var reco = filteredData[i]['reco'];
            var FCC = filteredData[i]['FCC'];
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
        }
        lastFiltered = max;
    }

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
        lastTrack = '';
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
            $("#filter-form").append('<div class="radio"><label><input type="radio" name="genreFilters" value="' + i + '">' + genres[i] + '</label></div>')
        }
    }
    
	//Error Publisher
	PublishError = function(e){
		console.log("Logging exception to database");
		var stack = e.stack;
		if((e.stack == "" || e.stack == undefined)){
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
            if(isFiltered){
                loadFilteredChunk();
                return;
            }
            keepScrolling = false;
            loadTrackChunk(lastTrack);
        }
    });
    $("#filter-form").on('click', function(){
        var updated = false;
        var filterGenre = $('input[name=genreFilters]:checked', '#filter-form').val();
        if(filters['genre'] != filterGenre){
            filters['genre'] = filterGenre;
            updated = true;
        }
        if($("input:checkbox").is(':checked')){
            if(filters['recommended'] == 0){
                filters['recommended'] = 1;
                updated = true;
            }
        }else{
            if(filters['recommended'] == 1){
                filters['recommended'] = 0;
                updated = true;
            }
        }
        if(filters['genre'] == 'All' && filters['recommended'] == 0){
            isFiltered = false;
        }else{
            isFiltered = true;
        }
        console.log(isFiltered);
        if(updated){
            if(filters['recommended'] == 0 && filters['genre'] != 'All'){
                //Filtering only by genre
                updateWithFilter();
            }
            else if(filters['recommended'] == 1 && filters['genre'] != 'All'){
                //Filtering by recommended and genre
            }
            else if(filters['recommended'] == 1 && filters['genre'] == 'All'){
                //Filtering by recommended only
            }else{
                //No filtering being applied
                initialize();
            }
        }
    });
    //ON PAGE LOAD
    fillGenres();
    initialize();
    $('.filter-view').hide();
    $('.playlist-view').hide(); 
})