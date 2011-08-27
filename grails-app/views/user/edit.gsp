<head>
	<meta name="layout" content="main" />
	<title>修改用户</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">主页</a></span>
		<span class="menuButton"><g:link class="list" action="list">用户列表</g:link></span>
		<span class="menuButton"><g:link class="create" action="create">新用户</g:link></span>
	</div>

	<div class="body">
		<h1>修改用户</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${person}">
		<div class="errors">
			<g:renderErrors bean="${person}" as="list" />
		</div>
		</g:hasErrors>

		<div class="prop">
			<span class="name">ID:</span>
			<span class="value">${person.id}</span>
		</div>

		<g:form>
			<input type="hidden" name="id" value="${person.id}" />
			<input type="hidden" name="version" value="${person.version}" />
			<div class="dialog">
				<table>
				<tbody>

					<tr class="prop">
						<td valign="top" class="name"><label for="username">登录名：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'username','errors')}">
							<input type="text" id="username" name="username" value="${person.username?.encodeAsHTML()}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="userRealName">真实名称：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'userRealName','errors')}">
							<input type="text" id="userRealName" name="userRealName" value="${person.userRealName?.encodeAsHTML()}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="passwd">密码：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'passwd','errors')}">
							<input type="password" id="passwd" name="passwd" value="${person.passwd?.encodeAsHTML()}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="enabled">已启用：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'enabled','errors')}">
							<g:checkBox name="enabled" value="${person.enabled}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="email">Email:</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
                                    <g:textArea name="mail" cols="40" rows="5" value="${mail}" />
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="emailShow">显示邮件：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'emailShow','errors')}">
							<g:checkBox name="emailShow" value="${person.emailShow}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="fullTime">全职员工：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'fullTime','errors')}">
							<g:checkBox name="fullTime" value="${person.fullTime}"/>
						</td>
					</tr>

                       <tr class="prop">
						<td valign="top" class="name"><label for="useSoft">是否使用软件：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'useSoft','errors')}">
							<g:checkBox name="useSoft" value="${person.useSoft}"/>
						</td>
					</tr>

                    <tr class="prop">
						<td valign="top" class="name"><label for="level">等级：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'level','errors')}">
                            <g:select name="level" from="${(0..5)}" value="${person.level}"  />
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
				<td valign='top' class='name'><label for='description'>详细描述：</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'description','errors')}'>
					<textarea name="description" rows="50" cols="8">${person?.description}</textarea>
				</td>
			</tr>

                    <tr class="prop">
						<td valign="top" class="name" align="left">擅长行业 :</td>
					 
                        <td align="left">
                        
                        <g:each in="${Industry.list()}">
                        <g:set var="checked" value="false"> </g:set>
                            <g:each in="${person?.industrys}" var="ind">
                                <g:if test="${ind.id == it.id }">
                                    <g:set var="checked" value="true"> </g:set>
                                </g:if>
                            </g:each>
 						<g:checkBox name="industrys" value="${it.id}" checked="${checked}" />${it.encodeAsHTML()}<br>
                        </g:each>
                        </td>
					</tr>

                    <g:ifAnyGranted role="ROLE_ADMIN">  
					<tr class="prop">
						<td valign="top" class="name"><label for="authorities">角色：</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'authorities','errors')}">
							<ul>
							<g:each var="entry" in="${roleMap}">
								<li>${entry.key.authority.encodeAsHTML()}
									<g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
								</li>
                             </g:each> 
							</ul>
						</td>
					</tr>
                    </g:ifAnyGranted>  
				</tbody>
				</table>
			</div>

			<div class="buttons">
				<span class="button"><g:actionSubmit class="save" value="Update" /></span>
				<span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
			</div>

		</g:form>

	</div>
</body>
