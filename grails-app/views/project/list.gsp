

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
         <div class="search"><form method=post action="search">
         <g:select id="client" name='client' value="${client}" from='${Customer.list()}'
        optionKey="id" optionValue="name" noSelection="${['':'Select Client']}"></g:select>
      
        <input type="text" name="keyword" title="keyword" value="${keyword}">
        &nbsp;<input type="submit" value="search">
        </form></div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                           
                            <g:sortableColumn property="projectNo" title="${message(code: 'project.projectNo.label', default: 'Project No')}" />
                            <g:sortableColumn property="customer" title="${message(code: 'project.customer.label', default: 'customer')}" />
                        
                            <g:sortableColumn property="deadline" title="${message(code: 'project.deadline.label', default: 'Deadline')}" />
                         
						    <g:sortableColumn property="state" title="${message(code: 'project.state.label', default: 'State')}" /> 
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'} " title="${projectInstance?.state}">
                            
                            <td><g:link action="show" id="${projectInstance.id}"  >
                            <g:if test="${projectInstance.test}">
                                CS
                            </g:if>
                            <g:else>
                              <g:if test="${projectInstance.global}">
                                GJ
                              </g:if>
                              <g:else>
                                GN
                              </g:else>
                            </g:else>
                            ${fieldValue(bean: projectInstance, field: "projectNo")}</g:link> 
							</td>

							<td>   ${fieldValue(bean: projectInstance, field: "customer")}  </td>
                        
                            <td><g:formatDate date="${projectInstance.start}" /><br>
                            <g:formatDate date="${projectInstance.deadline}" /></td> 
                             

							<td>${fieldValue(bean: projectInstance, field: "state")} <br>
                            <g:ifNotGranted role="ROLE_SALES">
                            <g:if test="${projectInstance.state == 'finished'}"> 
                                <g:link action="invoice" id="${projectInstance.id}">Send Invoice</g:link> |
                                <g:link action="paid" id="${projectInstance?.id}">Paid</g:link>
                            </g:if>
                            <g:else>
                                <g:if test="${projectInstance.state != 'paid'}">
                                    <g:link action="finished" id="${projectInstance.id}">check finish</g:link>
                                </g:if>
                            </g:else>
                            </g:ifNotGranted >
                            </td>

							<td>
							matchs:${projectInstance?.matchs?.size()} <br>
							task:${projectInstance?.task?.size()}  <br>
							dtp:${projectInstance?.dtp?.size()}  <br>
                            </td>
                            <td>
                            <g:ifNotGranted role="ROLE_SALES">
                                <g:link uri="/project/pdf/${projectInstance?.id}" target="_blank">view invoice</g:link>  
                            </g:ifNotGranted >
 							</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${projectInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
