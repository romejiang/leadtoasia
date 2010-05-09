

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
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
                        
                            <th><g:message code="projectOrder.vendor.label" default="Vendor" /></th>
                   	    
                            <g:sortableColumn property="serviceType" title="${message(code: 'projectOrder.serviceType.label', default: 'Service Type')}" />
                        
                            <g:sortableColumn property="total" title="${message(code: 'projectOrder.total.label', default: 'deliveryDate')}" /> 
                        
                            <g:sortableColumn property="state" title="${message(code: 'projectOrder.state.label', default: 'State')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectOrderInstanceList}" status="i" var="projectOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projectOrderInstance.id}">${fieldValue(bean: projectOrderInstance, field: "vendor")} ${fieldValue(bean: projectOrderInstance, field: "project")} </g:link></td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "serviceType")}</td>
                        
                            <td><g:formatDate date="${projectOrderInstance?.start}" />--<g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
                          
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "state")}</td>
                        
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
