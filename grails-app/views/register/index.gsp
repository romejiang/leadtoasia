<head>
	<meta name="layout" content="main" />
	<title>用户注册</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><a class='home' href="${createLinkTo(dir:'')}">主页</a></span>
	</div>

	<div class="body">
		<h1>用户注册</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${person}">
		<div class="errors">
			<g:renderErrors bean="${person}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save">
		<div class="dialog">
		<table>
		<tbody>

			<tr class='prop'>
				<td valign='top' class='name'><label for='username'>登录名：</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'username','errors')}'>
					<input type="text" name='username' value="${person?.username?.encodeAsHTML()}"/>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='userRealName'>真实名称：</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'userRealName','errors')}'>
					<input type="text" name='userRealName' value="${person?.userRealName?.encodeAsHTML()}"/>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='passwd'>密码：</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
					<input type="password" name='passwd' value="${person?.passwd?.encodeAsHTML()}"/>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='enabled'>确认密码：</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
					<input type="password" name='repasswd' value="${person?.passwd?.encodeAsHTML()}"/>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='email'>Email:</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'email','errors')}'>
                    <g:textArea name="mail" cols="40" rows="5" value="${mail}" />
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='tel'>Tel:</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'tel','errors')}'>
					<input type="text" name='tel' value="${person?.tel}"/>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='fax'>Fax:</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'fax','errors')}'>
					<input type="text" name='fax' value="${person?.fax}"/>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='top' class='name'><label for='description'>个人描述：</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'description','errors')}'>
					<textarea name="description" rows="50" cols="8">${person?.description}</textarea>
				</td>
			</tr>

			<tr class='prop'>
				<td valign='bottom' class='name'><label for='code'>输入代码： </label></td>
				<td valign='top' class='name'>
					<input type="text" name="captcha" size="8"/>
					<img src="${createLink(controller:'captcha', action:'index')}" align="absmiddle"/>
				</td>
			</tr>

		</tbody>
		</table>
		</div>

		<div class="buttons">
			<span class="formButton">
				<input class='save' type="submit" value="Create"></input>
			</span>
		</div>

		</g:form>
	</div>
</body>
