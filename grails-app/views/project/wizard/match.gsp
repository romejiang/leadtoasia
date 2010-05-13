

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript src="flowMatch.js"  />

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
                                <td valign="top">
                                    <label for="wordcount"><g:message code="match.wordcount.label" default="Wordcount" /></label>
                                </td>
                                <td valign="top">
                                    <g:textField name="wordcount" class="wordcount" value="${fieldValue(bean: matchInstance, field: 'wordcount')}" size="10" />

                                </td>
                          
                                <td valign="top">
                                    <label for="match"><g:message code="match.match.label" default="Match" /></label>
                                </td>
                                <td valign="top">
                                    ${matchInstance.constraints.match.inList[i]}
                                    <input type="hidden" name="match" value="${matchInstance.constraints.match.inList[i]}">

                                </td>
                           
                                <td valign="top">
                                    <label for="discount"><g:message code="match.discount.label" default="Discount" /></label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="discount"   class="discount" value="${fieldValue(bean: matchInstance, field: 'discount')}"  size="5" />%
                                </td>
                                  <td valign="top">
                                    <label for="Result">Result</label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="result" class="result" value=""  size="5" Disabled="true"/>word
                                </td>
                            </tr>

                            </g:each>
                             <tr class="prop">
                                <td valign="top" colspan=6>
                                   
                                </td>
                                  <td valign="top">
                                    <label for="total">Total:</label>
                                </td>
                                <td valign="top" >
                                    <g:textField name="total" size="5" />word
                                </td>
                            </tr>

                        
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
