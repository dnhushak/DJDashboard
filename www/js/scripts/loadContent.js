function changeActive(id){
	$('.active').addClass('cursor');
	$('.active').removeClass('active');
	$('#' + id).parent().attr('class', 'active');
};

function makeAdminActive(){
	$('.active').addClass('cursor');
	$('.active').removeClass('active');
	$("#admin").attr("class", "active");
};

function loadContent(contentUrl, buttonID){
	changeActive(buttonID);
	$.ajax({
	    url : contentUrl,
	    type : 'POST',
	    success : function(){}
	}).done(function(html){
		$("#content").html(html);
		$("#content").css("height", "initial");
	});
}

$(document).ready(function(){
	
	$("#content").css('padding-right', '0px');
	$("#content").css('padding-left', '0px');
	

	
	// $("#home").on('click',
	// loadContent('html/home.html', 'home'));
	//	        
	// $("#on-air").on('click',
	// loadContent('html/onair.html', 'on-air'));
	//	        
	// $("#library").on('click',
	// loadContent('html/library.html', 'library'));
	//	        
	// $("#profile").on('click',
	// loadContent('html/profile.html', 'profile'));
	//	        
	// $("#view-exceptions").on('click',
	// loadContent('html/errorViewer.html', 'view-exceptions'));
	//	        
	// $("#manage-user").on('click',
	// loadContent('html/manageUsers.html', 'manage-user'));
	//	       
	// $("#manage-user-types").on('click',
	// loadContent('html/manageUserTypes.html', 'manage-user-types'));
	//	        
	// $("#manage-readers").on('click',
	// loadContent('html/readerManage.html', 'manage-readers'));
	//	       
	// $("#analytics").on('click',
	// loadContent('html/analytics.html', 'analytics'));
	//
	 loadContent('html/readerManage.html','manage-readers');
	$("#home").on('click', function(){
		changeActive('home');
		$.ajax({
		    url : 'html/home.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#on-air").on('click', function(){
		changeActive('on-air');
		$.ajax({
		    url : 'html/onair.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#library").on('click', function(){
		changeActive('library');
		$.ajax({
		    url : 'html/library.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
		});
	});
	$("#profile").on('click', function(){
		changeActive('profile');
		$.ajax({
		    url : 'html/profile.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#view-exceptions").on('click', function(){
		makeAdminActive();
		$.ajax({
		    url : 'html/errorViewer.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#manage-user").on('click', function(){
		makeAdminActive();
		$.ajax({
		    url : 'html/manageUsers.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#manage-user-types").on('click', function(){
		makeAdminActive();
		$.ajax({
		    url : 'html/manageUserTypes.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#manage-readers").on('click', function(){
		changeActive('manage-readers');
		$.ajax({
		    url : 'html/readerManage.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#analytics").on('click', function(){
		makeAdminActive();
		$.ajax({
		    url : 'html/analytics.html',
		    type : 'POST',
		    success : function(){}
		}).done(function(html){
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
});
