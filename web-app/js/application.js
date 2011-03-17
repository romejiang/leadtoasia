$(function(){
	$("#spinner").fadeOut(1000); 

	$(".left ol li").hover(function() {
        $(this).toggleClass('menubg');
	});

	$("#grailsLogo").pngFix();
	$(".container").corner("bottom");

	$("#locale").change(function(){
		//window.location.href=window.location.href + '?lang=' +(this.options[this.options.selectedIndex].value)
		//alert($(this).val());
		var url = window.location.href;
		url = url.replace(/lang=[^&]*/, "");
		if (url.indexOf("?") > -1)
		{
			url = url + "&lang=" + $(this).val();
		}else{
			url = url + "?lang=" + $(this).val();
		}

			window.location.href = url;
	});
	
}) ;

