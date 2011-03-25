

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'cupertino/jquery-ui-1.8.custom.css')}" />
        <g:javascript src="jquery/jquery-jtemplates.js" />
        <g:javascript src="jquery/jquery-ui-1.8.custom.min.js"/>
		<g:javascript src="flowTask.js"  />
 		<g:javascript src="enterEvent.js"  />


    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
           <h1>Task</h1>
             <g:render template="navigate_cn" model="['number':2]" />
             
            <g:form action="quote" method="post" >

            <input type="hidden" name="matchCount" id="matchCount" value="${matchCount}">
            <input type="hidden" name="cid" id="cid" value="${projectInstance?.customer?.id}">
                <div class="buttons">
                    <span class="button"><g:submitButton name="previous" class="previous" value="previous" /></span>
                    <span class="button"><g:submitButton name="next" class="next" value="next" /></span>
               </div>

                 <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top"  >
                                    <label for="source"><g:message code="localization.source.label" default="Source" />:</label>
                                </td>
                                <td valign="top" colspan=5  >
                            
									<g:lookupSelect  name="source" class="taskSource" realm="Language"
								 value="${source}"/>
                                 </td>
                                <td valign="top" colspan=2 >
                             
                                 <input type="button" name="addLocalization" class="addLocalization" id="addLocalization" value="Add Localization"  />
                                </td>
                            </tr>
                            <g:each in="${localizationInstanceList}" var="localizationInstance" status="i">
                            
                            <tr id="tr_${localizationInstance.target.replace(' ','')}" class="${localizationInstance.price ? '' : 'hide'}">
                                <td valign="top" >
                                    <label for="target"><g:message code="localization.target.label" default="Target" />:</label>
                                </td>
                                <td valign="top" >
									${localizationInstance.target}
                                    <input type="hidden" class="taskTarget" name="target" value="${localizationInstance.target}"  index="${i}">
                                </td>
                         
                                <td valign="top" >
                                    <label for="type"><g:message code="localization.type.label" default="Type" />:</label>
                                </td>
                                <td valign="top" > 
<g:select name="type" class="taskType" index="${i}" from="${localizationInstance.constraints.type.inList}" value="${localizationInstance.type}"
          noSelection="['':'-Choose your age-']"/>
                                </td>
                       
                                <td valign="top" >
                                    <label for="price"><g:message code="localization.price.label" default="Price" />:</label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="price" class="taskPrice" size="10" style="width:50px" value="${fieldValue(bean: localizationInstance, field: 'price')}" />
                                    <g:lookupSelect  name="unit" realm="Monetary Unit"
								 value="${localizationInstance.unit}" class="taskUnit"/>
                                </td>
                                <td valign="top" >
                                    <label for="amount"><g:message code="localization.amount.label" default="Amount" />:</label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="amount" class="taskAmount" size="10" style="width:50px" value="${fieldValue(bean: localizationInstance, field: 'amount')}" />
                                    
                                </td>
                            </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="previous" class="previous" value="上一步" /></span>
                    <span class="button"><g:submitButton name="next" class="next" value="下一步" /></span>
                    </div>
            </g:form>
        </div>

        <div id="dialog-select" class="hide" title="select localization">
        <ul  style="text-align:left">
        <g:each in="${localizationInstanceList}" var="localizationInstance" status="i">
            <li><input type="checkbox" name="selectLocalization" class="selectLocalization" ${localizationInstance.price ? 'checked' : ''} value="${localizationInstance.target.replace(' ','')}">${localizationInstance.target} 
        </g:each>
        </ul>
        </div>
    </body>
</html>
