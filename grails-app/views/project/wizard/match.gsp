

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
            <h1>Match</h1>
        
             <g:render template="navigate" model="['number':2]" />

            <g:form action="wizard" method="post" >
                <div class="dialog">
                   <table>
                        <tbody>
                            
                            <g:each in="${matchs}" status="i" var="matchInstance">

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="wordcount"><g:message code="match.wordcount.label" default="Wordcount" /></label>
                                </td>
                                <td valign="top">
                                    <g:textField name="wordcount" value="${fieldValue(bean: matchInstance, field: 'wordcount')}" size="10" />

                                </td>
                          
                                <td valign="top" class="name">
                                    <label for="match"><g:message code="match.match.label" default="Match" /></label>
                                </td>
                                <td valign="top">
                                    ${matchInstance.constraints.match.inList[i]}
                                    <input type="hidden" name="match" value="${matchInstance.constraints.match.inList[i]}">

                                </td>
                           
                                <td valign="top" class="name">
                                    <label for="discount"><g:message code="match.discount.label" default="Discount" /></label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="discount" value="${fieldValue(bean: matchInstance, field: 'discount')}"  size="10"/>%
                                </td>
                            </tr>

                            </g:each>
 

                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="previous" class="previous" value="previous" /></span>
                    <span class="button"><g:submitButton name="next" class="next" value="next" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
