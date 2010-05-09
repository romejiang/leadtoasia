

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'match.label', default: 'Match')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript src="match.js" >
		</g:javascript>
    </head>
    <body>
        <div class="nav">
             </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${matchInstance}">
            <div class="errors">
                <g:renderErrors bean="${matchInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${matchInstance?.id}" />
                <g:hiddenField name="version" value="${matchInstance?.version}" />
				<input type="hidden" name="pid" value="${pid}">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="wordcount"><g:message code="match.wordcount.label" default="Wordcount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: matchInstance, field: 'wordcount', 'errors')}">
                                    <g:textField name="wordcount" value="${fieldValue(bean: matchInstance, field: 'wordcount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="match"><g:message code="match.match.label" default="Match" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: matchInstance, field: 'match', 'errors')}">
                                    <g:select name="match" from="${matchInstance.constraints.match.inList}" value="${matchInstance?.match}" valueMessagePrefix="match.match" 
									noSelection="['':'- Choose -']"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="discount"><g:message code="match.discount.label" default="Discount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: matchInstance, field: 'discount', 'errors')}">
                                    <g:textField name="discount" value="${fieldValue(bean: matchInstance, field: 'discount')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
