

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'localization.label', default: 'Localization')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
              </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.source.label" default="Source" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "source")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.target.label" default="Target" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "target")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "type")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.unit.label" default="Unit" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "unit")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.price.label" default="Price" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "price")}</td>
                            
                        </tr> 

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="localization.amount.label" default="amount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: localizationInstance, field: "amount")}</td>
                            
                        </tr> 
                    </tbody>
                </table>
            </div>
            <div class="buttons">
              <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN,ROLE_SALES_DIRECTOR">
                <g:form>
                    <g:hiddenField name="id" value="${localizationInstance?.id}" />
                    <g:hiddenField name="parentType" value="${params.parentType}" />
					<input type="hidden" name="pid" value="${pid}">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
                </g:ifAnyGranted>
            </div>
        </div>
    </body>
</html>
