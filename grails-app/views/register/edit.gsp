<head>
	<meta name="layout" content="main" />
	<title>修改个人档案</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><a class='home' href="${createLinkTo(dir:'')}">主页</a></span>
	</div>

	<div class="body">
		<h1>修改个人档案</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${person}">
		<div class="errors">
			<g:renderErrors bean="${person}" as="list" />
		</div>
		</g:hasErrors>

		<g:form>
			<input type="hidden" name="id" value="${person.id}" />
			<input type="hidden" name="version" value="${person.version}" />
			<div class="dialog">
			<table>
				<tbody>
				<tr class='prop'>
					<td valign='top' class='name'><label for='username'>登录名：</label></td>
					<td valign='top' class='value ${hasErrors(bean:person,field:'username','errors')}'>
						<input type="hidden" name='username' value="${person.username?.encodeAsHTML()}"/>
						<div style="margin:3px">${person.username?.encodeAsHTML()}</div>
					</td>
				</tr>

				<tr class='prop'>
					<td valign='top' class='name'><label for='userRealName'>真实名称：</label></td>
					<td valign='top' class='value ${hasErrors(bean:person,field:'userRealName','errors')}'>
						<input type="text" name='userRealName' value="${person.userRealName?.encodeAsHTML()}"/>
					</td>
				</tr>

				<tr class='prop'>
					<td valign='top' class='name'><label for='passwd'>密码：</label></td>
					<td valign='top' class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
						<input type="password" name='passwd' value=""/>
					</td>
				</tr>

				<tr class='prop'>
					<td valign='top' class='name'><label for='enabled'>确认密码：</label></td>
					<td valign='top' class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
						<input type="password" name='repasswd' />
					</td>
				</tr>

				<tr class='prop'>
					<td valign='top' class='name'><label for='email'>Email:</label></td>
					<td valign='top' class='value ${hasErrors(bean:person,field:'email','errors')}'>
						<input type="text" name='email' value="${person.email?.encodeAsHTML()}"/>
					</td>
				</tr>

				<tr class='prop'>
					<td valign='top' class='name'><label for='emailShow'>显示邮件：</label></td>
					<td valign='top' class='value ${hasErrors(bean:person,field:'emailShow','errors')}'>
						<g:checkBox name='emailShow' value="${person.emailShow}" ></g:checkBox>
					</td>
				</tr>

				</tbody>
			</table>
			</div>

			<div class="buttons">
				<span class="button"><g:actionSubmit class='save' value="Update" /></span>
			</div>

		</g:form>

	</div>
</body>
