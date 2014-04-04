$('document').ready(function(){

	var startOnAirSession = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/startOnAirSession.php"
        });
    }
    var testOnAir = function(){
        $.ajax({
            url: '../php/scripts/isOnAir.php',
            type: 'GET'
        }).done(function(data){
            var temp;
            try{
                temp = $.parseJSON(data)['IsOnAir'];
                isOnAir = temp;
                if(!isOnAir){
                    $('.on-air-display').hide();
                    showErrorOnHome("Validation Error", "Another user has logged on and you have been kicked off");
                    return;
                }
            }catch(e){
                return;
            }
        });
    }
    var getGrants = function(){
        $.ajax({
            type: "GET",
            data: {'Count': 25},
            url: "../php/scripts/getGrants.php"
        }).done(function(data){
            var grants;
            try{
                grants = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('.grants').html('');
            for(var i = 0; i < grants.length; i++){
                var grantHTML = '<div class="panel panel-default"><div class="panel-heading"><h4 class="panel-title">'
                grantHTML += '<a data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '" class=' + grants[i]['GrantID'] + '>';
                grantHTML += grants[i]['GrantName'] + '</a></h4></div>';
                grantHTML += '<div id="collapse' + i + '" class="panel-collapse collapse"><div class="panel-body">';
                grantHTML += grants[i]['Message'];
                grantHTML += '<button style="float: right;" type="button" class="btn btn-primary custom-song-button btn-sm" data-toggle="modal" data-target="#custom-song-modal">Mark Read</button></div></div></div>'
                $('.grants').append(grantHTML);
            }
        });
    }
    var getPSAs = function(){
        $.ajax({
            type: "GET",
            data: {'Count': 25},
            url: "../php/scripts/getPSA.php"
        }).done(function(data){
            var grants;
            try{
                grants = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('.grants').html('');
            for(var i = 0; i < grants.length; i++){
                var grantHTML = '<div class="panel panel-default"><div class="panel-heading"><h4 class="panel-title">'
                grantHTML += '<a data-toggle="collapse" data-parent="#accordion" href="#collapse' + i + '" class=' + grants[i]['ID'] + '>';
                grantHTML += grants[i]['Name'] + '</a></h4></div>';
                grantHTML += '<div id="collapse' + i + '" class="panel-collapse collapse"><div class="panel-body">';
                grantHTML += grants[i]['Message'];
                grantHTML += '<button style="float: right;" type="button" class="btn btn-primary custom-song-button btn-sm" data-toggle="modal" data-target="#custom-song-modal">Mark Read</button></div></div></div>'
                $('.grants').append(grantHTML);
            }
        });
    }

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
            $('.recently-played').html('');
            for(var i = 0; i < tracks.length; i++){
                $('.recently-played').append('<li class="list-group-item">' + tracks[i]['TrackName'] + ' - ' + tracks[i]['Artist'] +'</li>')
            }
        });
    }
    var getMostPopular = function(){
        var d = new Date();
        d.setDate(d.getDate() - 7);
        var strDate = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate();
        $.ajax({
            type: "GET",
            url: "../php/scripts/getMostPopular.php",
            data: {"StartDate": strDate}
        }).done(function(data){
            var tracks;
            try{
                tracks = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('.recently-played').html('');
            for(var i = 0; i < tracks.length; i++){
                $('.recently-played').append('<li class="list-group-item">' + tracks[i]['TrackName'] + ' - ' + tracks[i]['Artist'] +'</li>')
            }
        });
    }

    var getAllPlaylists = function(){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getPlaylistIDByUser.php"
        }).done(function(data){
            var lists;
            try{
                lists = JSON.parse(data);
            }catch(e){
                console.log(data);
                return;
            }
            $('#all-playlists').html('');
            for(var i = 0; i < lists.length; i++){
                $('#all-playlists').append('<li class="list-group-item"><span class="playlist-name">' + lists[i]['PlaylistName'] + '</span>' +
                                            '<button style="float: right;" type="button" class="btn btn-xs btn-primary" id="load-playlist"' + 
                                            'value="' + lists[i]['PlaylistID'] + '">Load</button></li>');
            }
        });
    }
    var loadPlaylist = function(playlistID){
        $.ajax({
            type: "GET",
            url: "../php/scripts/getPlaylistByID.php",
            data: {"PlaylistID" : playlistID}
        }).done(function(data){
            var tracks;
            try{
                tracks = JSON.parse(data);
            }catch(e){
                PublishError(e);
                return;
            }
            $('.songs').html('');
            onAirSongs = new Array();
            for(var i = 0; i < tracks.length; i++){
                var songID = tracks[i]['TrackID'];
                var songName = tracks[i]['TrackName'];
                var artistName = tracks[i]['Artist']['ArtistName'];
                var albumName = tracks[i]['Album']['AlbumName'];
                var pGenre = genres[parseInt(tracks[i]['PrimaryGenreID'])];
                var sGenre = genres[parseInt(tracks[i]['SecondaryGenreID'])];
                var reco = tracks[i]['Recommended'];
                var FCC = tracks[i]['FCC'];
                var tempTrack = new Track(songName, songID, reco, FCC, artistName, albumName, pGenre, sGenre);
                var songHTML = '<tr class="' + songID + '">';
                songHTML += '<td>' + songName + '</td>';
                songHTML += '<td>' + artistName + '</td>';
                songHTML += '<td>' + albumName + '</td>';
                songHTML += '<td>' + pGenre + '</td>';
                songHTML += '<td>' + sGenre + '</td>';
                songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + onAirSongs.length + '">Mark Played</button></td>';
                songHTML += '</td>';
                $('.songs').append(songHTML);
                onAirSongs.push(tempTrack);
            }
            $('#load-modal').modal('hide');
        });
    }

    var markPlayedTrack = function(trackID, songIndex){
        $.ajax({
            type: "GET",
            url: "../php/scripts/playTrackByID.php",
            data: {"TrackID" : trackID}
        }).done(function(data){
            var json;
            try{
                json = JSON.parse(data);
                if(json['error'] != undefined){
                    isOnAir = false;
                    showErrorOnHome(json['error'], json['errorMessage']);
                    $('.on-air-display').hide();
                    return;
                }
                var playID = json['PlayID'];
                onAirSongs[songIndex]['PlayID'] = playID;
                getRecentlyPlayed();
            }catch(e){
                PublishError(e);
                return;
            }
        });
    }
    var loadPage = function(){
        getRecentlyPlayed();
        getGrants();
        for(var i = 0; i < onAirSongs.length; i++){
            var songID = onAirSongs[i]['ID'];
            var songName = onAirSongs[i]['Name'];
            var artistName = onAirSongs[i]['Artist'];
            var albumName = onAirSongs[i]['Album'];
            var pGenre = onAirSongs[i]['PrimaryGenre'];
            var sGenre = onAirSongs[i]['SecondaryGenre'];
            var reco = onAirSongs[i]['reco'];
            var FCC = onAirSongs[i]['FCC'];
            var songHTML;
            if(onAirSongs[i]['PlayID'] != 0){
                songHTML = '<tr class="success ' + songID + '">';
            }else{
                songHTML = '<tr class="' + songID + '">';
            }
            songHTML += '<td>' + songName + '</td>';
            songHTML += '<td>' + artistName + '</td>';
            songHTML += '<td>' + albumName + '</td>';
            songHTML += '<td>' + pGenre + '</td>';
            songHTML += '<td>' + sGenre + '</td>';
            if(onAirSongs[i]['PlayID'] != 0){
                songHTML += '<td><button type="button" class="btn btn-danger btn-sm" id="update-played" value="' + i + '" data-toggle="modal" data-target="#custom-song-modal">Update</button></td>';
            }else{
                songHTML += '<td><button type="button" class="btn btn-primary btn-sm" id="mark-played" value="' + i + '">Mark Played</button></td>';
            }
            songHTML += '</td>';
            $('.songs').append(songHTML);
        }
    }

    $('.load-playlist-button').on('click', function(){
        getAllPlaylists();
    });
    $(document).on('click', '#load-playlist', function(){
        var playlistID = $(this).val();
        var playlistName = $(this).parent().find('.playlist-name').text();
        $('#playlist-name').val(playlistName);
        loadPlaylist(playlistID);
    });
    $(document).on('click', '#mark-played', function(){
        var songID = $(this).parent().parent().attr('class');
        var songIndex = parseInt($(this).val());
        $(this).parent().parent().addClass('success');
        $(this).text('Update');
        $(this).removeClass('btn-primary');
        $(this).addClass('btn-danger');
        $(this).attr('id', 'update-played');
        $(this).attr("data-toggle", "modal");
        $(this).attr("data-target", "#custom-song-modal");
        markPlayedTrack(songID, songIndex);
    });

    $(document).on('click', '#update-played', function(){
        testOnAir();
        $('.custom-title').html("Update Song");
        $('#onair').html('Update');
        getTrackDataForUpdate($(this).parent().parent().attr('class').match(/\d+/), $(this).val());
    });
    $('#onair').on('click', function(){
        setTimeout(function(){getRecentlyPlayed();}, 500);
    });
    $(".go-onair").on('click', function(){
        isOnAir = true;
        $(".on-air-display").show();
        startOnAirSession();
        loadPage();
        $(".onair-warning").hide();
        $(".main-view").show();
    });
    $(".go-away").on('click', function(){
        changeActive('home');
        $.ajax({
            url : 'home.html',
            type : 'POST',
            success : function() {
            }
        }).done(function(html) {
            $("#content").html(html);
            $("#content").css("height", "initial");
        });
    });
    $(".grant-tab").on('click', function(){
        $(".grant-psa-nav .active").removeClass("active");
        $(this).addClass('active');
        getGrants();
    });
    $(".psa-tab").on('click', function(){
        $(".grant-psa-nav .active").removeClass("active");
        $(this).addClass('active');
        getPSAs();
    });
    $(".recent").on('click', function(){
        $(".plays-nav .active").removeClass("active");
        $(this).addClass('active');
        getRecentlyPlayed();
    });
    $(".popular").on('click', function(){
        $(".plays-nav .active").removeClass("active");
        $(this).addClass('active');
        getMostPopular();
    });
	


    if(isOnAir){
        loadPage();
        $(".onair-warning").hide();
        $(".main-view").show();
    }else{
        $(".onair-warning").show();
        $(".main-view").hide();
    }
    
    $.ajax({
        url: '../php/scripts/getCurrentOnAirUser.php',
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
        var oaUserName = initial['UserName'];
        var oaUserFirstName = initial['FirstName'];
        var oaUserLastName = initial['LastName'];
        if(oaUserName != ""){
            $('#otherLoggedIn').append(oaUserFirstName + " " + oaUserLastName + " is currently logged in<br><br><i>You will be kicking them off</i>");
        }
    });
});
