

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'notice.label', default: 'Notice')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                <g:hiddenField name="id" value="${noticeInstance?.id}" />
                <g:hiddenField name="version" value="${noticeInstance?.version}" />
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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
           <div class="" style="color: #333; text-align: left; ">
            Available variables：<br> 
&#36;{projectNo} <br>
&#36;{projectOrder.serviceType}<br>
&#36;{to}<br>
&#36;{projectOrder.wordcount} <br>
&#36;{project.deadline.format('yyyy-MM-dd')} <br>
&#36;{project.content} <br>
&#36;{pdflink} <br>
&#36;{project.manager.userRealName}<br>
&#36;{invoiceInfo?.payment} <br>
&#36;{invoiceInfo?.paymentDetail}<br>
</div>
        </div>
    </body>
</html>
