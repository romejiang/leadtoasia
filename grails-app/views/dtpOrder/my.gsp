

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="projectOrder.list" default="ProjectOrder List" /></title>
    </head>
    <body>
        <div class="nav">
        </div>
        <div class="body">
            <h1><g:message code="projectOrder.list" default="ProjectOrder List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="projectOrder.id" />
                        
                   	    <th><g:message code="projectOrder.sourceAndTarget" default="Source And Target" /></th>
                   	    
                   	    <th><g:message code="projectOrder.user" default="User" /></th>
                   	    
                   	    <g:sortableColumn property="workload" title="Workload" titleKey="projectOrder.workload" />
                        
                   	    <g:sortableColumn property="requirement" title="Requirement" titleKey="projectOrder.requirement" />
                        
                   	    <g:sortableColumn property="deadline" title="Deadline" titleKey="projectOrder.deadline" />
                        <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectOrderInstanceList}" status="i" var="projectOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projectOrderInstance.id}">${projectOrderInstance.project}</g:link></td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "sourceAndTarget")}</td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "user")}</td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "workload")}</td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "requirement")}</td>
                        
                            <td><g:formatDate date="${projectOrderInstance.deadline}"   /></td>
                            <td>
							${projectOrderInstance.state}
							<g:if test="${projectOrderInstance.state == 'open'}">
										<br><g:link action="activating"  id="${projectOrderInstance.id}">领取任务</g:link>
							</g:if>
							<g:if test="${projectOrderInstance.state == 'processing'}">
										<br><g:link action="complete"  id="${projectOrderInstance.id}">完成任务</g:link>
							</g:if>					 
							</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${projectOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
