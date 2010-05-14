

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'localization.label', default: 'Localization')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:javascript src="jquery/jquery-jtemplates.js" > </g:javascript>		
		<g:javascript src="localization.js" ></g:javascript>
	</head>
    <body>
        <div class="nav">
           
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${localizationInstance}">
            <div class="errors">
                <g:renderErrors bean="${localizationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${localizationInstance?.id}" />
                <g:hiddenField name="version" value="${localizationInstance?.version}" />
                <g:hiddenField name="parentType" value="${params.parentType}" />

				<input type="hidden" name="pid"  id="pid" value="${pid}">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="source"><g:message code="localization.source.label" default="Source" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'source', 'errors')}">
                                     ${localizationInstance?.source} 
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="target"><g:message code="localization.target.label" default="Target" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'target', 'errors')}">
                                     ${localizationInstance?.target} 
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="localization.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'type', 'errors')}">
<g:radioGroup name="type" values="${localizationInstance.constraints.type.inList}" 
labels="${localizationInstance.constraints.type.inList}"  value="${localizationInstance.type}" >
${it.radio}:${it.label}&nbsp;
</g:radioGroup>
                                </td>
                            </tr>
                         
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="price"><g:message code="localization.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: localizationInstance, field: 'price')}" /><g:lookupSelect  name="unit" realm="Monetary Unit"
								 value="${localizationInstance.unit}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="localization.amount.label" default="amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: localizationInstance, field: 'amount')}" /> 
                                </td>
                            </tr>
                          
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                <g:if test="${!localizationInstance.projectOrder}"> 
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:if>
                </div>
            </g:form>
			 <table>
            <tr>
                <td>
                <div class="pricing">
			        &nbsp;
			    </div>
                </td>
            </tr>
            </table>
			<textarea id="jtemplate" style="display:none">
			<ol>
			{#foreach $T as n} 
			<li class='pricingInstance' id='pricing{$T.n.id}' ptype="{$T.n.type}" unit="{$T.n.unit}" price="{$T.n.price}" >
			{$T.n.source}  - {$T.n.target}   {$T.n.price}  {$T.n.unit}   per  {$T.n.type} 
			</li>
			{#/for}  
			</ol>
			</textarea>
        </div>
    </body>
</html>
