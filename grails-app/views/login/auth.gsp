<head>
<meta name='layout' content='main' />
<title>Login</title>
<style type='text/css' media='screen'>
#login {
	margin:15px 0px; padding:20px;
	text-align:center;
}
#login .inner {
	width:420px;
	margin:0px auto;
	text-align: center;
	padding:10px;
	border:2px solid #576172; 
	background-color: #BAC1CC;
}
#login .inner .fheader {
	padding:4px;margin:3px 0px 3px 0;color:#2e3741;font-size:14px;font-weight:bold;
}
#login .inner .cssform p {
	clear: left;
	margin: 0;
	padding: 5px 5px;
	padding-left: 105px;
	border-top: 1px solid gray;
  
}
#login .inner .cssform input[type='text'] {
	width: 120px;
}
#login .inner .cssform label {
	font-weight: bold; 
	margin-left: -105px;
 
}
#login .inner .login_message {color:red;}
#login .inner .text_ {width:120px;}
#login .inner .chk {height:12px;}
</style>
<script language="JavaScript">
<!--
$(function(){
 
	$(".inner").corner();

}) 
//-->
</script>
</head>

<body>
	<div id='login'>
		<div class='inner'>
			<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
			</g:if>
			<div class='fheader'><g:message code="login.label" default="Please Login.." /></div>
			<form action='${postUrl}' method='POST' id='loginForm' class='cssform'>
				<p>
					<label for='j_username'><g:message code="user.username.label" default="Login Name" />：&nbsp;</label>
					<input type='text' class='text_' name='j_username' id='j_username' value='${request.remoteUser}' />
				</p>
				<p>
					<label for='j_password'>&nbsp;&nbsp;&nbsp;<g:message code="user.passwd.label" default="Password" />：&nbsp;</label>
					<input type='password' class='text_' name='j_password' id='j_password' />
				</p> 
				<p>
					<input type='checkbox' class='chk hide' name='_spring_security_remember_me' id='remember_me'  />
			 
					<input type='submit' value="${message(code: 'default.login.label', default: 'Login')}" style="width: 80px"/>
				</p>
			</form>
		</div>
	</div>
<script type='text/javascript'>
<!--
(function(){
	document.forms['loginForm'].elements['j_username'].focus();
})();
// -->
</script>
</body>
