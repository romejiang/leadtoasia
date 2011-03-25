<html>
    <head>
        <title>Welcome to</title>
		<meta name="layout" content="main" />
	 
    </head>
    <body>
        <g:isNotLoggedIn>
        <meta http-equiv="refresh" content="0;url=login/auth">
        </g:isNotLoggedIn>
        <div class="body">
            <h1><g:message code="menu.welcome" default="Welcome" /></h1>
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
         </div>
    </body>
</html>