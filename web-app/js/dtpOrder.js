$(function(){
	$(".outside").hide();
 
//====================================
 	// 计算一下总价格
	function sumTotal(){
		var price = parseFloat($("#rate").val());
		var amount = parseFloat($("#wordcount").val());
	  
		 $("#total").val(price * amount );
 
	}
//====================================
	$("#calculate").click(sumTotal);
	$("#type").change(function (){
		if ($(this).val() == 'word')
		{ 
			$(".matcharea").show();
		}else{
			$(".matcharea").hide();
		}
		sumTotal();
	});
// 内部外部用户选择后提供不同的输入框
	$(".userSelected").click(function() {
  
		var params = { 
 			id: $(this).val(),
			token:  new Date().getTime()
		}
		$.getJSON("./checkUser?" +  jQuery.param(params) , function(json){
		  //alert("JSON Data: " + json.success + json.message);
			if (json.success)
			{
				$(".outside").show();
				 
				$("#rate").val(json.message.price);
				$("#unit").attr("value",json.message.unit);
 				sumTotal();
			}else{
				$(".outside").hide();
				$("#total").val('0.0');
			}
		}); 
	});  

}) 