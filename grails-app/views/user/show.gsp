<head>
	<meta name="layout" content="main" />
	<title>显示用户信息</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">主页</a></span>
		<span class="menuButton"><g:link class="list" action="list">用户列表</g:link></span>
		<span class="menuButton"><g:link class="create" action="create">新用户</g:link></span>
	</div>

	<div class="body">
		<h1>显示用户信息</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<div class="dialog">
			<table>
			<tbody>

				<tr class="prop">
					<td valign="top" class="name">ID:</td>
					<td valign="top" class="value">${person.id}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">登录名：</td>
					<td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">真实名称：</td>
					<td valign="top" class="value">${person.userRealName?.encodeAsHTML()}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">详细描述：</td>
					<td valign="top" class="value">${person.description?.encodeAsHTML()}</td>
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
					<td valign="top" class="name">全职员工：</td>
					<td valign="top" class="value">${person.fullTime?"full-time":"part-time"}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">已启用：</td>
					<td valign="top" class="value">${person.enabled?"enabled" : "disabled"}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">Tel:</td>
					<td valign="top" class="value">${person.tel}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">Fax:</td>
					<td valign="top" class="value">${person.fax}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">角色：</td>
					<td valign="top" class="value">
						<ul>
						<g:each in="${roleNames}" var='name'>
							<li>${name}</li>
						</g:each>
						</ul>
					</td>
				</tr>
		        <tr class="prop">
					<td valign="top" class="name">行业：</td>
					<td valign="top" class="value"> 
						<ul>
						<g:each in="${person?.industrys}" var='industry'>
							<li>${industry.name}</li>
						</g:each>
						</ul>
					</td>
				</tr>

                <tr class="prop">
					<td valign="top" class="name">简历：</td>
					<td valign="top" class="value">
						<ul>
					    <g:each in="${person?.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="cv"
									errorController="my"
                                    contentDisposition="attachment">${f.name}</fileuploader:download>
									</li>
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
				<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
				<!--<span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>-->
			</g:form>
		</div>

	</div>
</body>
