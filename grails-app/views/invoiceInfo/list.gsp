

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'invoiceInfo.label', default: 'InvoiceInfo')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr> 
                            <g:sortableColumn property="payment" title="${message(code: 'invoiceInfo.payment.label', default: 'Payment')}" />
                        
                            <g:sortableColumn property="paymentDetail" title="${message(code: 'invoiceInfo.paymentDetail.label', default: 'Payment Detail')}" />
                        
                            <th>${message(code: 'invoiceInfo.head.label', default: 'Head')}</th>
                            <th></th> 
                    	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${invoiceInfoInstanceList}" status="i" var="invoiceInfoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${invoiceInfoInstance.id}">${fieldValue(bean: invoiceInfoInstance, field: "payment")}</g:link></td>
                     
                         
                            <td>${fieldValue(bean: invoiceInfoInstance, field: "paymentDetail")}</td>
                        
                            <td>${invoiceInfoInstance.head?"Yes" :"No"}</td> 
                            <td><g:link controller="invoiceInfo" action="defaults" id="${invoiceInfoInstance.id}">Set Default</g:link></td> 
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${invoiceInfoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
