$(function(){
	var values = ["", "100" , "25", "50", "100"]
	  
	$("#match").change( function() {
		//alert($(this).val());
		$("#discount").val(values[$(this)[0].selectedIndex]);
	}); 
}) 