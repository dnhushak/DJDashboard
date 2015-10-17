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
		url : 'html/home.html',
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
			url : 'html/home.html',
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
			url : 'html/onair.html',
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
			url : 'html/library.html',
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
			url : 'html/profile.html',
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
			url : 'html/errorViewer.html',
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
			url : 'html/manageUsers.html',
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
			url : 'html/manageUserTypes.html',
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
			url : 'html/manageReaders.html',
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
			url : 'html/analytics.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
});
