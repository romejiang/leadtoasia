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
            <g:each in="${quoteProject}" var="project">
                <div class="message">${project}</div>
            </g:each>
            
        
            <div class="errors">
                 
            </div>
         
           
                <div class="dialog">
                    <table>
                        <tr>
                            <td>
                                
                            </td>  
                            
                            <td>
                            
                            </td>
                        </tr>
                    </table>
                </div> 
         </div>
    </body>
</html>