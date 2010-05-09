

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'localization.label', default: 'Localization')}" />
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
                        
                            <g:sortableColumn property="source" title="${message(code: 'localization.source.label', default: 'Source')}" />
                        
                            <g:sortableColumn property="target" title="${message(code: 'localization.target.label', default: 'Target')}" />
                        
                            <g:sortableColumn property="type" title="${message(code: 'localization.type.label', default: 'Type')}" />
                        
                            <g:sortableColumn property="unit" title="${message(code: 'localization.unit.label', default: 'Unit')}" />
                        
                            <g:sortableColumn property="price" title="${message(code: 'localization.price.label', default: 'Price')}" />
                        
                            <th><g:message code="localization.project.label" default="Project" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${localizationInstanceList}" status="i" var="localizationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${localizationInstance.id}" params="[pid : pid,parentType: parentType]">${fieldValue(bean: localizationInstance, field: "source")}</g:link></td>
                        
                            <td>${fieldValue(bean: localizationInstance, field: "target")}</td>
                        
                            <td>${fieldValue(bean: localizationInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: localizationInstance, field: "unit")}</td>
                        
                            <td>${fieldValue(bean: localizationInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: localizationInstance, field: "project")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${localizationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
