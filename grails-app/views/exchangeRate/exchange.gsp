

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'exchangeRate.label', default: 'ExchangeRate')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${exchangeRateInstance}">
            <div class="errors">
                <g:renderErrors bean="${exchangeRateInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="exchange" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currency"><g:message code="exchangeRate.currency.label" default="Currency" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: exchangeRateInstance, field: 'currency', 'errors')}">
                                     <g:lookupSelect  name="currency" realm="Monetary Unit"  value="${params.currency}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="rate"><g:message code="exchangeRate.rate.label" default="Rate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: exchangeRateInstance, field: 'rate', 'errors')}">
                                    <g:textField name="source" value="${params.source}" />
                                </td>
                            </tr>
                            <g:if test="${result}">
                            
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="rate">Result</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: exchangeRateInstance, field: 'rate', 'errors')}">
                                     ${result} USD
                                </td>
                            </tr> 
                            </g:if>                      
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
