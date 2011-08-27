

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
            <h1>发送验收信息</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
          
            <g:form method="post" >
                <g:hiddenField name="id" value="${id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name">项目名称</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: noticeInstance, field: 'name', 'errors')}">
                                    ${project?.projectNo}
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title">更新字数</label>
                                </td>
                                <td valign="top" class="value ">
                                    <g:textField name="wordcount" maxlength="240" value="${wordcount}" />
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="uptotalTo" value="更新字数" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
