

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">主页</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="search">
            <g:ifAnyGranted role="ROLE_ADMIN,ROLE_MANAGER"> 
            <form method=post action="search">
                <input type="text" name="keyword" title="keyword" value="${keyword}">&nbsp;<input type="submit" value="search">
            </form>
             </g:ifAnyGranted>
            <g:ifAnyGranted role="ROLE_SALES_DIRECTOR">销售人员：
                <g:each in="${User.list()?.findAll(){it.authorities.contains(Role.findByAuthority('ROLE_SALES'))}}" var="user">
                    <g:link  action="list" params="[userid: user.id]">${user.userRealName}</g:link>&nbsp; |&nbsp;
                </g:each>
            </g:ifAnyGranted>
            </div>
            <div class="list">
                <table>
                    <thead> 
                        <tr>
                        
                            <g:sortableColumn property="name" title="${message(code: 'customer.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="country" title="${message(code: 'customer.country.label', default: 'Country')}" />
                        
                            <g:sortableColumn property="contact" title="${message(code: 'customer.contact.label', default: 'Contact')}" />
                        
                            <g:sortableColumn property="registrant" title="${message(code: 'customer.registrant.label', default: 'Registrant')}" />
                        
 							<th>${message(code: 'pricing.label', default: 'Pricing')}</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "country")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "contact")}<br>
							${customerInstance?.mails?.join("<br>")}<br>
                            <g:message code="customer.mobile.label" default="mobile" />:${fieldValue(bean: customerInstance, field: "mobile")}<br>
                            <g:message code="customer.tel.label" default="Tel" />:${fieldValue(bean: customerInstance, field: "tel")}<br>
                            <g:message code="customer.fax.label" default="Fax" />:${fieldValue(bean: customerInstance, field: "fax")}
							</td> 
                        
                            <td>${fieldValue(bean: customerInstance, field: "registrant")}</td>
							<td>
							 <!-- g: each in="${customerInstance?.quote}" var="p" 
								${p}<br>
							   /g :each -->
							 <g:link controller="pricing" action="create" params="[pid : customerInstance?.id,parentType:'customer']">
        <g:message code="default.new.label" args="[g.message(code:'pricing.label')]" />
        </g:link><br>
							 <g:link controller="pricing" action="list" params="[pid : customerInstance?.id,parentType:'customer']">
<g:message code="default.manage.label" args="[g.message(code:'pricing.label')]" />
</g:link>
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
