<head>
	<meta name="layout" content="main" />
	<title>Edit User</title>
</head>

<body>

 

	<div class="body">
		<h1>Profiles</h1>
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

					<tr class="prop">
						<td valign="top" class="name"><label for="username">Login Name:</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'username','errors')}">
							${person.username?.encodeAsHTML()}
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="userRealName">Full Name:</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'userRealName','errors')}">
							<input type="text" id="userRealName" name="userRealName" value="${person.userRealName?.encodeAsHTML()}"/>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name"><label for="passwd">Password:</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'passwd','errors')}">
							<input type="password" id="passwd" name="passwd" value="${person.passwd?.encodeAsHTML()}"/>
						</td>
					</tr>
 

					<tr class="prop">
						<td valign="top" class="name"><label for="email">Email:</label></td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
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
				<td valign='top' class='name'><label for='description'>Description:</label></td>
				<td valign='top' class='value ${hasErrors(bean:person,field:'description','errors')}'>
					<textarea name="description" rows="50" cols="8">${person?.description}</textarea>
				</td>
			</tr>


			 

				</tbody>
				</table>
			</div>

			<div class="buttons">
				<span class="button"><g:actionSubmit class="save" value="Update" /></span>
			</div>

		</g:form>

	</div>
</body>
