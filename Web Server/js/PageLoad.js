$(document).ready(function() {

	$("#content").css('padding-right', '0px');
	$("#content").css('padding-left', '0px');

	changeActive = function(id) {
		$('.active').attr('class', '');
		$('#' + id).parent().attr('class', 'active');
	};

	$.ajax({
		url : 'login.html',
		type : 'POST',
		success : function() {
		}
	}).done(function(html) {
		$("#content").html(html);
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
		});
	});
	$("#manageUsers").on('click', function() {
		changeActive('manageUsers');
		$.ajax({
			url : 'manageUsers.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
		});
	});
	$("#manageLibrary").on('click', function() {
		changeActive('manageLibrary');
		$.ajax({
			url : 'manageLibrary.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
		});
	});
	$("#manageGrants").on('click', function() {
		changeActive('manageGrants');
		$.ajax({
			url : 'manageGrants.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
		});
	});
	$("#manageGrants").on('click', function() {
		changeActive('manageGrants');
		$.ajax({
			url : 'manageGrants.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
		});
	});
	$("#spinlist").on('click', function() {
		changeActive('spinlist');
		$.ajax({
			url : 'spinlist.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
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
		});
	});
});