

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pricingInstance}">
            <div class="errors">
                <g:renderErrors bean="${pricingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${pricingInstance?.id}" />
                <g:hiddenField name="version" value="${pricingInstance?.version}" />
				<g:hiddenField name="pid" value="${pid}" />
				<g:hiddenField name="parentType" value="${parentType}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="source"><g:message code="pricing.source.label" default="Source" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pricingInstance, field: 'source', 'errors')}">
                                   <g:lookupSelect  name="source" realm="Language"
								 value="${pricingInstance.source}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="target"><g:message code="pricing.target.label" default="Target" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pricingInstance, field: 'target', 'errors')}">
                                    <g:lookupSelect  name="target" realm="Language"
								 value="${pricingInstance.target}"/>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="pricing.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pricingInstance, field: 'type', 'errors')}">
<g:radioGroup name="type" values="${pricingInstance.constraints.type.inList}" 
labels="${pricingInstance.constraints.type.inList}"  value="${pricingInstance?.type}" >
${it.radio}:${it.label}&nbsp;
</g:radioGroup>
                                </td>
                            </tr>
                       
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="pricing.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pricingInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: pricingInstance, field: 'price')}" /><g:lookupSelect  name="unit" realm="Monetary Unit"
								 value="${pricingInstance.unit}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
