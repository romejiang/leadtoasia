function modalDialog(data){	
	$('<div id="overlay">').css({
								
		width:$(document).width(),
		height:$(document).height(),
		opacity:0.6
		
	}).appendTo('body').click(function(){
		
		$(this).remove();
		$('#windowBox').remove();
		
	});
	
	$('body').append('<div id="windowBox">'+data+'</div>');

	$('#windowBox').css({
		width:500,
		height:350,
		left: ($(window).width() - 500)/2,
		top: ($(window).height() - 350)/2
	});
}