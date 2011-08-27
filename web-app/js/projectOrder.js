$(function(){
	$(".outside").hide();

// 获得本地化 checkbox 框的内容
	function getLocalize(){
	 
		return $("#Localize").val();
	}
	// 计算一下总价格
	function sumTotal(){
		//sumWord();
		var price = parseFloat($("#rate").val());
		var amount = parseFloat($("#wordcount").val());
	  
		$("#total").val(getResult(price * amount , 2));
	}

	function getResult(num,n){ 
		return Math.round(num*Math.pow(10,n))/Math.pow(10,n); 
	} 

	function sumWord(){
		var matchwordcount = $(".matchwordcount");
		var sumword = 0
		$.each( $(".discount"), function(i, n){
			sumword += parseFloat(n.value)  * parseFloat(matchwordcount[i].innerHTML);
		}); 
		$("#wordcount").val(sumword/100);
	}
//====================================
	$("#calculate").click(sumTotal);
	$("#sum").click(sumWord);
	$(".discount").change(sumTotal);

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
	$(".userSelected").live("click" ,function() {
		$("#spinner").show(); 
 
		var code = getLocalize(); 
//		alert($("#type").val());
		var params = { 
			code: code,
			type: $("#type").val() ,
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
				//$("#type").attr("value",json.message.type);
				sumTotal();
			}else{
				$(".outside").hide();
				$("#total").val('0.0');
			}
			$("#spinner").fadeOut(500); 
		}); 
	}); 
}) 