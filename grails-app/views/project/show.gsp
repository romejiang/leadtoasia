

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top"   width="450" colspan="2" > </td>
                            
                       
                            <td valign="top"   width="450" colspan="2" > </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top"   class="name"><g:message code="project.projectNo.label" default="Project No" /></td>
                            
                            <td valign="top"  >${fieldValue(bean: projectInstance, field: "projectNo")}</td>
                            
                       
                            <td valign="top"  class="name"><g:message code="project.customer.label" default="Customer" /></td>
                            
                            <td valign="top" ><g:link controller="customer" action="show" id="${projectInstance?.customer?.id}">${projectInstance?.customer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.deadline.label" default="Deadline" /></td>
                            
                            <td valign="top" ><g:formatDate date="${projectInstance?.deadline}" /></td>
                     
                            <td valign="top"  class="name"><g:message code="project.start.label" default="Start" /></td>
                            
                            <td valign="top" ><g:formatDate date="${projectInstance?.start}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.state.label" default="State" /></td>
                            
                            <td valign="top" >${fieldValue(bean: projectInstance, field: "state")}</td>
                            
                      
                            <td valign="top"  class="name">Customer Project No</td>
                            
                            <td valign="top" >${projectInstance?.fromNo} </td>
                            
                        </tr>
                  
                    
                        <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.content.label" default="Content" /></td>
                            
                            <td valign="top" >${fieldValue(bean: projectInstance, field: "content")}</td>
                            
                      
                            <td valign="top"  class="name"><g:message code="project.user.label" default="Manager" /></td>
                            
                            <td valign="top" ><g:link controller="user" action="show" id="${projectInstance?.manager?.id}">${projectInstance?.manager.encodeAsHTML()}</g:link></td>
                            
                        </tr>  
                    
                 </tbody>
                </table>
				<table>
                    <tbody>	
                        <tr class="prop">
                            <td valign="top" ><g:message code="project.matchs.label" default="Matchs" /></td>
                            
                            <td valign="top" style="text-align: left;" >
                                <g:link controller="match" action="create" params="[pid : projectInstance.id,parentType:'project']">Add Match</g:link>
								<ul>
                                <g:each in="${projectInstance.matchs}" var="m">
                                    <li><g:link controller="match" action="show" id="${m.id}"  params="[pid : projectInstance.id,parentType:'project']">${m?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" ><g:message code="project.task.label" default="Task" /></td>
                            
                            <td valign="top" style="text-align: left;" >
							<g:link controller="localization" action="create" params="[pid : projectInstance.id,parentType:'project']">Add Localization</g:link>
                                <ul>
                                 <table> 
                                
                                <g:each in="${projectInstance?.task}" var="q">
                                   <tr>
                                    <td class="name"> 
                                    <g:link controller="localization" action="show" id="${q.id}"  params="[pid : projectInstance.id,parentType:'project']">${q?.encodeAsHTML()} </g:link>
                                    </td>
                                    <td><img src="${resource(dir:'images',file:'image_edit.png')}" border=0 alt="TEP">
									<g:if test="${q?.projectOrder}">
                                 
									<g:link controller="projectOrder" action="show" id="${q?.projectOrder?.id}"  params="[pid : projectInstance.id,parentType:'project']">${q?.projectOrder}</g:link>&nbsp;&nbsp;${q?.projectOrder?.state}
                                    
                                    <g:if test="${q?.projectOrder?.state ==  'new'}">
                                        <g:link  action="notice" controller="projectOrder" id="${q?.projectOrder?.id}" params="[pid: projectInstance.id]" onclick="this.disabled = true;\$('#spinner').show();">Notice Now</g:link>
                                    </g:if>
                                    
									</g:if>
									<g:else>
									  <g:link controller="projectOrder" action="create" params="[pid : projectInstance.id,parentType:'project']">Add PO</g:link>
									</g:else>
                                 
                                    

                                    </td>
									</tr>
                             
                                </g:each>   
                                </table>
                                </ul>
                            </td>
                        </tr>
           

         
                                 <tr class="prop">
                            <td valign="top" >DTP</td>
                            
                            <td valign="top" style="text-align: left;" >
							<g:link controller="dtp" action="create" params="[pid : projectInstance.id,parentType:'project']">Add DTP</g:link>
                                <ul>
                                 <table> 
                                
                                <g:each in="${projectInstance.dtp}" var="q">
                                   <tr>
                                    <td class="name"> 
                                    <g:link controller="dtp" action="show" id="${q.id}"  params="[pid : projectInstance.id,parentType:'project']">${q?.encodeAsHTML()} </g:link>
                                    </td>
                                    <td><img src="${resource(dir:'images',file:'layout_content.png')}" border=0 alt="TEP">
									<g:if test="${q?.projectOrder}">
                                 
									<g:link controller="dtpOrder" action="show" id="${q?.projectOrder?.id}"  params="[pid : projectInstance.id,parentType:'project']">${q?.projectOrder}</g:link>&nbsp;&nbsp;${q?.projectOrder?.state}
                                    
                                    <g:if test="${q?.projectOrder?.state ==  'new'}">
                                        <g:link  action="notice" controller="dtpOrder" id="${q?.projectOrder?.id}" params="[pid: projectInstance.id]" onclick="this.disabled = true;\$('#spinner').show();">Notice Now</g:link>
                                    </g:if>
                                    
									</g:if>
									<g:else>
									  <g:link controller="dtpOrder" action="create" params="[pid : projectInstance.id,parentType:'project']">Add DTP</g:link>
									</g:else>
                                  
                                    </td>
									</tr>
                             
                                </g:each>   
                                </table>
                                </ul>
                            </td>
                        </tr>


                        <tr class="prop">
                            <td valign="top"  class="name">Attachments</td>
                            
                            <td valign="top" style="text-align: left;" >
                           <div class="warning">
                           Warning:<br>
                           Must be the following format : <g:each in="${grailsApplication.config.fileuploader.docs.allowedExtensions}" var="t">${t}, </g:each>
                           <br>Max file size is ${new java.text.DecimalFormat("#0").format(grailsApplication.config.fileuploader.docs.maxSize /1000 / 1024)} Mb
                           </div>
                                <fileuploader:form 	upload="docs" 
								successAction="upload"
								successController="project"
								errorAction="upload"
								errorController="project">
								<input type="hidden" name="pid" value="${projectInstance.id}" >
								</fileuploader:form>
								<ul>
                                <g:each in="${projectInstance.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="show"
									errorController="project">${f.name}</fileuploader:download>
&nbsp;&nbsp;&nbsp;&nbsp;
                                    <g:link controller="project" action="deleteAttachment" id="${f.id}" params="[projectId : projectInstance?.id]"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >[Delete Attachment]</g:link>
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
                    <g:hiddenField name="id" value="${projectInstance?.id}" />
                     <span class="button"><g:actionSubmit class="edit" action="finished" value="finished" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                 
                    <g:if test="${projectInstance?.state == 'finished' }">
                        <g:link action="invoice" id="${projectInstance?.id}">send invoice</g:link>
                    </g:if>
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
