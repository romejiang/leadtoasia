

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'exchangeRate.label', default: 'ExchangeRate')}" />
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
                        
                            <g:sortableColumn property="currency" title="${message(code: 'exchangeRate.currency.label', default: 'Currency')}" />
                        
                            <g:sortableColumn property="target" title="${message(code: 'exchangeRate.target.label', default: 'Target')}" />
                        
                            <g:sortableColumn property="rate" title="${message(code: 'exchangeRate.rate.label', default: 'Rate')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${exchangeRateInstanceList}" status="i" var="exchangeRateInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${exchangeRateInstance.id}">${fieldValue(bean: exchangeRateInstance, field: "currency")}</g:link></td>
                        
                            <td>${fieldValue(bean: exchangeRateInstance, field: "target")}</td>
                        
                            <td>${fieldValue(bean: exchangeRateInstance, field: "rate")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${exchangeRateInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
