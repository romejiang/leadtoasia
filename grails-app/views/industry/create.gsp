

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="industry.create" default="Create Industry" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="industry.list" default="Industry List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="industry.create" default="Create Industry" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${industryInstance}">
            <div class="errors">
                <g:renderErrors bean="${industryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="industry.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: industryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="250" value="${fieldValue(bean: industryInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enname"><g:message code="industry.enname" default="Enname" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: industryInstance, field: 'enname', 'errors')}">
                                    <g:textField name="enname" maxlength="250" value="${fieldValue(bean: industryInstance, field: 'enname')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
