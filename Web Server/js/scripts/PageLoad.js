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
	$("#manageUsers").on('click', function() {
		changeActive('manageUsers');
		$.ajax({
			url : 'manageUsers.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
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
	$("#viewExceptions").on('click', function() {
		changeActive('viewExceptions');
		$.ajax({
			url : 'errorViewer.html',
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
			$("#content").css("height", "initial");
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
	$("#manage-psa").on('click', function() {
		makeAdminActive();
		$.ajax({
			url : 'managePSAs.html',
			type : 'POST',
			success : function() {
			}
		}).done(function(html) {
			$("#content").html(html);
			$("#content").css("height", "initial");
		});
	})
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
});
