$(document).ready(function(){
	$("#jquery_jplayer_1").jPlayer({
		ready : function(){
			$(this).jPlayer("setMedia", {
				m4a: "../resources/Polly.m4a"
			});
		},
		swfPath : "../js/",
		supplied : "m4a" 
	});
});