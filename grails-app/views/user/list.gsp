<head>
	<meta name="layout" content="main" />
	<title>User List</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
		<span class="menuButton"><g:link class="create" action="create">New User</g:link></span>
	</div>

	<div class="body">
		<h1>User List</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
        <div class="search"><form method=post action="search">
         <g:select id="role" name='role' value="${role}" from='${Role.list()}'
        optionKey="id" optionValue="description" noSelection="${['':'Select Role']}"></g:select>
        <g:select id="source" name='source' value="${source}" from='${org.grails.plugins.lookups.Lookup.codeList("Language")}'
        optionKey="code" optionValue="value" noSelection="${['':'Select Source Language']}"></g:select>
        <g:select id="target" name='target' value="${target}" from='${org.grails.plugins.lookups.Lookup.codeList("Language")}'
        optionKey="code" optionValue="value" noSelection="${['':'Select Target Language']}"></g:select>
        <input type="text" name="keyword" title="keyword" value="${keyword}">
        &nbsp;<input type="submit" value="search">
        </form></div>
		<div class="list">
			<table>
			<thead>
				<tr> 
 					<g:sortableColumn property="username" title="Login Name" />
 					<g:sortableColumn property="userRealName" title="Full Name" />

					<g:sortableColumn property="email" title="Email" />
		 
					<g:sortableColumn property="fullTime" title="fullTime" />
					<g:sortableColumn property="enabled" title="Enabled" />
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
								<g:link controller="pricing" action="create" params="[pid : person.id,parentType:'user']">Add </g:link><br>
								<g:link controller="pricing" action="list" params="[pid : person.id,parentType:'user']">Manage </g:link>
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
