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
	//calculate();


	$("#calculate").click(function(){
		var val = $("#name1").val();
		var ms = val.split(/\n/);
		var keyword = ["Repetitions","100%","95%","85%","75%","50%","No Match"];
		var rate = [15,15,15,50,50,100,100];
        var total = 0;
        var sum = 0;
		$("#log").val("");
		for (var x =0 ; x < ms.length ; x++ )
		{
		 //alert(ms[x]);
			for (var k=0; k < keyword.length ; k++ )
			{
				if (ms[x].indexOf(keyword[k]) > -1)
				{
					//(keyword[k]);
					var mskey = ms[x];
					mskey = mskey.replace(" - ","-"); 
					mskey = mskey.replace("No Match","NoMatch"); 

					mskey = mskey.replace(/[ ]+/g,"|"); 
	
					mskey = mskey.split("|");
			
                    $(".wordcount")[k].value =  parseInt(mskey[3]);
				}
			}
		}
		calculate();
    });
 
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