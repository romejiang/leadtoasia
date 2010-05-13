<g:set var="navigate" value="${['' , 'first step' , 'second step' , 'third step' , 'four step' , 'five step']}"/>
<table class="navigate">
<tr>
    <g:each in="${1..5}" var="no">
    <td <g:if test="${number == no}">class="now"</g:if>>${navigate[no]}</td>
    </g:each> 
   
</tr>
</table>
