

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="industry.list" default="Industry List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="industry.new" default="New Industry" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="industry.list" default="Industry List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="industry.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="industry.name" />
                        
                   	    <g:sortableColumn property="enname" title="Enname" titleKey="industry.enname" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${industryInstanceList}" status="i" var="industryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${industryInstance.id}">${fieldValue(bean: industryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: industryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: industryInstance, field: "enname")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${industryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
