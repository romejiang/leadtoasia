

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:javascript src="jquery/jquery-jtemplates.js" > </g:javascript>		
		<g:javascript src="projectOrder.js" />
    </head>
    <body>
        <div class="nav">
       </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projectOrderInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectOrderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${projectOrderInstance?.id}" />
                <g:hiddenField name="version" value="${projectOrderInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="project"><g:message code="projectOrder.project.label" default="Project" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'project', 'errors')}">
                                    ${projectOrderInstance?.project}
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vendor"><g:message code="projectOrder.vendor.label" default="Vendor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'vendor', 'errors')}">
                                      ${projectOrderInstance?.vendor}
                                </td>
                            </tr>
                         
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="matchs"><g:message code="project.match.label" default="Matchs" /></label>
                                </td>
                                <td valign="top" class="value"> 
                                    <g:set var="totalwords" value="${0}" />

									 <g:each in="${projectOrderInstance?.matchs}" var="m">
                                     ${m.wordcount} words Match ${m.match}, so <input type="text" name="discount" value="${m.discount}" class="discount" size="4">% discount
                                     <input type="hidden" name="matchid" value="${m.id}">
                                      <div class="matchdiscount" style="display: none">${m.discount}</div>
                                      <div class="matchwordcount" style="display: none">${m.wordcount}</div>
                                      <br>
                                      <g:set var="totalwords" value="${totalwords + m.wordcount}" />
                                     </g:each>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="serviceType"><g:message code="projectOrder.serviceType.label" default="Service Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'serviceType', 'errors')}">
                                    <g:lookupSelect  name="serviceType" realm="Service Type"
								 value="${projectOrderInstance.serviceType}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="paymentSort"><g:message code="projectOrder.paymentSort.label" default="Payment Sort" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'paymentSort', 'errors')}">
                                    <g:lookupSelect  name="paymentSort" realm="Payment Sort"
								 value="${projectOrderInstance.paymentSort}"/>
                                </td>
                            </tr>



                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="projectOrder.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'type', 'errors')}">
                                    <g:select name="type" from="${projectOrderInstance.constraints.type.inList}" value="${projectOrderInstance?.type}" valueMessagePrefix="projectOrder.type"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="wordcount"><g:message code="projectOrder.wordcount.label" default="Wordcount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'wordcount', 'errors')}">
                                    <g:textField name="wordcount" value="${fieldValue(bean: projectOrderInstance, field: 'wordcount')}" />
                                </td>
                            </tr>
                                   
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="rate"><g:message code="projectOrder.rate.label" default="Rate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'rate', 'errors')}">
                                    <g:textField name="rate" value="${fieldValue(bean: projectOrderInstance, field: 'rate')}" /><g:lookupSelect  name="unit" realm="Monetary Unit"
								 value="${projectOrderInstance.unit}"/>
                                </td>
                            </tr>

                                                    
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="total"><g:message code="projectOrder.total.label" default="Total" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'total', 'errors')}">
                                    <g:textField name="total" value="${fieldValue(bean: projectOrderInstance, field: 'total')}" />
                                    <input type="button" id="sum" value="计算总字数">
                                    <input type="button" id="calculate" value="计算总价">
                                </td>
                            </tr>
                        
                         
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="paymentTerms"><g:message code="projectOrder.paymentTerms.label" default="Payment Terms" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'paymentTerms', 'errors')}">
                                    <g:textField name="paymentTerms" maxlength="250" value="${projectOrderInstance?.paymentTerms}" />
                                </td>
                            </tr>
                                     
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="start"><g:message code="projectOrder.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'start', 'errors')}">
                                    <g:formatDate date="${projectOrderInstance?.start}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deliveryDate"><g:message code="projectOrder.deliveryDate.label" default="Delivery Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'deliveryDate', 'errors')}">
                                    <g:datePicker name="deliveryDate" precision="day" value="${projectOrderInstance?.deliveryDate}"  />
                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="requirement"><g:message code="projectOrder.requirement.label" default="Requirement" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'requirement', 'errors')}">
                                    <g:textArea name="requirement" cols="40" rows="5" value="${projectOrderInstance?.requirement}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="state"><g:message code="projectOrder.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'state', 'errors')}">
                                    ${projectOrderInstance?.state}
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
