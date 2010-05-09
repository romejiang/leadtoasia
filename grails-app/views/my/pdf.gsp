

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
         <g:set var="entityName" value="${message(code: 'projectOrder.label', default: 'ProjectOrder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
		<style>
		body {
			background: #fff;
			font: 11px verdana, arial, helvetica, sans-serif;
		}
        table {
			border-collapse:collapse; 
			border:solid #000; 
			border-width:1px; 
		}
		table caption {font-size:11px;font-weight:bolder;}
		table th {border:#000000 1px solid; font-size:14px;text-align:center;}
		table td {border:#000000 1px solid; padding:2px;font-size:11px;}
		.top {text-align:center;  font-size:18px;font-weight: bold;}
		.bottom {text-align:center; font-weight: bold;padding-top:5px}
        </style>
    </head>
    <body>
        <div class="nav">
             
        </div>
        <div class="body">
		<div class="top">Lead To Asia Translation &amp; Localization Co.,Ltd Hong Kong 
		<br></br><img src="${resource(dir:'images',file:'logo.gif')}"   alt=""></img></div>
		<div class="title">   </div>
<table width="680"  align="center" border="1">
    <tr>
    <th colspan="2" width="340" >Purchase Order </th>
    <th colspan="2" width="340" >To: ${projectOrderInstance?.vendor?.userRealName}</th>
     
  </tr>
  <tr>
    <td colspan="2">Supplier/Vendor Name: ${projectOrderInstance?.vendor?.userRealName}</td>
    <td width="170" >PM:${projectOrderInstance?.project?.manager?.userRealName}</td>
    <td width="170" >Tel:${projectOrderInstance?.project?.manager?.tel}</td>
  </tr>
  <tr>
    <td colspan="2">Order No: ${projectOrderInstance?.id}</td>
    <td>Email:${projectOrderInstance?.project?.manager?.email}</td>
    <td>Fax:${projectOrderInstance?.project?.manager?.fax}</td>
  </tr>
  <tr>
    <td width="170" >PO Content: ${projectOrderInstance?.serviceType}</td>
    <td width="170" >Tel:${projectOrderInstance?.vendor?.tel}</td>
    <td colspan="2">Service Type: ${projectOrderInstance?.serviceType}</td>
  </tr>
  <tr>
    <td>Email:${projectOrderInstance?.vendor?.email}</td>
    <td>Fax:${projectOrderInstance?.vendor?.fax}</td>
    <td>Adjusted word count: ${projectOrderInstance?.paymentSort}</td>
    <td>New words: ${projectOrderInstance?.paymentSort}</td>
  </tr>
  <tr>
    <td>Source Language: ${Localization.findByProjectOrder(projectOrderInstance)?.source}</td>
    <td>Field:</td>
    <td>Target Language: ${Localization.findByProjectOrder(projectOrderInstance)?.target}</td>
    <td></td>
  </tr>
  <tr>
    <td colspan="2">Delivery date: <g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
    <td colspan="2">Rate: ${projectOrderInstance?.rate}</td>
  </tr>
  <tr>
    <td colspan="2" rowspan="5">Any requirements: ${projectOrderInstance?.requirement}</td>
    <td colspan="2">Submission Pattem:</td>
  </tr>
  <tr>
    <td>Payment Sort: ${projectOrderInstance?.paymentSort}</td>
    <td>Payment terms: ${projectOrderInstance?.paymentTerms}</td>
  </tr>
  <tr>
    <td colspan="2">Total:${projectOrderInstance?.total}</td>
  </tr>
  <tr>
    <td colspan="2">PM: </td>
  </tr>
  <tr>
    <td colspan="2">Date:<g:formatDate date="${projectOrderInstance?.start}" /></td>
  </tr>
</table>
<div class="bottom">Invoice to: accounting@leadtoasia.com<br></br>
Our terms of payment is 30 days after receiving your receipt of invoice. <br></br>
Lead To Asia Translation &amp; localization Co., Ltd 
<br></br>Tel: 0085281999847 • Fax: 0085227837978 Email: info@leadtoasia.com • Web:www.leadtoasia.com 
<br></br>UNIT 1001 FOURSEAS BUILDING 208-212 NATHAN ROAD KOWLOON HONGKONG </div>      
              
        </div>
    </body>
</html>
