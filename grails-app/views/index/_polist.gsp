<table>
 <thead>
 <tr>
    <th>${title}</th>
</tr>
<thead>
<tr>
    <td>
        <ul>
            <g:each in="${list}" var="instance"> 
            <li><g:link controller="my"  action="show" id="${instance.id}"  >${instance} </g:link>
            </g:each>
        </ul>
    </td>
</tr>
</table>