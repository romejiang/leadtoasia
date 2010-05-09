

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create" params="[pid : pid,parentType : parentType]"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                        
                            <g:sortableColumn property="source" title="${message(code: 'pricing.source.label', default: 'Source And Target')}" />
                         
                        
                            <g:sortableColumn property="type" title="${message(code: 'pricing.type.label', default: 'Type')}" />
                        
                            <g:sortableColumn property="unit" title="${message(code: 'pricing.unit.label', default: 'Unit')}" />
                        
                            <g:sortableColumn property="price" title="${message(code: 'pricing.price.label', default: 'Price')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pricingInstanceList}" status="i" var="pricingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${pricingInstance.id}" params="[pid: pid , parentType : parentType]">${fieldValue(bean: pricingInstance, field: "source")} - ${fieldValue(bean: pricingInstance, field: "target")}</g:link></td>
                         
                            <td>${fieldValue(bean: pricingInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: pricingInstance, field: "unit")}</td>
                        
                            <td>${fieldValue(bean: pricingInstance, field: "price")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                 
            </div>
        </div>
    </body>
</html>
