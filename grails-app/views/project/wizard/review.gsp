

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Review</h1>
             <g:render template="navigate" model="['number':5]" />
      
            <g:form action="wizard" method="post" >
  <div class="dialog">
                <table>
                    <tbody>
                     <tr class="prop">
                            <td valign="top"   width="450" colspan="2" > </td> 
                       
                            <td valign="top"   width="450" colspan="2" > </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top"  ><g:message code="project.projectNo.label" default="Project No" /></td>
                            
                            <td valign="top"  >${fieldValue(bean: projectInstance, field: "projectNo")}</td>
                            
                       
                            <td valign="top" ><g:message code="project.customer.label" default="Customer" /></td>
                            
                            <td valign="top" ><g:link controller="customer" action="show" id="${projectInstance?.customer?.id}">${projectInstance?.customer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" ><g:message code="project.deadline.label" default="Deadline" /></td>
                            
                            <td valign="top" ><g:formatDate date="${projectInstance?.deadline}" /></td>
                     
                            <td valign="top" ><g:message code="project.start.label" default="Start" /></td>
                            
                            <td valign="top" ><g:formatDate date="${projectInstance?.start}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" ><g:message code="project.state.label" default="State" /></td>
                            
                            <td valign="top" >${fieldValue(bean: projectInstance, field: "state")}</td>
                            
                      
                            <td valign="top" >Customer Project No</td>
                            
                            <td valign="top" >${projectInstance?.fromNo} </td>
                            
                        </tr>
                  
                    
                        <tr class="prop">
                            <td valign="top" ><g:message code="project.content.label" default="Content" /></td>
                            
                            <td valign="top" >${fieldValue(bean: projectInstance, field: "content")}</td>
                            
                      
                            <td valign="top" ><g:message code="project.user.label" default="Manager" /></td>
                            
                            <td valign="top" ><g:link controller="user" action="show" id="${projectInstance?.manager?.id}">${projectInstance?.manager.encodeAsHTML()}</g:link></td>
                            
                        </tr>  
                    
                 </tbody>
                </table>
				<table>
                    <tbody>	
                        <tr class="prop">
                            <td valign="top" ><g:message code="project.matchs.label" default="Matchs" /></td>
                            
                            <td valign="top" style="text-align: left;" >
 								<ul>
                                <g:each in="${matchs}" var="m">
                                    <g:if test="${m.wordcount && m.wordcount > 0}">
                                    <li>${m?.encodeAsHTML()}
                                    </g:if>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" ><g:message code="project.task.label" default="Task" /></td>
                            
                            <td valign="top" style="text-align: left;" >
                                 <ul> 
                                <g:each in="${localizationInstanceList}" var="q">
                                    <g:if test="${q.price && q.price > 0}">
                                    <li>${q?.encodeAsHTML()} ${q?.type == 'word' ? '' : q?.amount} ${q?.type} ${q?.price}${q?.unit}
                                    </g:if>
                                    </g:each>   
                                 
                                </ul>
                            </td>
                        </tr> 
                                 <tr class="prop">
                            <td valign="top" >DTP</td>
                            
                            <td valign="top" style="text-align: left;" >
                                 <ul>
                                <g:each in="${DTPInstanceList}" var="q">
                                    <g:if test="${q.price && q.price > 0}">
                                    <li>${q?.encodeAsHTML()} ${q?.type} ${q?.price}${q?.unit}
                                    </g:if>
                                </g:each>   
                                 </ul>
                            </td>
                        </tr>
 
                       
                    </tbody>
                </table>
            </div>
   
                <div class="buttons">
                    <span class="button"><g:submitButton name="previous" class="previous" value="previous" /></span>
                    <span class="button"><g:submitButton name="finished" class="finished" value="finished" /></span>
               </div>
            </g:form>
        </div>
    </body>
</html>
