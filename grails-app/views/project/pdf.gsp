<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
         <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
		<style>
        *{
            line-height: 180%;
        }
		body {
			background: #fff;
			font: 11px verdana, arial, helvetica, sans-serif;
		}
        table {
			border-collapse:collapse; 
			border:solid #000; 
			border-width:1px; 
		}
		table th {border:#000000 1px solid; font-size:16px;font-weight: bold;text-align:center;}
		table td {border:#000000 1px solid; padding:2px;font-size:14px;}
		.top {text-align:center;  font-size:20px;font-weight: bold;}
		.bottom { padding-top:5px;font-size:14px}
        .title{ text-align: right; font-size:14px}
        .info{ font-size:14px}
        </style>
    </head>
    <body>
        <div class="nav">
             
        </div>
        <div class="body">
		<div class="top">
		<img src="${resource(dir:'images',file:'logo.gif')}"   alt=""></img>
        <br/>Invoice
        </div>
		<div class="title">  
         
Lead to Asia consultancy &amp; service Co., Ltd<br/>
Unit 1001 Fourseas  <br/>
Building Nathan Road <br/>
Telephone: +852 8199 9307 <br/>
Fax:  +852 2783 7978 <br/>
Email: <a href="mailto:accounting@leadtoasia.com">accounting@leadtoasia.com</a> <br/><br/>
Invoice Number 100525 <br/>
</div>
<div class="info">
Anthony van de Veen <br/>
Program Director <br/>

Tel: 31 646053148  <br/>
Date: 8th January 2010 <br/>
Fax:  <br/>
E-mail:<a href="mailto:anthony@nimbuzz.com">anthony@nimbuzz.com </a><br/>
Order Number: EN-Multiple languages <br/>
        </div>
  
<table width="680" align="center" border="1">
  <tr>
    <th>Description </th>
    <th>Quantity </th>
    <th>Unit Price</th>
    <th>Net Amount</th>
  </tr>
  <g:set var="total" value="${0}" />
  <g:set var="unit" value="" />
<g:each in="${projectInstance?.task}" status="i" var="localizationInstance">

  <tr>
    <td>${localizationInstance?.source} into ${localizationInstance?.target}</td>
    <td>
	<g:set var="totalwords" value="${0}" />
	<g:if test="${localizationInstance.type == 'word'}">
		<ul> 
		<g:each in="${projectInstance?.matchs}" var="m"> 
				<li>${m.encodeAsHTML()}</li>   
		<g:set var="totalwords" value="${totalwords + m.discount * m.wordcount/100}" />
		</g:each></ul>
	</g:if>
	<g:if test="${localizationInstance.type == 'hour'}">
		<g:set var="totalwords" value="${localizationInstance?.projectOrder?.wordcount}" />
		<g:set var="totalwords" value="${totalwords == null ?0:totalwords}" />

		${totalwords}${localizationInstance.type}
	</g:if>
	<g:if test="${localizationInstance.type == 'page'}">
		<g:set var="totalwords" value="${localizationInstance?.projectOrder?.wordcount}" />
		<g:set var="totalwords" value="${totalwords == null ?0:totalwords}" />
		${totalwords}${localizationInstance.type}
	</g:if>
	<g:if test="${localizationInstance.type == 'minimum'}">
		<g:set var="totalwords" value="${localizationInstance?.projectOrder?.wordcount}" />
		<g:set var="totalwords" value="${totalwords == null ?0:totalwords}" />
		${totalwords}${localizationInstance.type}
	</g:if>
	</td>
    <td>${localizationInstance?.price}${localizationInstance?.unit} </td>
    <td>${new java.text.DecimalFormat("#0.00").format(localizationInstance?.price * totalwords)}${localizationInstance?.unit}</td>
  </tr>
  <g:set var="total" value="${total + localizationInstance?.price * totalwords }" />
  <g:set var="unit" value="${localizationInstance?.unit}" />

   </g:each>
  <tr>
    <td colspan="3">Total amount: </td>
    <td>${new java.text.DecimalFormat("#0.00").format(total)}${unit}</td>
  </tr>
</table>
<div class="bottom">
Bank information: Bank name: HSBC Hong Kong <br/>
Bank Address: 1 Queen’s Road Central, Hong Kong <br/>
Bank Code: 004 (for local payment) <br/>
Swift code: HSBCHKHHHKH (for telegraphic transfers) <br/>
Account number: 411-750409-838 <br/>

</div>      
              
        </div>
    </body>
</html>
