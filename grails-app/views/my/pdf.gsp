

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
    <th colspan="2" width="340" >项目订单</th>
    <th colspan="2" width="340" >接单人： ${projectOrderInstance?.vendor?.userRealName}</th>
     
  </tr>
  <tr>
    <td colspan="2">译者名称： ${projectOrderInstance?.vendor?.userRealName}</td>
    <td width="170" >项目经理：${projectOrderInstance?.project?.manager?.userRealName}</td>
    <td width="170" >Tel:${projectOrderInstance?.project?.manager?.tel}</td>
  </tr>
  <tr>
    <td colspan="2">订单号：${projectOrderInstance?.project?.projectNo}</td>
    <td>Email:${projectOrderInstance?.project?.manager?.email}</td>
    <td>Fax:${projectOrderInstance?.project?.manager?.fax}</td>
  </tr>
  <tr>
    <td width="170" >PO State: ${projectOrderInstance?.state}</td>
    <td width="170" >Tel:${projectOrderInstance?.vendor?.tel}</td>
    <td colspan="2">服务类型：${projectOrderInstance?.serviceType}</td>
  </tr>
  <tr>
    <td>Email:${projectOrderInstance?.vendor?.email}</td>
    <td>Fax:${projectOrderInstance?.vendor?.fax}</td>
    <td colspan="2">项目金额： ${projectOrderInstance?.wordcount} ${projectOrderInstance?.type}</td>
    
  </tr>
  <tr>
    <td>源语言： </td>
    <td>${projectOrderInstance?.localization?.source}</td>
    <td>目标语言：</td>
    <td>${projectOrderInstance?.localization?.target}</td>
  </tr>
  <tr>
    <td colspan="2">交付日期：<g:formatDate date="${projectOrderInstance?.deliveryDate}" /></td>
    <td colspan="2">单价： ${projectOrderInstance?.rate} ${projectOrderInstance?.unit}</td>
  </tr>
  <tr>
    <td colspan="2" rowspan="5">其他要求： ${projectOrderInstance?.requirement}</td>
    <td colspan="2">提交文件格式：</td>
  </tr>
  <tr>
    <td>支付方式：${projectOrderInstance?.paymentSort}</td>
    <td>付款周期： ${projectOrderInstance?.paymentTerms}</td>
  </tr>
  <tr>
    <td colspan="2">总金额：${projectOrderInstance?.total} ${projectOrderInstance?.unit}</td>
  </tr>
  <tr>
    <td colspan="2">PM 签名：</td>
  </tr>
  <tr>
    <td colspan="2">日期：<g:formatDate date="${projectOrderInstance?.start}" /></td>
  </tr>
</table>
<div class="bottom">Invoice to: accounting@leadtoasia.com<br></br>
Our terms of payment is ${projectOrderInstance?.paymentTerms} days after receiving your receipt of invoice. <br></br>
Lead To Asia Translation &amp; localization Co., Ltd 
<br></br>Tel: 0085281999847 • Fax: 0085227837978 Email: info@leadtoasia.com • Web:www.leadtoasia.com 
<br></br>UNIT 1001 FOURSEAS BUILDING 208-212 NATHAN ROAD KOWLOON HONGKONG </div>      
              
        </div>
    </body>
</html>
