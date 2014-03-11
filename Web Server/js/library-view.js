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
    var isSearching = false;
    var filteredData;
    var lastFiltered = 100;
    var filteredAlbums;
    var searchAlbums;

    //USEFULL FUNCTIONS
    updateWithFilter = function() {
        filteredAlbums = '';
        $.ajax({
            url: '../php/scripts/getFilterInfo.php',
            type: 'GET',
            data: {'GenreID' : filters['genre'], 'Recommended' : filters['recommended']},
            success: function() {}
        }).done(function(data){
            var info;
            var currentTrack = "";
            try{
                info = JSON.parse(data);
            }catch(e){
                PublishError(e);
                return;
            }
            $('#artists .selection').html('<li class="active-item item" id="all">All</li>');
            filteredAlbums += '<li class="active-item item" id="all">All</li>';
            clearTrackList();
            filteredData = tracks;
            lastFilterd = 100;

            var tracks = info['Tracks'];
            var infoAlbums = info['Albums'];
            var infoArtists = info['Artists'];

            for(var i = 0; i < tracks.length && i < 100; i++){
                var albumID = parseInt(tracks[i]['AlbumID']);
                var artistID = parseInt(tracks[i]['ArtistID']);
                var album = albums[albumID]['Name'];
                var artist = artists[artistID]['Name'];
                
                var genre1 = genres[(parseInt(tracks[i]['PrimaryGenre']))];
                var genre2 = genres[(parseInt(tracks[i]['SecondaryGenre']))];
                var songName = tracks[i]['Name'];
                var songID = tracks[i]['ID'];
                var reco = tracks[i]['Recommended'];
                var FCC = tracks[i]['FCC'];
                addSong(songID, songName, artist, album, genre1, genre2, FCC, reco);
            }
            for(var i = 0; i < infoAlbums.length; i++){
                filteredAlbums += '<li class="item item" id="' + infoAlbums[i]['AlbumID'] + '">' + albums[parseInt(infoAlbums[i]['AlbumID'])]['Name'] + '</li>'
            }
            $('#albums .selection').html(filteredAlbums);
            for(var i = 0; i < infoArtists.length; i++){
                $('#artists .selection').append('<li class="item" id="' + infoArtists[i]['ArtistID'] + '">' + artists[parseInt(infoArtists[i]['ArtistID'])]['Name'] + '</li>');
            }
            filteredData = tracks;
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
            var reco = filteredData[i]['Recommended'];
            var FCC = filteredData[i]['FCC'];
            addSong(songID, songName, artist, album, genre1, genre2, FCC, reco)
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
                var reco = tracks[i]['Recommended'];
                var FCC = tracks[i]['FCC'];
                addSong(songID, songName, artist, album, genre1, genre2, FCC, reco)
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
                        addSong(songID, songName, artist, album, genre1, genre2, FCC, reco)
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
                    var reco = songs[i]['Recommended'];
                    var FCC = songs[i]['FCC'];
                    var artist = $('#artists .active-item').text();
                    var album = songs[i]['Album'];
                    var pGenre = genres[parseInt(songs[i]['PrimaryGenre'])];
                    var sGenre = genres[parseInt(songs[i]['SecondaryGenre'])];

                    addSong(songID, songName, artist, album, pGenre, sGenre, FCC, reco);
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
                    addSong(songID, songName, artist, album, genre1, genre2, FCC, reco);
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
                    var reco = songs[i]['Recommended'];
                    var FCC = songs[i]['FCC'];
                    var pGenre = genres[parseInt(songs[i]['PrimaryGenre'])];
                    var sGenre = genres[parseInt(songs[i]['SecondaryGenre'])];
                    addSong(songID, songName, artist, album, pGenre, sGenre, FCC, reco);
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
            $("#primary-genres-allowed").append('<option value="' + i + '">' + genres[i] + '</option>')
            $("#secondary-genres-allowed").append('<option value="' + i + '">' + genres[i] + '</option>')
	   }
    }
    
	//Error Publisher
	PublishError = function(e){
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
	searchText = function(text){
		$.ajax({
			type: "GET",
			data: {"TrackLike": text},
			url: "../php/scripts/getTrackLikeInfo.php"
		}).done(function(data){
			var info;
			try{
                info = JSON.parse(data);
			}catch(e){
				PublishError(e);
				return;
			}
            clearTrackList();
			var songs = info['Tracks']
			var arts = info['Artists'];
			var albs = info['Albums'];
			for(var i = 0; i < songs.length; i++){
				var songID = songs[i]['TrackID'];
				var name = songs[i]['TrackName'];
				var artist = artists[parseInt(songs[i]['Artist'])]['Name'];
				var album = albums[parseInt(songs[i]['Album'])]['Name'];
				var FCC = songs[i]['FCC'];
				var reco = songs[i]['Recommended'];
                var pGenre = genres[parseInt(songs[i]['PrimaryGenreID'])]
                var sGenre = genres[parseInt(songs[i]['SecondaryGenreID'])];
                addSong(songID, name, artist, album, pGenre, sGenre, FCC, reco);
			}
            $('#artists .selection').html('<li class="active-item item" id="all">All</li>');
            for(var i = 0; i < arts.length; i++){
                $('#artists .selection').append('<li class="item" id="'+arts[i]['ArtistID']+'">'+ artists[parseInt(arts[i]['ArtistID'])]['Name'] +'</li>'); 
            }
            searchAlbums = '<li class="active-item item" id="all">All</li>';
            for(var i = 0; i < albs.length; i++){
                searchAlbums += '<li class="item item" id="' + albs[i]['AlbumID'] + '">' + albums[parseInt(albs[i]['AlbumID'])]['Name'] + '</li>'
            }
            $('#albums .selection').html(searchAlbums);
		});
	}
    addSong = function(songID, songName, artist, album, pGenre, sGenre, FCC , reco){
        $('.track .tracks').append('<li class="item ' + songID + '"><img src="../resources/add.png" class="image-responsive add-playlist pl-button">'+ songName +'</li>');   
        $('.artist .tracks').append('<li class="item '+ songID +'">'+ artist +'</li>');
        $('.album .tracks').append('<li class="item '+ songID +'">'+ album +'</li>'); 
        $('.primary-genre .tracks').append('<li class="item '+ songID +'">'+ pGenre +'</li>');
        $('.secondary-genre .tracks').append('<li class="item '+ songID +'">'+ sGenre +'</li>');   
        if(reco == 1){
            $('.' + songID).addClass('reco');
        }
        if(FCC == 1){
            $('.' + songID).addClass('FCC');
        }
    }
    savePlaylist = function(idCSL){
        console.log('saving playlist not yet implemented');
    }
	
    //Event Handlers
	$('#search-text').keyup(function(){
		var text = $(this).val();
		if(text.length > 1){
            isSearching = true;
			searchText(text);	
		}else{
            clearTrackList();
            initialize();
            isSearching = false
        }
	});
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
            clearTrackList();
            if(isFiltered){
                lastFiltered = 0;
                loadFilteredChunk();
                $('#albums .selection').html(filteredAlbums);
                return;
            }
            if(isSearching){
                searchText($('#search-text').val());
                return;
            }
            resetAlbums();
            lastTrack = '';
            clearTrackList();
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
                if(isFiltered){
                    lastFiltered = 0;
                    clearTrackList();
                    loadFilteredChunk();
                    $('#albums .selection').html(filteredAlbums);
                    return;
                }
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
            if(isSearching){
                return;
            }
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
        if(updated){
            if(isFiltered){
                //Filtering
                updateWithFilter();
            }else{
                //No filtering being applied
                initialize();
            }
            $(".track-view").scrollTop(0);
        }
    });
    $(document).on('click', '.add-playlist', function(){
        var songID = $(this).parent().attr('class').match(/\d+/);
        var name = $(this).parent().text();
        $('.playlist').append('<li class="playlist-song ' + songID + '"><img class="pl-button delete-playlist" src="../resources/delete.png">' + name + '</li>');
    })
    $(document).on('click', '.delete-playlist', function(){
        $(this).parent().remove();
    })
    $('.catagory').on('click',function(){
        $('#search-catagory').html($(this).text() + '<span class="caret"></span>');
    });
    $('#save-playlist').on('click', function(){
        var idArray = new Array();
        $(".playlist-song").each(function(i){
            idArray[i] = $(this).attr('class').match(/\d+/);
        });
        savePlaylist(idArray.join(','));
    });
    //ON PAGE LOAD
    fillGenres();
    initialize();
    $('.filter-view').hide();
    $('.playlist-view').hide(); 
    $('.song-error').hide();
    $('#content').css('height', '120%');
})
