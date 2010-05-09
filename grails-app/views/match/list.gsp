

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'match.label', default: 'Match')}" />
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
                        
                            <g:sortableColumn property="wordcount" title="${message(code: 'match.wordcount.label', default: 'Wordcount')}" />
                        
                            <g:sortableColumn property="match" title="${message(code: 'match.match.label', default: 'Match')}" />
                        
                            <g:sortableColumn property="discount" title="${message(code: 'match.discount.label', default: 'Discount')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${matchInstanceList}" status="i" var="matchInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${matchInstance.id}"  params="[pid : pid,parentType:'project']">${fieldValue(bean: matchInstance, field: "wordcount")}</g:link></td>
                        
                            <td>${fieldValue(bean: matchInstance, field: "match")}</td>
                        
                            <td>${fieldValue(bean: matchInstance, field: "discount")}</td>
                        
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
