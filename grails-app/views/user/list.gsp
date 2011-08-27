<head>
	<meta name="layout" content="main" />
	<title>用户列表</title>
</head>

<body>

	<div class="nav">
	 </div>

	<div class="body">
		<h1>用户列表</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
        <div class="search"><form method=post action="search">
           <g:ifAnyGranted role="ROLE_ADMIN">

         <g:select id="role" name='role' value="${role}" from='${Role.list()}'
        optionKey="id" optionValue="description" noSelection="${['':' - 选择权限组 - ']}"></g:select>
        </g:ifAnyGranted>  
       
        <g:select id="source" name='source' value="${source}" from='${org.grails.plugins.lookups.Lookup.codeList("Language")}'
        optionKey="code" optionValue="value" noSelection="${['':' - 选择源语言 - ']}"></g:select>
        <g:select id="target" name='target' value="${target}" from='${org.grails.plugins.lookups.Lookup.codeList("Language")}'
        optionKey="code" optionValue="value" noSelection="${['':' - 选择目标语言 - ']}"></g:select>
        <input type="text" name="keyword" title="keyword" value="${keyword}">
        &nbsp;<input type="submit" value="search">
        </form></div>
		<div class="list">
			<table>
			<thead>
  					<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Login Name')}" />
 					<g:sortableColumn property="userRealName" title="${message(code: 'user.userRealName.label', default: 'Full Name')}" />

					<g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" />
		 
					<g:sortableColumn property="fullTime" title="${message(code: 'user.fullTime.label', default: 'fullTime')}" />
					<g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" />
					<th></th>
				</tr>
			</thead>
			<tbody>
			<g:each in="${personList}" status="i" var="person">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
					 
					<td><g:link action="show" id="${person.id}">${person.username.encodeAsHTML()} </td>
                    
                    <td>  ${person.userRealName?.encodeAsHTML()}</g:link></td>
					 
					<td><g:each in="${person.mails}" var="m">
                    ${m}<br>
                    </g:each></td>
				 
					
					<td>${person.fullTime?"full-time":"part-time"}</td>
					<td><g:link  action="switchUser" id="${person.id}">${person.enabled?"disable" : "enable"}</g:link></td>
					<td>
								<g:link controller="pricing" action="create" params="[pid : person.id,parentType:'user']">添加语言 </g:link><br>
								<g:link controller="pricing" action="list" params="[pid : person.id,parentType:'user']">管理 </g:link>
					</td>
				</tr>
			</g:each>
			</tbody>
			</table>
		</div>

		<div class="paginateButtons">
			<g:paginate total="${total}" />
		</div>

	</div>
</body>
