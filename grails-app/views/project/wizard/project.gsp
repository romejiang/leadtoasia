

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
 		<g:javascript src="enterEvent.js"  />

    </head>
    <body>
  
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
             <g:render template="navigate" model="['number': 1]" />

            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projectInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectInstance}" as="list" />
            </div>
            </g:hasErrors>
             <g:form action="wizard" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projectNo"><g:message code="project.projectNo.label" default="Project No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'projectNo', 'errors')}">
                                    <g:textField name="projectNo" maxlength="250" value="${projectInstance?.projectNo}" />* Auto-fill in the blank
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="project.name.label" default="Project Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'name', 'errors')}">
                                   <g:textField name="name" maxlength="250" value="${projectInstance?.name}" />
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fromNo"><g:message code="project.fromNo.label" default="Customer Project No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'fromNo', 'errors')}">
                                   <g:textField name="fromNo" maxlength="250" value="${projectInstance?.fromNo}" />
                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer"><g:message code="project.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'customer', 'errors')}">
                                    <g:select name="customer.id" from="${Customer.list()}" optionKey="id" value="${projectInstance?.customer?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="start"><g:message code="project.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'start', 'errors')}">
                                    <g:formatDate date="${projectInstance?.start}" />
                                </td>
                            </tr>
							
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deadline"><g:message code="project.deadline.label" default="Deadline" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'deadline', 'errors')}">
                                    <g:datePicker name="deadline" precision="hour" value="${projectInstance?.deadline}"  />
                                </td>
                            </tr>
                         
                           
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content"><g:message code="project.content.label" default="Content" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'content', 'errors')}">
                                    <g:textArea name="content" cols="40" rows="5" value="${projectInstance?.content}" />
                                </td>
                            </tr>
                         
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="next" class="next" value="next" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
