/**
 *  @requires Artist.js
 *  @requires Album.js
 */

$(document).ready(function() {


    //Global variables
    var mainViewWidth = 98;
    var expansionOffset = 14;
    var filtersExpanded = false;
    var playlistExpanded = false;
    var artists = new Array();

    $('.filter-view').hide();
    $('.playlist-view').hide();


    //USEFULL FUNCTION
	formatClass = function(str){
		str = str.replace(/ /g, '.');
		return '.' + str;
	}
    containsArtist= function(id){
        for(var i = 0; i < artists.length; i++){
            if(artists[i].id == id){
                return true;
            }
        }
        return false;
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
                return;
            }
            if(albums['error'] == true){

            }else{
                var a = new Artist($('#artists .active-item').text(), $('#artists .active-item').attr('id'));
                if(!containsArtist(a.id))
                    artists.push(a);
                $('#albums .selection').html('<li class="active-item item" id="all">All</li>');
                for (var i = 0; i < albums.length; i++){
                    $('#albums .selection').append('<li class="item" id="'+albums[i]['ID']+'">'+albums[i]['Name']+'</li>')
                }
            }
        })
    }
    getTracksByArtist = function(id){
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
                return;
            }
                
            if(songs['error'] == true){

            }else{
                clearTrackList();
                for (var i = 0; i < songs.length; i++){
                    $('.track .tracks').append('<li class="item '+songs[i]['ID']+'">'+songs[i]['Name']+'</li>');   
                    $('.artist .tracks').append('<li class="item '+songs[i]['ID']+'">'+ $('#artists .active-item').text() +'</li>');
                    $('.album .tracks').append('<li class="item '+songs[i]['ID']+'">'+ songs[i]['Album'] +'</li>'); 
                    $('.primary-genre .tracks').append('<li class="item '+songs[i]['ID']+'">'+'GENRE'+'</li>');
                    $('.secondary-genre .tracks').append('<li class="item '+songs[i]['ID']+'">'+'GENRE'+'</li>');
                }
            }
        })
    }
    getTracksByAlbum = function(id) {
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
                return;
            }
            if(songs['error'] == true){

            }else{
                clearTrackList();

                for (var i = 0; i < songs.length; i++){
                    $('.track .tracks').append('<li class="item '+songs[i]['ID']+'">'+songs[i]['Name']+'</li>');   
                    $('.artist .tracks').append('<li class="item '+songs[i]['ID']+'">'+ songs[i]['Artist'] +'</li>');
                    $('.album .tracks').append('<li class="item '+songs[i]['ID']+'">'+ $('#albums .active-item').text() +'</li>'); 
                    $('.primary-genre .tracks').append('<li class="item '+songs[i]['ID']+'">'+'GENRE'+'</li>');
                    $('.secondary-genre .tracks').append('<li class="item '+songs[i]['ID']+'">'+'GENRE'+'</li>');  
                }
            }
        })
    }
    initialize = function(){
        $.ajax({
                url: '../php/scripts/testlibrary.php',
                type: 'GET',
                success: function() {}
        }).done(function(data) {
                var songs;
                try{
                    songs = JSON.parse(data); 
                }catch(e){
                    console.log("error initializing");
                    console.log(data);
                    return;
                }
                clearTrackList();
                $('#artists .selection').html('');
                $('#albums .selection').html('');
                for (var i = 0; i < songs.length; i++) {
                    //Add artist name and album to seletion at the tom
                    $('#artists .selection').append('<li class="item" id="'+songs[i]['idartist']+'">'+songs[i]['Artist Name']+'</li>'); 
                    $('#albums .selection').append('<li class="item" id="'+songs[i]['idalbum']+'">'+songs[i]['Album Name']+'</li>');

                    //Add all track information into the track view
                    $('.track .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Name']+'</li>');   
                    $('.artist .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Artist Name']+'</li>');
                    $('.album .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Album Name']+'</li>'); 
                    $('.primary-genre .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+'GENRE'+'</li>');
                    $('.secondary-genre .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+'GENRE'+'</li>');  
                    if(songs[i]['Recommended'] == 1){
                        $('.' + songs[i]['idtrack']).addClass('reco');
                    }
                    if(songs[i]['FCC'] == 1){
                        $('.track .' + songs[i]['idtrack']).addClass('FCC');
                    }
                };
        });
    }
    
    //On Load
    initialize();
    
    //Event Handlers
	$('.select-column').on('click', function(){
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
            if($('#albums .active-item').attr('id') == 'all'){
                initialize();
            }else{
                getTracksByAlbum($('#albums .active-item').attr('id'));
            }
        }else{
            getAlbumsByArtist($(this).attr('id'));
            getTracksByArtist($(this).attr('id'));
        }
    })
    $(document).on('click', '#albums .item', function(){
        if($(this).attr('id') == 'all'){
            if($('#artists .active-item').attr('id') == 'all'){
                initialize();
            }else{
                getTracksByArtist($('#artists .active-item').attr('id'));
            }
        }else{
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
})