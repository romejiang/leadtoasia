

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">主页</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projectInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${projectInstance?.id}" />
                <g:hiddenField name="version" value="${projectInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projectNo"><g:message code="project.projectNo.label" default="Project No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'projectNo', 'errors')}">
                                   ${projectInstance?.projectNo}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fromNo"><g:message code="project.fromNo.label" default="Customer Project No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'fromNo', 'errors')}">
                                   ${projectInstance?.fromNo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="customer"><g:message code="project.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'customer', 'errors')}">
                                <g:ifAllGranted role="ROLE_SALES"> 

                                    <g:ifNotGranted role="ROLE_SALES_DIRECTOR">  
                                        <g:select name="customer.id" from="${Customer.findAllByRegistrant(User.get(userId))}" optionKey="id" value="${projectInstance?.customer?.id}" noSelection="${['':'请选择...']}" />
                                     </g:ifNotGranted>

                                     <g:ifAllGranted role="ROLE_SALES_DIRECTOR">  
                                        <g:select name="customer.id" from="${Customer.findAllByRegistrantInList(User.findAll()?.findAll(){it.authorities.contains(Role.findByAuthority('ROLE_SALES'))})}" optionKey="id" value="${projectInstance?.customer?.id}"   noSelection="${['':'请选择...']}" />
                                     </g:ifAllGranted>
                                 </g:ifAllGranted>
                                 
                                  
                                 <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN"> 
                                    <g:select name="customer.id" from="${Customer.find()}" optionKey="id" value="${projectInstance?.customer?.id}"  noSelection="${['':'请选择...']}"  />
                                 </g:ifAnyGranted>
                                </td>
                            </tr> 

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="start"><g:message code="project.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'start', 'errors')}"> 
                                    <g:datePicker name="start" precision="hour" value="${projectInstance?.start}"  />
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
                                  <label for="state"><g:message code="project.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'state', 'errors')}">
                                    ${projectInstance?.state} 
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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
