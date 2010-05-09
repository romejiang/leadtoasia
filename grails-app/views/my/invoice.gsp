

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
                            <td valign="top" class="name"><g:message code="projectOrder.project.label" default="Project" /></td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.encodeAsHTML()}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Source And Target</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${Localization.findAllByProjectOrder(projectOrderInstance)}" var="q">
                                    <li>${q?.encodeAsHTML()}</li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.serviceType.label" default="Service Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "serviceType")}</td>
                            
                        </tr>
                      
                          <tr class="prop">
                                <td valign="top" class="name">
                                      <g:message code="project.match.label" default="Matchs" /> 
                                </td>
                                <td valign="top" class="value"> 
 
									 <g:each in="${projectOrderInstance?.matchs}" var="m">
                                        ${m.wordcount} words Match ${m.match}, so  ${m.discount}% discount<br>
                                       
                                      </g:each>
                                </td>
                            </tr>
                     
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.wordcount.label" default="Wordcount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "wordcount")}</td>
                            
                        </tr>
                     <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.rate.label" default="Wordcount" /></td>
                            
                            <td valign="top" class="value">${new java.text.DecimalFormat("#0.00").format(projectOrderInstance?.rate)} ${projectOrderInstance.unit}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.deliveryDate.label" default="Delivery Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${projectOrderInstance?.start}" /> -- <g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.requirement.label" default="Requirement" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "requirement")}</td>
                            
                        </tr>
                    
					     <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.pm.label" default="PM" /></td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.userRealName}</td>
                            
                        </tr>
					 

						 
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                 <g:form>
                    <g:hiddenField name="id" value="${projectOrderInstance?.id}" /> 
                    <span class="button"><g:actionSubmit class="edit" action="invoiced" value="invoiced"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                 </g:form>
            </div>
        </div>
    </body>
</html>
