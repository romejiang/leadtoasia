

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="projectOrder.list" default="ProjectOrder List" /></title>
    </head>
    <body>
       
        <div class="body">
            <h1>${title[params.state]}</h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                         
                   	    <th>Project No</th>
                   	    <th>Service Type</th>
                   	    <th>Source And Target</th>
                   	     
                   	    <g:sortableColumn property="wordcount" title="Wordcount" titleKey="projectOrder.wordcount" />
                        
                   	    <g:sortableColumn property="requirement" title="Requirement" titleKey="projectOrder.requirement" />
                        
                   	    <g:sortableColumn property="deliveryDate" title="Delivery Date" titleKey="projectOrder.deliveryDate" />
                        <th>PO</th>
                        <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectOrderInstanceList}" status="i" var="projectOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projectOrderInstance.id}">${projectOrderInstance?.project?.projectNo}</g:link></td>
                            <td>${projectOrderInstance.serviceType}</td>
                        
                            <td><g:each in="${Localization.findAllByProjectOrder(projectOrderInstance)}" var="q">
                                   ${q?.encodeAsHTML()}<br>
                                </g:each></td>
                        
                         
                            <td>${fieldValue(bean: projectOrderInstance, field: "wordcount")}</td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "requirement")}</td>
                        
                            <td><g:formatDate date="${projectOrderInstance.deliveryDate}"   /></td>
                            <td>
							<g:link uri="/my/pdf/${projectOrderInstance.id}" target="_blank">PO</g:link> 
							
							</td>
                            <td>
							 
							<g:if test="${projectOrderInstance.state == 'new'}">
										 <g:link action="activating"  id="${projectOrderInstance.id}">Confirm</g:link>
							</g:if>
							<g:if test="${projectOrderInstance.state == 'processing'}">
										 <g:link action="complete"  id="${projectOrderInstance.id}">Submit</g:link>
							</g:if>	
                            <g:if test="${projectOrderInstance.state == 'pass'}">
										 <g:link action="invoice"  id="${projectOrderInstance.id}">Invoice</g:link>
							</g:if>	
                           <g:if test="${projectOrderInstance.state == 'submit'}">
										 Awaiting Authenticate
							</g:if>	
                            <g:if test="${projectOrderInstance.state == 'invoice'}">
										 Invoiced
							</g:if>	
                            <g:if test="${projectOrderInstance.state == 'finished'}">
										 Finished
							</g:if>	
							</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${projectOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
