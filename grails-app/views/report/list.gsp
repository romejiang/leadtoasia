

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
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
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <th><g:message code="report.project.label" default="Project" /></th>
                   	    
                            <g:sortableColumn property="income" title="${message(code: 'report.income.label', default: 'Income')}" />
                        
                            <g:sortableColumn property="expenses" title="${message(code: 'report.expenses.label', default: 'Expenses')}" />
                        
                            <g:sortableColumn property="profit" title="${message(code: 'report.profit.label', default: 'Profit')}" />
                        
                            <g:sortableColumn property="start" title="${message(code: 'report.start.label', default: 'Start')}" />
                        
                            <g:sortableColumn property="deadline" title="${message(code: 'report.deadline.label', default: 'Deadline')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${reportInstanceList}" status="i" var="reportInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${reportInstance.id}">${fieldValue(bean: reportInstance, field: "project")}</g:link></td>
                        
                            <td>${fieldValue(bean: reportInstance, field: "income")}</td>
                        
                            <td>${fieldValue(bean: reportInstance, field: "expenses")}</td>
                        
                            <td>${fieldValue(bean: reportInstance, field: "profit")}</td>
                        
                            <td><g:formatDate date="${reportInstance.start}" /></td>
                        
                            <td><g:formatDate date="${reportInstance.deadline}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${reportInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
