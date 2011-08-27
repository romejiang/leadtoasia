<head>
	<meta name="layout" content="main" />
	<title>用户档案</title>
</head>

<body>
	<div class="nav">
		<span class="menuButton"><a class='home' href="${createLinkTo(dir:'')}">主页</a></span>
	</div>

	<div class="body">
		<h1>用户档案</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<div class="dialog">
		<table>
		<tbody>

			<tr class="prop">
				<td valign="top" class="name">登录名：</td>
				<td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">真是名称：</td>
				<td valign="top" class="value">${person.userRealName?.encodeAsHTML()}</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">启用：</td>
				<td valign="top" class="value">${person.enabled}</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">Email:</td>
				<td valign="top" class="value">${person.email?.encodeAsHTML()}</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">显示邮件：</td>
				<td valign="top" class="value">${person.emailShow}</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name">权限：</td>
				<td valign="top" class="value">
					<ul>
					<g:each var='authority' in="${person.authorities}">
						<li>${authority.authority}</li>
					</g:each>
					</ul>
				</td>
			</tr>

		</tbody>
		</table>
		</div>

		<div class="buttons">
		<g:form>
			<input type="hidden" name="id" value="${person.id}" />
			<span class="button"><g:actionSubmit class='edit' value="Edit" /></span>
		</g:form>
		</div>

	</div>
</body>
