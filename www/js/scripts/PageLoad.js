$(document).ready(function() {

	$("#content").css('padding-right', '0px');
	$("#content").css('padding-left', '0px');

	changeActive = function(id) {
		$('.active').removeClass('active');
		$('#' + id).parent().attr('class', 'active');
	};
	makeAdminActive = function(){
		$('.active').removeClass('active');
		$("#admin").attr("class", "active");
	}

	$.ajax({
		url : 'home.html',
		type : 'POST',
		success : function() {
		}
	}).done(function(html) {
		$("#content").html(html);
		$("#content").css("height", "initial");
	});

	$("#home").on('click', function() {
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
	$("#on-air").on('click', function() {
		changeActive('on-air');
		$.ajax({
			url : 'onair.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#library").on('click', function() {
		changeActive('library');
		$.ajax({
			url : 'library.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
		});
	});
	$("#profile").on('click', function() {
		changeActive('profile');
		$.ajax({
			url : 'profile.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	});
	$("#view-exceptions").on('click', function() {
		makeAdminActive();
		$.ajax({
			url : 'errorViewer.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
	$("#manage-user").on('click', function() {
		makeAdminActive();
		$.ajax({
			url : 'manageUsers.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
	$("#manage-user-types").on('click', function() {
		makeAdminActive();
		$.ajax({
			url : 'manageUserTypes.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
	$("#manage-readers").on('click', function() {
		changeActive('manage-readers');
		$.ajax({
			url : 'manageReaders.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
	$("#analytics").on('click', function() {
		makeAdminActive();
		$.ajax({
			url : 'analytics.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
});
