

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
       
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                     
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.quote.label" default="Quote" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                     <li>${projectOrderInstance?.localization?.encodeAsHTML()}</li>
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
                            <td valign="top" class="name"><g:message code="projectOrder.invoiceDate.label" default="invoice Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${projectOrderInstance?.invoiceDate}" /></td>
                            
                        </tr>

                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.deliveryDate.label" default="Delivery Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.requirement.label" default="Requirement" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "requirement")}</td>
                            
                        </tr>
                    
					                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.pm.label" default="PM" /></td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.userRealName}</td>
                            
                        </tr>
						<tr class="prop">
                            <td valign="top" class="name">Mail</td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.email}</td>
                            
                        </tr>

						<tr class="prop">
                            <td valign="top" class="name">Tel</td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.tel}</td>
                            
                        </tr>
						<tr class="prop">
                            <td valign="top" class="name">Fax</td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.fax}</td>
                            
                        </tr>

						<tr class="prop"><a name="Source"></a>
                            <td valign="top" class="name">Project Source</td>
                            
                            <td valign="top" class="value">
                            <div class="warning">
							<g:each in="${projectOrderInstance?.project.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="index"
									errorController="my">${f.name}</fileuploader:download>
									</li>
                                </g:each>
                                </div>
							</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">To client</td>
                            
                            <td valign="top" class="value">
							<g:each in="${projectOrderInstance?.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="index"
									errorController="my">${f.name}</fileuploader:download>
&nbsp;&nbsp;&nbsp;&nbsp;
                                    <g:link controller="my" action="deleteAttachment" id="${f.id}" params="[POId : projectOrderInstance?.id , reaction : 'show']"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >[Delete Attachment]</g:link>
									</li>
                                </g:each>
							</td>
                            
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                 
            </div>
        </div>
    </body>
</html>
