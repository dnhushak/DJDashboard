$(document).ready(function() {
	formatClass = function(str){
		str = str.replace(/ /g, '.');
		return '.' + str;
	}
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
	$.ajax({
            url: '../php/scripts/testlibrary.php',
            type: 'POST',
            success: function() {}
    }).done(function(data) {
            var songs = JSON.parse(data); 
            for (var i = 0; i < 25; i++) {
            	//Add artist name and album to seletion at the tom
            	$('#artists .selection').append('<li class="item">'+songs[i]['Artist Name']+'</li>');	
            	$('#albums .selection').append('<li class="item">'+songs[i]['Album Name']+'</li>');

            	//Add all track information into the track view
            	$('#suggested .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Recommended']+'</li>');	
            	$('#track .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Name']+'</li>');	
            	$('#artist .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Artist Name']+'</li>');
            	$('#album .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['Album Name']+'</li>');	
            	$('#genre .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+'GENRE'+'</li>');	
            	$('#play-count .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['PlayCount']+'</li>');	
            	$('#FCC .tracks').append('<li class="item '+songs[i]['idtrack']+'">'+songs[i]['FCC']+'</li>');	
            };
    });
})