

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="projectOrder.list" default="ProjectOrder List" /></title>
    </head>
    <body>
       
        <div class="body">
            <h1>${params?.state?title[params.state] : "Project Order List"}</h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                         
                   	    <th>项目编号</th> 
                   	    <th>服务类型</th>
                   	    <th>所属行业</th>
                   	    <th>任务</th>
                   	     
                   	    <g:sortableColumn property="wordcount" title="Wordcount" titleKey="projectOrder.wordcount.label" />
                        
                         
                   	    <g:sortableColumn property="deliveryDate" title="Delivery Date" titleKey="projectOrder.deliveryDate.label" />
                        <th>预览PO</th>
                        <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectOrderInstanceList}" status="i" var="projectOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projectOrderInstance.id}" fragment="Source">${projectOrderInstance?.project?.projectNo}</g:link></td>
                             
                            <td>${projectOrderInstance?.serviceType}</td>
                            <td>${projectOrderInstance?.project?.industry?.name}</td>
                        
                            <td> 
                                   ${projectOrderInstance?.localization?.encodeAsHTML()} 
                            </td>
                        
                            <td>${fieldValue(bean: projectOrderInstance, field: "wordcount")}</td>
                        
                         
                            <td><g:formatDate date="${projectOrderInstance.deliveryDate}"   /></td>
                            <td>
							<g:link uri="/my/pdf/${projectOrderInstance.id}" target="_blank">查看订单</g:link> 
							
							</td>
                            <td>
							 
							<g:if test="${projectOrderInstance.state == 'new'}">
										 <g:link action="activating"  id="${projectOrderInstance.id}" onclick="return confirm('Are you sure?');">确认</g:link>
							</g:if>
							<g:if test="${projectOrderInstance.state == 'processing'}">
										 <g:link action="complete"  id="${projectOrderInstance.id}">提交</g:link>
							</g:if>	
                            <g:if test="${projectOrderInstance.state == 'pass'}">
										 <g:link action="invoice"  id="${projectOrderInstance.id}">发票</g:link>
							</g:if>	
                           <g:if test="${projectOrderInstance.state == 'submit'}">
										 等待审核中
							</g:if>	
                            <g:if test="${projectOrderInstance.state == 'invoice'}">
										 已发送发票
							</g:if>	
                            <g:if test="${projectOrderInstance.state == 'finished'}">
										 项目结束
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
