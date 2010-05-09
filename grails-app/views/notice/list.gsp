

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'notice.label', default: 'Notice')}" />
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
                        
                            <g:sortableColumn property="name" title="${message(code: 'notice.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'notice.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="content" title="${message(code: 'notice.content.label', default: 'Content')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${noticeInstanceList}" status="i" var="noticeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${noticeInstance.id}">${fieldValue(bean: noticeInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: noticeInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: noticeInstance, field: "content")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${noticeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
