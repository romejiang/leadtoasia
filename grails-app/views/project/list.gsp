

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
           
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
         <div class="search">
      
           <g:ifAnyGranted role="ROLE_ADMIN,ROLE_MANAGER"> 
                <form method=post action="search">
                <g:select id="client" name='client' value="${client}" from='${Customer.list()}'
                optionKey="id" optionValue="name" noSelection="${['':' - 选择客户 - ']}"></g:select>

                <input type="text" name="keyword" title="keyword" value="${keyword}">
                &nbsp;<input type="submit" value="search">
                </form>
             </g:ifAnyGranted>
            <g:ifAnyGranted role="ROLE_SALES_DIRECTOR">销售人员：
                
                <form method=post action="sales">
                

                 <g:select id="datetime" name='datetime' value="${datetime}" 
                from="${[1: '本周' , 2:'本月' , 3: '季度' ,4:'全年']}"
                optionKey="key" optionValue="value"
                noSelection="${['':' - 选择日期 - ']}"></g:select>
 
                <g:select id="state" name='state' value="${state}" 
                from="${['quote' : '报价中', 'processing' : '进行中' ,'finished' : '已完成' , 'invoice' : '等待付款','paid' : '已付款' ,'cancel' : '取消项目' ]}"
                optionKey="key" optionValue="value"
                noSelection="${['':' - 选择状态 - ']}"></g:select>

                <g:select id="sale" name='sale' value="${sale}" 
                from="${User.list()?.findAll(){it.authorities.contains(Role.findByAuthority('ROLE_SALES'))}}"
                optionKey="id" optionValue="userRealName" noSelection="${['':' - 选择销售人员 - ']}"></g:select>

                &nbsp;<input type="submit" value="search">
                </form>
                
            </g:ifAnyGranted>
        </div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                           
                            <g:sortableColumn property="projectNo" title="${message(code: 'project.projectNo.label', default: 'Project No')}" />
                            <g:sortableColumn property="customer" title="${message(code: 'project.customer.label', default: 'customer')}" />
                        
                            <g:sortableColumn property="deadline" title="${message(code: 'project.deadline.label', default: 'Deadline')}" />
                         
						    <g:sortableColumn property="state" title="${message(code: 'project.state.label', default: 'State')}" /> 
                            <g:ifAnyGranted role="ROLE_SALES">
                             <g:sortableColumn property="manager" title="${message(code: 'project.manager.label', default: 'Manager')}" /> 
                            </g:ifAnyGranted>
                            <th></th> 
                            <g:ifNotGranted role="ROLE_SALES">
                            <th></th>
                            </g:ifNotGranted>
                        </tr>
                    </thead>
                    <tbody>
                    <g:set var="tt" value="${0.0}" />
                    <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                        <g:set var="tt" value="${tt + projectInstance?.income()}" />
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'} " title="${projectInstance?.state}">
                            
                            <td>
                             
<g:link action="show" id="${projectInstance.id}"  >${fieldValue(bean: projectInstance, field: "projectNo")}</g:link> 
                            </td>

							<td> ${fieldValue(bean: projectInstance, field: "customer")}  </td>
                        
                            <td><g:formatDate date="${projectInstance.start}" /><br>
                            <g:formatDate date="${projectInstance.deadline}" /></td> 
                             

							<td>
                            <g:message code="project.state.${projectInstance.state}"   />
                            <br>
                            <g:ifNotGranted role="ROLE_SALES">
                            <g:if test="${!projectInstance?.global}">
                                <g:link action="toSales" id="${projectInstance.id}">发给销售</g:link> |<br>
                                <!--<g:link action="uptotal" id="${projectInstance.id}">确认字数</g:link> |<br>-->
                            </g:if>
                            <g:if test="${projectInstance.state == 'finished'}"> 
                                <g:link action="invoice" id="${projectInstance.id}">发账单</g:link> |<br> 
                                <g:link action="paid" id="${projectInstance?.id}">收款</g:link>
                            </g:if>
                            <g:else>
                                <g:if test="${projectInstance.state != 'paid'}">
                                    <g:link action="finished" id="${projectInstance.id}">检查是否完成</g:link>
                                </g:if>
                            </g:else>
                            </g:ifNotGranted >
                            </td>
                            <g:ifAnyGranted role="ROLE_SALES">
                             <td>${projectInstance?.manager}<br>
                                ${projectInstance?.sales}</td>
                            </g:ifAnyGranted>
							<td>
                            <g:ifAnyGranted role="ROLE_ADMIN,ROLE_MANAGER">
							matchs:${projectInstance?.matchs?.size()} <br>
							task:${projectInstance?.task?.size()}  <br>
							dtp:${projectInstance?.dtp?.size()}  <br>
                            </g:ifAnyGranted>
                             <g:ifAnyGranted role="ROLE_SALES,ROLE_SALES_DIRECTOR">
                             总字数 : ${projectInstance?.matchs?.wordcount.sum()}<br>
                             项目总价：${projectInstance?.income()}<br>
 <g:if test="${projectInstance.state == 'finished' || projectInstance.state == 'invoice'}"> 
                             <g:link action="invoice" id="${projectInstance.id}">发账单</g:link>
 </g:if>
                            </g:ifAnyGranted>
                            </td>
                            
                            <g:ifNotGranted role="ROLE_SALES">
                            <td>
                                <g:link uri="/project/pdf/${projectInstance?.id}" target="_blank">查看账单</g:link>  
                            	</td>
                            </g:ifNotGranted >
 						
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                
                总计：<g:formatNumber number="${tt}" format="#,###.00" />元
                <g:paginate total="${projectInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
