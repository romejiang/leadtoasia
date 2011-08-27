

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
                        
                            <g:sortableColumn property="deliveryDate" title="${message(code: 'projectOrder.deliveryDate.label', default: 'deliveryDate')}" /> 
                            
                            <g:sortableColumn property="total" title="${message(code: 'projectOrder.total.label', default: 'total')}" /> 
                        
                            <g:sortableColumn property="state" title="${message(code: 'projectOrder.state.label', default: 'State')}" />
                           <g:if test="${params.state == 'invoice'}">
                            <th></th>
                            </g:if>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectOrderInstanceList}" status="i" var="projectOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link controller="project" action="show" id="${projectOrderInstance?.project?.id}">
                            ${projectOrderInstance?.vendor}<br>
                            ${fieldValue(bean: projectOrderInstance, field: "project")} </g:link></td>
                        
 
                            <td>${fieldValue(bean: projectOrderInstance, field: "serviceType")}</td>
                        
                            <td><g:formatDate date="${projectOrderInstance?.start}" />--<g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
                          
                            <td>${fieldValue(bean: projectOrderInstance, field: "total")}</td>

                            <td>${fieldValue(bean: projectOrderInstance, field: "state")}</td>

                            <g:if test="${params.state == 'invoice'}">
                            <td> 
                            <g:link   action="paidOrder" id="${projectOrderInstance.id}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">支付</g:link> 
                            </td> 
                            </g:if>
                        
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
