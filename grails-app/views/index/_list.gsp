<table>
 <thead>
 <tr>
    <th>${title}</th>
</tr>
<thead>
<tr>
    <td>
        <ul>
            <g:each in="${list}" var="projectInstance"> 
            <li><g:link controller="project"  action="show" id="${projectInstance.id}"  >${projectInstance}  -  ${projectInstance.sales}</g:link><g:if test="${showtime}">（<g:formatDate date="${projectInstance?.finishedDate}" />）</g:if>
            </g:each>
        </ul>
    </td>
</tr>
</table>