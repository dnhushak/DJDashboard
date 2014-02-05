$(document).ready(function() {

	$(".library-column").on('click', function(){
		$('.active-column').removeClass('active-column');
		$(this).addClass('active-column');
	});

	$(".item").on('click', function(){
		$(this).siblings(".active-item").removeClass('active-item');
		$(this).addClass('active-item');
	})
})