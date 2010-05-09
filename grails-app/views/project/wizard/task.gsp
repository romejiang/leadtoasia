

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript src="jquery/jquery-jtemplates.js" > </g:javascript>		
		<g:javascript src="flowTask.js" ></g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
           <h1>Task</h1>
             
            <g:form action="wizard" method="post" >
            <input type="hidden" name="cid" id="cid" value="${projectInstance?.customer?.id}">
                <div class="buttons">
                    <span class="button"><g:submitButton name="previous" class="previous" value="previous" /></span>
                    <span class="button"><g:submitButton name="next" class="next" value="next" /></span>
                    </div>

                 <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="source"><g:message code="localization.source.label" default="Source" />:</label>
                                </td>
                                <td valign="top" colspan=5 class="value ${hasErrors(bean: localizationInstance, field: 'source', 'errors')}">
                            
									<g:lookupSelect  name="source" class="taskSource" realm="Language"
								 value="${source}"/>
                                </td>
                            </tr>
                            <g:each in="${localizationInstanceList}" var="localizationInstance" status="i">
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="target"><g:message code="localization.target.label" default="Target" />:</label>
                                </td>
                                <td valign="top" >
									${localizationInstance.target}
                                    <input type="hidden" class="taskTarget" name="target" value="${localizationInstance.target}"  index="${i}">
                                </td>
                         
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="localization.type.label" default="Type" />:</label>
                                </td>
                                <td valign="top" > 
<g:select name="type" class="taskType" index="${i}" from="${localizationInstance.constraints.type.inList}" value="${localizationInstance.type}"
          noSelection="['':'-Choose your age-']"/>
                                </td>
                       
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="localization.price.label" default="Price" />:</label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="price" class="taskPrice" size="10" style="width:50px" value="${fieldValue(bean: localizationInstance, field: 'price')}" />
                                    <g:lookupSelect  name="unit" realm="Monetary Unit"
								 value="${localizationInstance.unit}" class="taskUnit"/>
                                </td>
                            </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="previous" class="previous" value="previous" /></span>
                    <span class="button"><g:submitButton name="next" class="next" value="next" /></span>
                    </div>
            </g:form>
        </div>
    </body>
</html>
