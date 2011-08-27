

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
     
        <div class="body">
            <h1>上传简历</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        

						<tr class="prop">
                            <td valign="top" class="name">附件</td>
                            
                            <td valign="top" class="value">
							上传文件必须为以下格式：<g:each in="${grailsApplication.config.fileuploader.docs.allowedExtensions}" var="t">${t},</g:each>
							<fileuploader:form 	upload="docs" 
								successAction="uploadcv"
								successController="my"
								errorAction="cv"
								errorController="my">
 								</fileuploader:form>
								<ul>
								<g:each in="${user?.attachments}" var="f">
                                    <li> 
									<fileuploader:download id="${f.id}"
									errorAction="cv"
									errorController="my"
                                    contentDisposition="attachment">${f.name}</fileuploader:download>
									</li>
                                </g:each>
								</ul>
							</td>
                            
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
              
            </div>
        </div>
    </body>
</html>
