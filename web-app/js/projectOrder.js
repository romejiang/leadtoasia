$(function(){
	$(".outside").hide();
// 获得本地化 checkbox 框的内容
	function getLocalize(){
		var code = [];
		$(".localize").each(function(){
			//alert($(this).attr('checked'));
			if ($(this).attr('checked'))
			{
				code.push($(this).attr('String'));
			}
		});
		return code;
	}
	// 计算一下总价格
	function sumTotal(){
		var price = parseFloat($("#rate").val());
		var amount = parseFloat($("#wordcount").val());
		var total = 0;
		
//		$.each( $(".matchs"), function(i, n){
//			window.status =  n.value + n.tagName;
//		});
		if ($("#type").val()== 'word')
		{
		
			$.each( $(".matchwordcount"), function(i, n){
				wordcount = $(n);
				 
	//			window.status += wordcount.html() + $(".matchs")[i].value;
				total += price * parseInt(wordcount.html()) * parseInt($(".matchs")[i].value) /100;
			}); 
	//		window.status = total;
			$("#total").val(Math.round(total*100)/100);
		}else{
			$("#total").val(price * amount );
		}
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
	$(".userSelected").live("click" ,function() {
//		alert($(this).val());
		var code = getLocalize();
//		alert(code.length);
  
		var params = { 
			code: code.length == 0 ? '' : code.join(',') ,
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
				$("#type").attr("value",json.message.type);
				sumTotal();
			}else{
				$(".outside").hide();
				$("#total").val('0.0');
			}
		}); 
	}); 


// 根据本地化要求，选择相应的用户
	$(".localize").click( function() {
		//window.status = $(this).val();
		var code = getLocalize();
//		alert(code.length);
		if (code.length == 0)
		{
			$('.vendorSelect').html('');
			return;
		}

		var params = { 
			code: code.join(',') ,
			token:  new Date().getTime()
		}
		//		window.status = (jQuery.param(params));
		$.getJSON("./getVendor?" + jQuery.param(params) , function(json){
		  
		  if (json.success)
		  {
			 if(json.message){
				 ApplyTemplate(json.message);
			 }
		  } 
		}); 
	});

	// Apply template 
	function ApplyTemplate(data) {  
		 $('.vendorSelect').setTemplateElement('jtemplate');  
		 $('.vendorSelect').processTemplate(data);  
	 }  

}) 