<html>
    <head>
        <title>Welcome to Grails</title>
		<meta name="layout" content="main" />
	 	<script language="JavaScript">
	<!--
		$(function(){
			$("#generate").click(function(){
				
				$("#img").attr("src","/leadtoasia/spondylosis/process?t=" + encodeURI($("#text").val()) + "&token=" + new Date().getTime())
			})
		})
	//-->
	</script>
    </head>

    <body>
	<div class="span-18 last">
	<textarea name="text" id="text" rows="50" cols="90">爱你不是两三天</textarea><br>
	<input type="button" id="generate" value="generate" ><br>
	<img src="${resource(dir:'images',file:'true.png')}" border=0 alt="" id="img"> 
	</div>
  
    </body>
</html>