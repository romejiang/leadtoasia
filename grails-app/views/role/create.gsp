<head>
	<meta name="layout" content="main" />
	<title>创建角色</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
		<span class="menuButton"><g:link class="list" action="list">角色清单</g:link></span>
	</div>

	<div class="body">

		<h1>创建角色</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${authority}">
		<div class="errors">
		<g:renderErrors bean="${authority}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save">
		<div class="dialog">
		<table>
		<tbody>
			<tr class="prop">
				<td valign="top" class="name"><label for="authority">角色名称：</label></td>
				<td valign="top" class="value ${hasErrors(bean:authority,field:'authority','errors')}">
					<input type="text" id="authority" name="authority" value="${authority?.authority?.encodeAsHTML()}"/>
				</td>
			</tr>

			<tr class="prop">
				<td valign="top" class="name"><label for="description">角色描述：</label></td>
				<td valign="top" class="value ${hasErrors(bean:authority,field:'description','errors')}">
					<input type="text" id="description" name="description" value="${authority?.description?.encodeAsHTML()}"/>
				</td>
			</tr>
		</tbody>
		</table>
		</div>

		<div class="buttons">
			<span class="button"><input class="save" type="submit" value="Create" /></span>
		</div>
		</g:form>
	</div>
</body>
