/**
 * Manages the profiles
 */

$('document').ready(function() {

	var getCurrentUsersProfile = function() {
		$.ajax({
			type : "GET",
			url : "../php/scripts/getCurrentUserProfile.php"
		}).done(function(data) {
			var profile;
			try {
				profile = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
			var djNickName = profile['NickName'];
			var djMotto = profile['Motto'];
			var djBio = profile['Bio'];
			
			if(djNickName != ""){
				$('djTitle').append(djNickName + " <small> " + djMotto + "</small>");
			}
			
			if(djBio != ""){
				$('#bio').append(djBio);
			}

		});
	}

	var getFivePlaylists = function() {
		$.ajax({
			type : "GET",
			url : "../php/scripts/GetProfilePlaylists.php"
		}).done(function(data) {
			var profile;
			try {
				playlists = JSON.parse(data);
			} catch (e) {
				console.log(data);
				return;
			}
			console.log('getfive');
			var panelHTML = '';
			for ( var i = 0; i < playlists.length; i++) {
				//Create playlist drop down
				var playlistName = playlists[i]['PlaylistName'];
				var playlistID = playlists[i]['PlaylistID'];
				console.log(playlists);
				console.log('Playlist Name: ' + playlistName);
				console.log('Playlist ID: ' + playlistID);
				panelHTML = panelHTML + '<div class="panel panel-default"><div class="panel-heading"><h4 class="panel-title"><a data-toggle="collapse" href="#playlist' + playlistID + '">' + playlistName + '</a></h4></div><div id="playlist' + playlistID + '" class="panel-collapse collapse"></div></div>';
				panelHTML = panelHTML + '<div class="panel-body"><ul>';
				for ( var j = 0; j < playlists[i].length; j++) {
					//Create songs in that drop down
					var trackName = playlists[i][j]['TrackName'];
					var artistName = playlists[i][j]['Artist']['ArtistName'];
					panelHTML = panelHTML + '<li><a href="#">' + trackName + ' - ' + artistName + '</a></li>';
				}
				panelHTML = panelHTML + '</ul></div></div>'
			}
			console.log('completegetfive');
			$('#spinlist-dropdown').append(panelHTML);
		});

		/***********************************************************************
		 * <div class="panel-body">
		 * <ul>
		 * <li><a href="#">Song One</a></li>
		 * <li><a href="#">Song Two</a></li>
		 * <li><a href="#">Song Three</a></li>
		 * <li><a href="#">Song Four</a></li>
		 * <li><a href="#">Song Five</a></li>
		 * </ul>
		 * </div>
		 **********************************************************************/
	}

	getCurrentUsersProfile();
	getFivePlaylists();
});
