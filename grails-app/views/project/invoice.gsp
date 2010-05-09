

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'notice.label', default: 'Notice')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
       </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${noticeInstance}">
            <div class="errors">
                <g:renderErrors bean="${noticeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="notice.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: noticeInstance, field: 'name', 'errors')}">
                                    ${noticeInstance?.name}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="notice.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: noticeInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" maxlength="240" value="${noticeInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="content"><g:message code="notice.content.label" default="Content" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: noticeInstance, field: 'content', 'errors')}">
                                    <g:textArea name="content" cols="40" rows="5" value="${noticeInstance?.content}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="sendInvoice" value="Send Invoice" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
