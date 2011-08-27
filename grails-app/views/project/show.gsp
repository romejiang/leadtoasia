

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
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
                            <td valign="top"   width="450" colspan="2" > </td>
                            
                       
                            <td valign="top"   width="450" colspan="2" > </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top"   class="name"><g:message code="project.projectNo.label" default="Project No" /></td>
                            
                            <td valign="top"  >${fieldValue(bean: projectInstance, field: "projectNo")}</td>
                            
                       
                            <td valign="top"  class="name"><g:message code="project.customer.label" default="Customer" /></td>
                            
                            <td valign="top" >${projectInstance?.customer?.encodeAsHTML()}</td>
                            
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
                            
                      
                            <td valign="top"  class="name">客户项目编号</td>
                            
                            <td valign="top" >${projectInstance?.fromNo} </td>
                            
                        </tr>
                  
                    
                        <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.industry.label" default="industry" /></td>
                            
                            <td valign="top" >${fieldValue(bean: projectInstance, field: "industry")}</td>
                            
                      
                            <td valign="top"  class="name"><g:message code="project.manager.label" default="Manager" /></td>
                            
                            <td valign="top" ><g:link controller="user" action="show" id="${projectInstance?.manager?.id}">${projectInstance?.manager.encodeAsHTML()}</g:link></td>
                            
                        </tr>  

                          <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.content.label" default="Content" /></td>
                            
                            <td valign="top"  colspan="3">${fieldValue(bean: projectInstance, field: "content")}</td> 
                       
                        </tr>  
                    
                 </tbody>
                </table>
				<table>
                    <tbody>	
                        <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.matchs.label" default="Matchs" /></td>
                            
                            <td valign="top" style="text-align: left;" >
                            <g:ifAnyGranted role="ROLE_USER,ROLE_MANAGER,ROLE_ADMIN">
                                <g:link controller="match" action="create" params="[pid : projectInstance.id,parentType:'project']">添加匹配率</g:link>
								 </g:ifAnyGranted>
                                <ul>
                                <g:each in="${projectInstance.matchs}" var="m">
                                    <g:ifAnyGranted role="ROLE_USER,ROLE_MANAGER,ROLE_ADMIN">  
                                    <li><g:link controller="match" action="show" id="${m.id}"  params="['project.id' : projectInstance.id,parentType:'project']">${m?.encodeAsHTML()}</g:link></li>                                 </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_SALES_DIRECTOR,ROLE_SALES">  
                                    <li>${m?.encodeAsHTML()}</li>
                                    </g:ifAnyGranted>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top"  class="name"><g:message code="project.task.label" default="Task" /></td>
                            
                            <td valign="top" style="text-align: left;" >
                            <g:ifAnyGranted role="ROLE_USER,ROLE_MANAGER,ROLE_ADMIN"> 
							<g:link controller="localization" action="create" params="[pid : projectInstance.id,parentType:'task']">添加语言</g:link>
                                 </g:ifAnyGranted>
                                 <table>  
                                <g:each in="${projectInstance?.task}" var="q">
                                   <tr>
                                    <td > 
                                    <g:link controller="localization" action="show" id="${q.id}"  params="[pid : projectInstance.id,parentType:'task']">${q?.encodeAsHTML()}  (每字=${q?.price}${q?.unit})</g:link>
                                    </td>

                            <g:ifAnyGranted role="ROLE_USER,ROLE_MANAGER,ROLE_ADMIN"> 

                                    <td> 
									<g:if test="${q?.projectOrder}">
                                        <img src="${resource(dir:'images',file:'image_edit.png')}" border=0 alt="TEP">
									    <g:link controller="projectOrder" action="show" id="${q?.projectOrder?.id}"  params="[pid : projectInstance.id]">${q?.projectOrder?.vendor}</g:link>&nbsp;&nbsp;${q?.projectOrder?.state}
									</g:if>
                                    </td>
                                    <td>
									<g:if test="${q?.projectOrder}">
                                        <g:if test="${q?.projectOrder?.state ==  'new'}">
                                            <g:link  action="pdf" controller="my" id="${q?.projectOrder?.id}"  target="_blank">查看订单</g:link> |
                                            <g:link  action="notice" controller="projectOrder" id="${q?.projectOrder?.id}" params="[pid: projectInstance.id]" onclick="this.disabled = true;\$('#spinner').show();">立即通知</g:link>
                                        </g:if>
                                        <g:if test="${q?.projectOrder?.state == 'submit' }">
                                            <g:link controller="projectOrder" action="goback" id="${q?.projectOrder?.id}"  params="[pid: projectInstance.id]" onclick="this.disabled = true;\$('#spinner').show();">返回</g:link> |
                                            <g:link controller="projectOrder" action="pass" id="${q?.projectOrder?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >通过</g:link>
                                         </g:if>
                                         <g:if test="${q?.projectOrder?.state == 'invoice'}">
                                          <g:link controller="projectOrder" action="finished" id="${q?.projectOrder?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >已支付</g:link>
                                         </g:if>
									</g:if>
                                    <g:else>
                                      	 <g:link controller="projectOrder" action="create" params="['project.id' : projectInstance.id, 'localization.id' : q.id ,parentType:'project']">创建订单</g:link>
                                    </g:else>
                                    </td>
                          </g:ifAnyGranted>
									</tr> 
                                </g:each>   
                                </table>
                                
                            </td>
                        </tr>
           

         
                                 <tr class="prop">
                            <td valign="top"  class="name">DTP</td>
                            
                            <td valign="top" style="text-align: left;" >
							<g:ifAnyGranted role="ROLE_USER,ROLE_MANAGER,ROLE_ADMIN">
                            <g:link controller="localization" action="create" params="[pid : projectInstance.id,parentType:'dtp']">添加DTP</g:link>
                            </g:ifAnyGranted>     
                               <table>  
                                <g:each in="${projectInstance?.dtp}" var="q">
                                   <tr>
                                    <td > 
                                    <g:link controller="localization" action="show" id="${q.id}"  params="[pid : projectInstance.id,parentType:'dtp']">${q?.encodeAsHTML()}  ${q?.price}</g:link>
                                    </td>
                                    <g:ifAnyGranted role="ROLE_USER,ROLE_MANAGER,ROLE_ADMIN">
                                    <td>
                                    
									<g:if test="${q?.projectOrder}">
                                        <img src="${resource(dir:'images',file:'layout_content.png')}" border=0 alt="TEP">
									    <g:link controller="projectOrder" action="show" id="${q?.projectOrder?.id}"  params="[pid : projectInstance.id]">${q?.projectOrder?.vendor}</g:link>&nbsp;&nbsp;${q?.projectOrder?.state}
									</g:if>
                                    </td>
                                    <td>
									<g:if test="${q?.projectOrder}">
                                        <g:if test="${q?.projectOrder?.state ==  'new'}">
                                            <g:link  action="pdf" controller="my" id="${q?.projectOrder?.id}"  target="_blank">显示订单</g:link> |
                                            <g:link  action="notice" controller="projectOrder" id="${q?.projectOrder?.id}" params="[pid: projectInstance.id]" onclick="this.disabled = true;\$('#spinner').show();">通知译者</g:link>
                                        </g:if>
                                        <g:if test="${q?.projectOrder?.state == 'submit' }">
                                            <g:link controller="projectOrder" action="processing" id="${q?.projectOrder?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >退回</g:link> |
                                            <g:link controller="projectOrder" action="pass" id="${q?.projectOrder?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >通过</g:link>
                                         </g:if>
                                         <g:if test="${q?.projectOrder?.state == 'invoice'}">
                                          <g:link controller="projectOrder" action="finished" id="${q?.projectOrder?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >支付</g:link>
                                         </g:if>
									</g:if>
                                    <g:else>
                                      	 <g:link controller="dtpOrder" action="create" params="['project.id' : projectInstance.id, 'localization.id' : q.id ,parentType:'project']">添加DTP</g:link>
                                    </g:else>
                                    </td> 
                                    </g:ifAnyGranted>   
									</tr> 
                                </g:each>   
                                </table>
                            </td>
                        </tr>

 
                        <tr class="prop">
                            <td valign="top"  class="name">源文件</td>
                            <td valign="top" style="text-align: left;" >                              
                             <div class="warning">
                           注意：<br>
                           上传的文件格式必须为以下格式：<g:each in="${grailsApplication.config.fileuploader.docs.allowedExtensions}" var="t">${t}, </g:each>
                           <br>大小上限为${new java.text.DecimalFormat("#0").format(grailsApplication.config.fileuploader.docs.maxSize /1000 / 1024)} Mb。
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
                                    <g:link controller="project" action="deleteAttachment" id="${f.id}" params="[projectId : projectInstance?.id]"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >[${message(code: 'project.deleteattachment', default: 'Delete Attachment')}]</g:link>
									</li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>



                           <tr class="prop">
                            <td valign="top"  class="name">完成文件</td>
                            
                            <td valign="top" style="text-align: left;" >
                           <g:ifAnyGranted role="ROLE_SALES,ROLE_SALES_DIRECTOR">
                        
								<ul>
                                <g:each in="${ProjectOrder.findAllByProject(projectInstance)}" var="pos">
 
                                <g:each in="${pos.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="show"
									errorController="project">${f.name}</fileuploader:download> 
									</li>
                                </g:each>
                                  <g:form  url="[action:'index',controller:'projectOrder']">
                                    <g:hiddenField name="id" value="${pos?.id}" />
                                    <g:hiddenField name="pid" value="${project?.id}" /> 

                                    <g:if test="${pos?.state == 'submit' }">
                                    <span class="button"><g:actionSubmit class="edit" action="goback" value="不通过" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                                    <span class="button"><g:actionSubmit class="edit" action="pass" value="通过" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                                    </g:if> 
                                </g:form>

                                </g:each>
                                </ul>
                                </g:ifAnyGranted>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
            <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN,ROLE_SALES_DIRECTOR">
                <g:form>
                   <g:hiddenField name="id" value="${projectInstance?.id}" />

                   <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">

                     <g:if test="${projectInstance?.state == 'quote' }">
                     <span class="button"><g:actionSubmit class="edit" action="accept" value="${message(code: 'default.accept.label', default: 'Accept')}${message(code: 'project.label', default: 'project')}"  /></span>
                    </g:if>
                    <g:if test="${projectInstance?.state == 'processing'   }">
                     <span class="button"><g:actionSubmit class="edit" action="finished" value="${message(code: 'default.button.checkfinish', default: 'Check Finish')}" /></span>
                    </g:if>
                    <g:if test="${projectInstance?.state == 'finished' }">
                        <g:link action="invoice" id="${projectInstance?.id}">发送发票</g:link> | 
                        <g:link action="paid" id="${projectInstance?.id}">支付</g:link>
                    </g:if>
                    </g:ifAnyGranted>
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}${message(code: 'project.label', default: 'project')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.cancel.label', default: 'cancel')}${message(code: 'project.label', default: 'project')}" 
                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.delete.label', default: 'delete')}${message(code: 'project.label', default: 'project')}" 
                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
                 </g:ifAnyGranted>
            </div>
        </div>
    </body>
</html>
 