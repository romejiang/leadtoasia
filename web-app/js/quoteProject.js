$(function(){
	generateID();
	$("#test").click(generateID);
	$("#global").click(generateID);
	 
}); 

 

function generateID(){
	var now = new Date();
	var m  =  now.getMonth() + 1;
	m = m < 10?"0"+m :m;

	var d = now.getDate() < 10?"0"+now.getDate() :now.getDate();
	
	var prefix = '';

	if ($("#test")[0].checked)
	{
		prefix = "CS";
	}else if($("#global")[0].checked){
			prefix = "GJ";
	}else{
		prefix = "GN";
	}
	var str =  prefix + " " + now.getFullYear() + "" + m +""+ d;
	
		var params = {  
			token:  new Date().getTime()
		}
 
//	$.get("./maxId?" +  jQuery.param(params) , function(data){
//		$("#projectNo").val(str + (parseInt(data) + 1));
//	});
	$("#projectNo").val(str + now.getMilliseconds());
	
}