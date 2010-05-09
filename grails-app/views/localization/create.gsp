

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'localization.label', default: 'Localization')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript src="jquery/jquery-jtemplates.js" > </g:javascript>		
		<g:javascript src="localization.js" ></g:javascript>
    </head>
    <body>
        <div class="nav">
      
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${localizationInstance}">
            <div class="errors">
                <g:renderErrors bean="${localizationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
			<input type="hidden" name="pid" id="pid" value="${pid}">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="source"><g:message code="localization.source.label" default="Source" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'source', 'errors')}">
                            
									<g:lookupSelect  name="source" realm="Language"
								 value="${localizationInstance?.source}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="target"><g:message code="localization.target.label" default="Target" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: localizationInstance, field: 'target', 'errors')}">
                                
									<g:lookupSelect  name="target" realm="Language"
								 value="${localizationInstance?.target}"/>
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
                         
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
			<div class="pricing">
			
			</div>
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
