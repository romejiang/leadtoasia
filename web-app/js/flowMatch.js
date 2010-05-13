$(function(){
	var result = $(".result");
	var calculate = function() {
		var total = 0;
		$.each($(".wordcount") , function(i ,n){
			var discount = $(".discount");
			result[i].value = cheng( (n.value * discount[i].value)/100 , 0);
			total+=  parseInt( result[i].value)
		});
		$("#total").val(total);
		
	}

	$(".wordcount").change(calculate); 
	$(".discount").change(calculate); 
	calculate();
}); 
function  cheng(num,n)  {
	var  dd=1;  
	var  tempnum;  
	for(i=0;i<n;i++)  
	{  
		dd*=10;  
	}  
	tempnum=num*dd;  
	
	return isNaN(tempnum) ? 0 : Math.round(tempnum);   
}  