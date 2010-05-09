

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Add new service</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pricingInstance}">
            <div class="errors">
                <g:renderErrors bean="${pricingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
								 value="${pricingInstance?.source}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="target"><g:message code="pricing.target.label" default="Target" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pricingInstance, field: 'target', 'errors')}">
									<g:lookupSelect  name="target" realm="Language"
								 value="${pricingInstance?.target}"/>
								 </td>
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
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
