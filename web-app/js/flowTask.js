$(function(){

 
	$(".taskType").change(function() {

 
		var index = $(this).attr("index");
		var type = $(this).val();
		var target = $(".taskTarget:eq("+index+")");
		var price = $(".taskPrice:eq("+index+")");
		var unit = $(".taskUnit:eq("+index+")");

		//alert($(this).val());
//		alert( index +" : " + target.val() + price.val() + unit.val() );

		var params = {
			cid: $("#cid").val() ,
			source: $(".taskSource").val() ,
			target: target.val() ,
			type : type ,
			token:  new Date().getTime()
				}
 
//		alert(jQuery.param(params));
		$.getJSON("./getPricing?" + jQuery.param(params) , function(json){
		  
		  if (json.success)
		  {
			 if(json.message){
// 				 alert(json.message.unit);
				 unit.attr("value", json.message.unit);
				 price.val( json.message.price);
			 }
		  } 
		}); 
// ========= end =================
	});

});