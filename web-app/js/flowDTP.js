$(function(){
 
	$(".taskType").change(function() {
  
		var index = $(this).attr("index");
		var type = $(this).val();
 
		var amount = $(".taskAmount:eq("+index+")");
 
		if (type == '')
		{ 
			return;
		}else if (type == 'word')
		{
			amount.val($("#matchCount").val());
		}
  
// ========= end =================
	});

// ========= #dialog =================

	 // $("#dialog-select").dialog("destroy");

        $("#dialog-select").dialog({autoOpen:false,
                buttons:{"确定":function(){
                         $.each($(".selectLocalization") , function(i ,n){
                            if(n.checked){
								//alert(n.value);
								$("#tr_"+n.value).removeClass("hide");
							} else{
								$("#tr_"+n.value).addClass("hide")	;
								$("#tr_"+n.value).find(".taskPrice").val(0);
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