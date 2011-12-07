$(function(){
	// 生成的日期选择总数
	var total = [0,50,20,10,5];
	$("#datetime").change(function(){
		
		//[1: '本周' , 2:'本月' , 3: '季度' ,4:'全年',5:'所有']
		var datepack = $("#datepack");
		datepack.empty();
		datepack.prepend(option("","- 请选择时间 -"));
		clearTime();

		var objDate = new Date();  
		var year = objDate.getFullYear();
		var month = objDate.getMonth()+1;    
		var selected = parseInt($(this).val());

		switch(selected)
		{
		case 1: 
			break
		case 2:
			var month = new Date().getMonth() + 1;
			for (var x = 0; x < total[selected] ; x++)
			{
				datepack.append(option(year + "-" + month , year + "年 " + month + "月"));
				if (month == 1)
				{
					month = 12;
					year = year - 1
				} else{  
					month = month - 1;
				}
			}
			break
		case 3:
			var month = new Date().getMonth() + 1;
			month = parseInt( month / 3 );

			for (var x = 0; x < total[selected] ; x++)
			{
				datepack.append(option(year + "-" + month , year + "年 第" + month + "季度"));
				if (month == 1)
				{
					month = 4;
					year = year - 1;
				} else{  
					month = month - 1;
				}
			}
			break;
		case 4: 
			for (var x = 0; x < total[selected] ; x++)
			{
				datepack.append(option(year +"-0"  , year + "年" ));
				year = year - 1; 
			}
			break; 
		} 

	});
	
	$("#datepack").change(function(){
		var selected = $(this).val();
		var range = parseInt( $("#datetime").val() );
		var year = selected.split('-')[0];
		var month = selected.split('-')[1];
		var startTime = $("#startTime");
		var endTime = $("#endTime");
		if (selected == "")
		{
			clearTime();
			return;
		}
 		switch(range)
			{
			case 2: 
				startTime.val(year + "-" + month + "-1 00:00:00");
				endTime.val(year + "-" + month + "-31 23:59:59");
				break
			case 3: 
				startTime.val(year + "-" + (month * 3 - 2) + "-1 00:00:00");
				endTime.val(year + "-" + (month * 3) + "-31 23:59:59");
				break
			case 4: 
				startTime.val(year + "-1-1 00:00:00");
				endTime.val(year + "-12-31 23:59:59");
				break
			} 
	});

  
	$( "#select-client" ).autocomplete({
		minLength: 0,
		source: projects,
		focus: function( event, ui ) {
			$( "#select-client" ).val( ui.item.label );
			//$( "#client").val( ui.item.value ); 
			return false;
		},
		select: function( event, ui ) {
			$( "#select-client" ).val( ui.item.label );
			$( "#client").val( ui.item.value ); 
			return false;
		}
	})
	.data( "autocomplete" )._renderItem = function( ul, item ) {
		return $( "<li></li>" )
			.data( "item.autocomplete", item )
			.append( "<a>" + item.label + "</a>" )
			.appendTo( ul );
	};


	$( "#client-pop" ).click(function(){
		// close if already visible
		var input = $( "#select-client" );
		if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
			input.autocomplete( "close" );
			return;
		}

		// work around a bug (likely same cause as #5265)
		$( this ).blur();

		// pass empty string as value to search for, displaying all results
		input.autocomplete( "search", "" );
		input.focus();
	});

});

function clearTime(){
	$("#startTime").val("");
	$("#endTime").val("");
}

function option(value , name){
	return "<option value='"+value+"'>"+name+"</option>"
}