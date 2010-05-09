

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
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
                            <td valign="top" class="name"><g:message code="projectOrder.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.vendor.label" default="Vendor" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${projectOrderInstance?.vendor?.id}">${projectOrderInstance?.vendor?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.quote.label" default="Quote" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${Localization.findAllByProjectOrder(projectOrderInstance)}" var="q">
                                    <li><g:link controller="localization" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.serviceType.label" default="Service Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "serviceType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.total.label" default="Total" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "total")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.paymentSort.label" default="Payment Sort" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "paymentSort")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.rate.label" default="Rate" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "rate")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.wordcount.label" default="Wordcount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "wordcount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "type")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.unit.label" default="Unit" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "unit")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.paymentTerms.label" default="Payment Terms" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "paymentTerms")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.start.label" default="Start" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${projectOrderInstance?.start}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.deliveryDate.label" default="Delivery Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.project.label" default="Project" /></td>
                            
                            <td valign="top" class="value"><g:link controller="project" action="show" id="${projectOrderInstance?.project?.id}">${projectOrderInstance?.project?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.requirement.label" default="Requirement" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "requirement")}</td>
                            
                        </tr>

						<tr class="prop">
                            <td valign="top" class="name">Attachments</td>
                            
                            <td valign="top" class="value"> 
								<ul>
								<g:each in="${projectOrderInstance?.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="complete"
									errorController="my">${f.name}</fileuploader:download>
									</li>
                                </g:each>
								</ul>
							</td>
                            
                        </tr>
                    <g:if test="${projectOrderInstance?.state == 'new' }">
                        <tr class="prop">
                            <td valign="top" class="name">Notice</td>
                            <td valign="top" class="value"> 
								<g:link  action="notice" id="${projectOrderInstance?.id}" onclick="this.disabled = true;\$('#spinner').show(); ">Notice Now</g:link>
							</td>
                        </tr> 
                    </g:if>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${projectOrderInstance?.id}" />
                    <g:if test="${projectOrderInstance?.state == 'new'}">
					<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:if>

					<g:if test="${projectOrderInstance?.state == 'submit' }">
					<span class="button"><g:actionSubmit class="edit" action="processing" value="Back" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
					<span class="button"><g:actionSubmit class="edit" action="pass" value="Pass" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
					</g:if>

					<g:if test="${projectOrderInstance?.state == 'invoice'}">
					  <span class="button"><g:actionSubmit class="edit" action="finished" value="finished" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
					 </g:if>

                </g:form>
            </div>
        </div>
    </body>
</html>
