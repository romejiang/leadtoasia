$(function(){
	var getPricing = function() {
		if ($("#source").val() == $("#target").val()) return;
		$("#spinner").show(); 
		
		//alert($(this).val());
		var params = {
			pid: $("#pid").val() ,
			source: $("#source").val() ,
			target: $("#target").val() ,
			token:  new Date().getTime()
		}

//		window.status = (jQuery.param(params));
		$.getJSON("./getPricing?" + jQuery.param(params) , function(json){
		  
		  if (json.success){
			 if(json.message){
				 ApplyTemplate(json.message);
			 }
		  }else{
			$(".pricing").html("&nbsp;");
		  }
		  $("#spinner").fadeOut(500); 
		}); 
	}
// Apply template 
	function ApplyTemplate(data) {  
		 $(".pricing").setTemplateElement("jtemplate");  
		 $(".pricing").processTemplate(data);  
	 }  

	$(":radio[name='type']").change(function(){ 
		if("word" == $(this).val())$("#amount").val($("#total").val());
	});
// event bind
	$("#source").change( getPricing); 
	$("#target").change( getPricing); 

	$(".pricingInstance").live("click",function(){
//		window.status = $(this).attr('ptype')
 
//		$(":radio[name='unit'][value="+$(this).attr('unit')+"]").attr("checked","true");
//		alert($("#unit"));
		$("#unit").attr("value",$(this).attr('unit'));
		$(":radio[name='type'][value="+$(this).attr('ptype')+"]").attr("checked","true");
		//alert($(":radio[name='type']"))
 
		$("#price").val($(this).attr('price'));
		if("word" == $(this).attr('ptype'))$("#amount").val($("#total").val());
	})
}) 