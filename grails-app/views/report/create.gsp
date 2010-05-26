

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${reportInstance}">
            <div class="errors">
                <g:renderErrors bean="${reportInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="project"><g:message code="report.project.label" default="Project" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reportInstance, field: 'project', 'errors')}">
                                    <g:select name="project.id" from="${Project.list()}" optionKey="id" value="${reportInstance?.project?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="income"><g:message code="report.income.label" default="Income" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reportInstance, field: 'income', 'errors')}">
                                    <g:textField name="income" value="${fieldValue(bean: reportInstance, field: 'income')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="expenses"><g:message code="report.expenses.label" default="Expenses" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reportInstance, field: 'expenses', 'errors')}">
                                    <g:textField name="expenses" value="${fieldValue(bean: reportInstance, field: 'expenses')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="profit"><g:message code="report.profit.label" default="Profit" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reportInstance, field: 'profit', 'errors')}">
                                    <g:textField name="profit" value="${fieldValue(bean: reportInstance, field: 'profit')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="start"><g:message code="report.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reportInstance, field: 'start', 'errors')}">
                                    <g:datePicker name="start" precision="day" value="${reportInstance?.start}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deadline"><g:message code="report.deadline.label" default="Deadline" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reportInstance, field: 'deadline', 'errors')}">
                                    <g:datePicker name="deadline" precision="day" value="${reportInstance?.deadline}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
