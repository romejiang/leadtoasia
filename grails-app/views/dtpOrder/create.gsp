

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript src="jquery/jquery-jtemplates.js" > </g:javascript>		
		<g:javascript src="dtpOrder.js" />
    </head>
    <body>
        <div class="nav">
       </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projectOrderInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectOrderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" > 
            <input type="hidden" name="project.id" id="project.id" value="${projectOrderInstance.project?.id}">
            <input type="hidden" name="localization.id" value="${projectOrderInstance.localization?.id}"/>

                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label ><g:message code="projectOrder.localize.label" default="Localize" /></label>
                                </td>
                                <td valign="top" class="value " >
                                  ${projectOrderInstance.localization} 
                                </td>
                            </tr>
                        
												
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vendor"><g:message code="projectOrder.vendor.label" default="Vendor" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'vendor', 'errors')}">
								<g:select name="vendor.id" class="userSelected"
                              from="${User.findAllByEnabled(true)}"
                              value="${projectOrderInstance?.vendor?.id}"
                              noSelection="${['':'- Choose Vendor -']}"
                              optionKey="id" />
                                </td>
                            </tr>
 
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="serviceType"><g:message code="projectOrder.serviceType.label" default="Service Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'serviceType', 'errors')}"> 
									<input type="hidden" name="serviceType" value="DTP">桌面排版
                                </td>
                            </tr>
      
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="projectOrder.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'wordcount', 'errors')}">
                                    <g:textField name="wordcount" value="${projectOrderInstance.localization?.amount}" /><g:select name="type" from="${projectOrderInstance.constraints.type.inList}" value="${projectOrderInstance.localization?.type}" valueMessagePrefix="projectOrder.type"  />
                                </td>
                            </tr>

                          
                            <tr class="prop outside">
                                <td valign="top" class="name">
                                    <label for="rate"><g:message code="projectOrder.rate.label" default="Rate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'rate', 'errors')}">
                                    <g:textField name="rate" value="${fieldValue(bean: projectOrderInstance, field: 'rate')}" /><g:lookupSelect  name="unit" realm="Monetary Unit"
								 value="${projectOrderInstance.unit}"/>
                                </td>
                            </tr>
 
                   
                            <tr class="prop outside">
                                <td valign="top" class="name">
                                    <label for="total"><g:message code="projectOrder.total.label" default="Total" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'total', 'errors')}">
                                    <g:textField name="total" value="${fieldValue(bean: projectOrderInstance, field: 'total')}" /><input type="button" id="calculate" value="calculate">
                                </td>
                            </tr>
                                                
                        <tr class="prop outside">
                                <td valign="top" class="name">
                                    <label for="paymentSort"><g:message code="projectOrder.paymentSort.label" default="Payment Sort" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'paymentSort', 'errors')}">
                                    <g:lookupSelect  name="paymentSort" realm="Payment Sort"
								 value="${projectOrderInstance.paymentSort}"/>
                                </td>
                            </tr>
                         
                            <tr class="prop outside">
                                <td valign="top" class="name">
                                    <label for="paymentTerms"><g:message code="projectOrder.paymentTerms.label" default="Payment Terms" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectOrderInstance, field: 'paymentTerms', 'errors')}">
                                    <g:textField name="paymentTerms" maxlength="250" value="${projectOrderInstance?.paymentTerms}" /> 天（提交发票后）
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
<textarea id="jtemplate" style="display:none">
<select name="vendor.id" id="vendor.id" class="userSelected" >
<option value="" >- 选择译者 -</option>
{#foreach $T as n} 
<option value="{$T.n.id}" >{$T.n.username} {#if $T.n.fullTime} &#60; {#else} &#62; {#/if} </option>
{#/for}  
</select>
</textarea>
		</div>

    </body>
</html>
