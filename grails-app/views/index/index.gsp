<html>
    <head>
        <title>Welcome to</title>
		<meta name="layout" content="main" />
        <g:isNotLoggedIn>
        <meta http-equiv="refresh" content="0;url=login/auth"> 
        </g:isNotLoggedIn>
    </head>
    <body>
     <div class="body">
            <h1><g:message code="menu.welcome" default="Welcome" /></h1>

        <g:isLoggedIn>
        <g:ifAnyGranted role="ROLE_SALES,ROLE_SALES_DIRECTOR">
          <g:if test="${finishedProject.size > 0}"  >
                <div class="message"><g:message code="menu.new.notice" default="New Project Notice {0}"  args="[finishedProject.size]"/></div>
            </g:if> 
            <div class="dialog">
                    <table>
                        <tr>
                            <td  width="50%">
                                 <g:render template="list" model="['title': message(code: 'menu.projectquote', default: 'Quote'),'list':quoteProject]" />
                            </td>  
                            
                            <td width="50%">
                                <g:render template="list" model="['title': message(code: 'menu.projectprocessing', default: 'Processing'), 'list' : processingProject]" />
                            </td>
                        </tr>
                    </table>
                     <table>
                        <tr>
                            <td  width="50%">
                                 <g:render template="list" model="['title': '已完成的项目','list': finishedProject ,showtime : true ]" />
                            </td>  
                            
                            <td width="50%">
                                <g:render template="list" model="['title': '已付款的项目','list': paidProject]" />
                            </td>
                        </tr>
                    </table>
                </div> 

          </g:ifAnyGranted>
        <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">
       
            <g:if test="${quoteProject.size > 0}"  >
                <div class="message"><g:message code="menu.new.notice" default="New Project Notice {0}"  args="[quoteProject.size]"/></div>
            </g:if> 
            <div class="dialog">
                    <table>
                        <tr>
                            <td  width="50%">
                                 <g:render template="list" model="['title': message(code: 'menu.projectquote', default: 'Quote'),'list':quoteProject]" />
                            </td>  
                            
                            <td width="50%">
                                <g:render template="list" model="['title': message(code: 'menu.projectprocessing', default: 'Processing'), 'list' : processingProject]" />
                            </td>
                        </tr>
                    </table>
                </div> 
         
          </g:ifAnyGranted>
        <g:ifAnyGranted role="ROLE_USER"> 
                        <div class="dialog">
                    <table>
                        <tr>
                            <td  width="50%">
                                 <g:render template="polist" model="['title': message(code: 'menu.requestedtasks', default: 'requested tasks'),'list': projectOrderQuote]" />
                            </td>  
                            
                            <td width="50%">
                                <g:render template="polist" model="['title': message(code: 'menu.currenttasks', default: 'current tasks'), 'list' : projectOrderOpen]" />
                            </td>
                        </tr>
                    </table>
                </div> 
        </g:ifAnyGranted>
         </g:isLoggedIn>
         </div>
    </body>
</html>