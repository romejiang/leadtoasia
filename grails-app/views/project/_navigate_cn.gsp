<g:set var="navigate" value="${['' , '基本信息' , '翻译语言' , '预览保存' , '完成']}"/>
<table class="navigate">
<tr>
    <g:each in="${1..3}" var="no">
    <td <g:if test="${number == no}">class="now"</g:if>>${navigate[no]}</td>
    </g:each> 
   
</tr>
</table>
