

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
                            <td valign="top" class="name">源语言和目标语言</td>
                            
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
                            <td valign="top" class="name"><g:message code="projectOrder.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "state")}</td>
                            
                        </tr>
                     
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.wordcount.label" default="Wordcount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectOrderInstance, field: "wordcount")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.deliveryDate.label" default="Delivery Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${projectOrderInstance?.start}" /> -- <g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projectOrder.project.label" default="Project" /></td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.encodeAsHTML()}</td>
                            
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
                            <td valign="top" class="name">邮件</td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.email}</td>
                            
                        </tr>

						<tr class="prop">
                            <td valign="top" class="name">电话</td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.tel}</td>
                            
                        </tr>
						<tr class="prop">
                            <td valign="top" class="name">传真</td>
                            
                            <td valign="top" class="value">${projectOrderInstance?.project?.manager?.fax}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">源文件</td>
                            
                            <td valign="top" class="value"> 
								<ul>
								<g:each in="${projectOrderInstance?.project.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="index"
									errorController="my">${f.name}</fileuploader:download>
									</li>
                                </g:each>
								</ul>
							</td>
                            
                        </tr>

						<tr class="prop">
                            <td valign="top" class="name">完成文件</td>
                            
                            <td valign="top" class="value">
                            <div class="warning">
                           注意：<br>
                           上传文件必须为以下格式的文件： <g:each in="${grailsApplication.config.fileuploader.docs.allowedExtensions}" var="t">${t}, </g:each>
                           <br>文件大小上限为 ${new java.text.DecimalFormat("#0").format(grailsApplication.config.fileuploader.docs.maxSize /1000 / 1024)} Mb
                           </div>
                           <fileuploader:form 	upload="docs" 
								successAction="upload"
								successController="my"
								errorAction="upload"
								errorController="my">
								<input type="hidden" name="id" value="${projectOrderInstance?.id}" >
								</fileuploader:form>
								<ul>
								<g:each in="${projectOrderInstance?.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="complete"
									errorController="my">${f.name}</fileuploader:download>
&nbsp;&nbsp;&nbsp;&nbsp;
                                    <g:link controller="my" action="deleteAttachment" id="${f.id}" params="[POId : projectOrderInstance?.id , reaction : 'complete']"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >[Delete Attachment]</g:link>
									</li>
                                </g:each>
								</ul>
							</td>
                            
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                 <g:form>
                    <g:hiddenField name="id" value="${projectOrderInstance?.id}" />
				  
                    <span class="button"><g:actionSubmit class="edit" action="finished" value="Submit" 
                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                 </g:form>
            </div>
        </div>
    </body>
</html>
