

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
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
            <div class="search"><form method=post action="search">
                <input type="text" name="keyword" title="keyword" value="${keyword}">&nbsp;<input type="submit" value="search">
            </form></div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="name" title="${message(code: 'customer.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="country" title="${message(code: 'customer.country.label', default: 'Country')}" />
                        
                            <g:sortableColumn property="contact" title="${message(code: 'customer.contact.label', default: 'Contact')}" />
                        
                            <g:sortableColumn property="tel" title="${message(code: 'customer.tel.label', default: 'Tel')}" />
                        
                            <g:sortableColumn property="fax" title="${message(code: 'customer.fax.label', default: 'Fax')}" />
							<th>Pricing</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "country")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "contact")}
							${customerInstance?.mails}
							</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "tel")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "fax")}</td>
							<td>
							 <!-- g: each in="${customerInstance?.quote}" var="p" 
								${p}<br>
							   /g :each -->
							 <g:link controller="pricing" action="create" params="[pid : customerInstance?.id,parentType:'customer']">Add Pricing</g:link>
							 <g:link controller="pricing" action="list" params="[pid : customerInstance?.id,parentType:'customer']">Manage Pricing</g:link>
							 </td>
							</tr>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
