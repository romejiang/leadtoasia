

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
         
            <div class="list">
                <table>
                    <thead>
                        <tr>
                           
                            <g:sortableColumn property="projectNo" title="${message(code: 'project.projectNo.label', default: 'Project No')}" />
                            <g:sortableColumn property="customer" title="${message(code: 'project.customer.label', default: 'customer')}" />
                        
                            <g:sortableColumn property="deadline" title="${message(code: 'project.deadline.label', default: 'Deadline')}" />
                         
						    <g:sortableColumn property="state" title="${message(code: 'project.state.label', default: 'State')}" /> 
                   
                             <g:sortableColumn property="state" title="${message(code: 'project.manager.label', default: 'Manager')}" /> 
                     
                            <th></th>
                           <g:if test="${params.state == 'invoice'}">
                            <th></th>
                            </g:if>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'} " title="${projectInstance?.state}">
                            
                            <td>
                          
                                ${fieldValue(bean: projectInstance, field: "projectNo")} 
						 
                            </td>

							<td> ${fieldValue(bean: projectInstance, field: "customer")}  </td>
                        
                            <td><g:formatDate date="${projectInstance.start}" /><br>
                            <g:formatDate date="${projectInstance.deadline}" /></td> 
                             

							<td>${fieldValue(bean: projectInstance, field: "state")} <br>
                             
                            </td>
                         
                             <td>${projectInstance?.manager}</td>
                          
							<td>
                       
							matchs:${projectInstance?.matchs?.size()} <br>
							task:${projectInstance?.task?.size()}  <br>
							dtp:${projectInstance?.dtp?.size()}  <br>
                            
                             总字数 : ${projectInstance?.matchs?.wordcount.sum()}<br>
 
                            </td>
                            <g:if test="${params.state == 'invoice'}">
                             <td>
                                <g:link action="paid" id="${projectInstance?.id}" params="[callback: 'internal']"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">支付</g:link>  
                             </td>
                           </g:if>
 						
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
