$(function(){

 
	$(".taskType").change(function() {
		$("#spinner").show(); 
 
		var index = $(this).attr("index");
		var type = $(this).val();
		var target = $(".taskTarget:eq("+index+")");
		var price = $(".taskPrice:eq("+index+")");
		var unit = $(".taskUnit:eq("+index+")");

		//alert($(this).val());
//		alert( index +" : " + target.val() + price.val() + unit.val() );
		if (type == '')
		{
			$("#spinner").hide(); 
			return;
		}
		var params = {
			cid: $("#cid").val() ,
			source: $(".taskSource").val() ,
			target: target.val() ,
			type : type ,
			token:  new Date().getTime()
				}
 
////		alert(jQuery.param(params));
		
		$.getJSON("./getPricing?" + jQuery.param(params) , function(json){
		  
		  if (json.success)
		  {
			 if(json.message){
 				 //alert(json.message.unit);
				 unit.attr("value", json.message.unit);
				 price.val( json.message.price);
				 $("#spinner").fadeOut(1000); 
			 }
		  } 
		}); 
// ========= end =================
	});

// ========= #dialog =================

	 // $("#dialog-select").dialog("destroy");

        $("#dialog-select").dialog({autoOpen:false,
                buttons:{"确定":function(){
                         $.each($(".selectLocalization") , function(i ,n){
                            if(n.checked){
								//alert(n.value);
								$("#tr_"+n.value).removeClass("hide")
							} else{
								$("#tr_"+n.value).addClass("hide")	
							}
                        });
                        $(this).dialog("close");
                        }},
                    closeOnEscape:true,
                    hide:"slide",
                    minWidth: 200,
                    width: 260,
                    height: 350,
                    modal:true}
                    );
        $("#addLocalization").click(function(){
               $("#dialog-select").dialog("open");
        });

});