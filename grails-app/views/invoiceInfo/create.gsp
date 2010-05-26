

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'invoiceInfo.label', default: 'InvoiceInfo')}" />
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
            <g:hasErrors bean="${invoiceInfoInstance}">
            <div class="errors">
                <g:renderErrors bean="${invoiceInfoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                         
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="payment"><g:message code="invoiceInfo.payment.label" default="Payment" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invoiceInfoInstance, field: 'payment', 'errors')}">
                                        <g:lookupSelect  name="payment" realm="Payment Sort" value="${invoiceInfoInstance.payment}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentDetail"><g:message code="invoiceInfo.paymentDetail.label" default="Payment Detail" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invoiceInfoInstance, field: 'paymentDetail', 'errors')}">
                                    <g:textArea name="paymentDetail" cols="40" rows="5" value="${invoiceInfoInstance?.paymentDetail}" />
                                </td>
                            </tr>
                         
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
