$(function(){
	$("#spinner").fadeOut(1000); 

	$(".left ol li").hover(function() {
        $(this).toggleClass('menubg');
	});

	$("#grailsLogo").pngFix();
	$(".container").corner("bottom");

}) 