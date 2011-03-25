<html>
    <head>
        <title><g:layoutTitle default="Grails" /><g:message code="default.site" default="Lead To Asia CRM" />  </title>
        <bp:blueprintCss/>
		<link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
		<g:javascript library="jquery"/>
		<g:javascript src="jquery/jquery.pngFix.pack.js"/>
		<g:javascript src="jquery/jquery.corner.js"/>
        <g:javascript library="application" />
		<g:layoutHead /> 
    </head>
    <body>

        <div id="spinner" class="spinner"  >
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
        <div id="grailsLogo" class="logo"><a href="/leadtoasia"><img src="${resource(dir:'images',file:'logo.png')}" alt="leadtoasia" border="0" id="logoimg"  height="50"/></a><span><g:message code="default.site" default="Lead To Asia Translation & localization Co., Ltd" /></span>
        <g:isLoggedIn>
        <div class="panel"> 
                <select name="locale" id="locale"  >
                    <g:if test="${request.getAttribute(
    'org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER')?.resolveLocale(request)?.language?.contains( 'zh')}">
                <option value="zh_CN" ><g:message code="default.zh.name" default="Chinese" />                    
                <option value="en" ><g:message code="default.en.name" default="English" />
                </g:if>
                <g:else>
                  <option value="en" ><g:message code="default.en.name" default="English" />
                <option value="zh_CN" ><g:message code="default.zh.name" default="Chinese" />    
                </g:else>
                   
                 </select>&nbsp;| 
    
             <g:loggedInUserInfo field="userRealName"/>&nbsp;| 
             <g:link controller="my" action="edit" style="color: #fff"><g:message code="menu.profiles" default="Profiles" /></g:link>&nbsp;|
            <g:link action="index" controller="logout" style="color: #fff"><g:message code="menu.logout" default="Logout" /></g:link>
        </div> 
        </g:isLoggedIn>
        </div>
	 <div class="container">	 
      <div class="span-5 left">

<g:isLoggedIn>
  <ol>
		<li><g:link controller='index' ><g:message code="default.home.label" default="Index" /></g:link>
	</ol>	

 <g:ifAnyGranted role="ROLE_ADMIN">
	  	  <h1><g:message code="menu.administrator" default="Administrator " /></h1>
	  <ol>
		<li><g:link controller='customer' ><g:message code="customer.label" default="Client" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='customer'  action='create'><g:message code="menu.create" default="Create " /><g:message code="customer.label" default="Client" /></g:link>
		<li><g:link controller='project' ><g:message code="project.label" default="Project" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='project' action='create'><g:message code="menu.create" default="Create " /><g:message code="project.label" default="Project" /></g:link>
		<li><g:link controller='user' ><g:message code="user.label" default="User" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='user'  action='create'><g:message code="menu.create" default="Create " /><g:message code="user.label" default="User" /></g:link>
        <li><g:link controller='industry' ><g:message code="industry.label" default=" Industry" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='industry'  action='create'><g:message code="menu.create" default="Create " /><g:message code="industry.label" default=" Industry" /></g:link>
        </ol>
            <h1><g:message code="menu.systemparameter" default="System Parameter " /></h1>
	    <ol> 
		<li><g:link controller='notice' ><g:message code="notice.label" default="Notice" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='notice'  action='create'><g:message code="menu.create" default="Create " /><g:message code="notice.label" default="Notice" /></g:link>
		<li><g:link controller='lookup'  action='index'><g:message code="lookup.label" default="Lookup" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='lookupValue'  action='index'><g:message code="lookupValue.label" default="Value" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link controller='role'  action='index'><g:message code="role.label" default="Role" /><g:message code="menu.management" default=" Management" /></g:link> 
		<li><g:link controller='requestmap'   action='index'><g:message code="requestmap.label" default="Request Map" /></g:link> 
	    <li><g:link controller='noticeMail'   ><g:message code="noticeMail.label" default="NoticeMail" /><g:message code="menu.management" default=" Management" /></g:link> 
		<li><g:link controller='noticeMail'   action='create'><g:message code="menu.create" default="Create " /><g:message code="noticeMail.label" default="NoticeMail" /></g:link> 
		<li><g:link controller='exchangeRate' action='index'><g:message code="exchangeRate.label" default="Exchange Rate" /></g:link> 
		<li><g:link controller='exchangeRate' action='exchange'><g:message code="menu.testexchange" default="Test Exchange" /></g:link> 
	 </ol>
     	  	  <h1><g:message code="menu.report" default="Report " /></h1>
	  <ol> 
		<li><g:link controller='report' action="build"><g:message code="menu.buildrepor" default="Build Report" /></g:link> 
		<li><g:link controller='report' ><g:message code="menu.lastreport" default="Last Report" /></g:link>
		<li><g:link controller='report'  action='history'><g:message code="menu.historyreport" default="History Report" /></g:link>
	 </ol>
	</g:ifAnyGranted>

  	  <g:ifAnyGranted role="ROLE_MANAGER">
	  	<h1><g:message code="menu.manager" default="Manager" /></h1>
	<ol>
		<li><g:link action="list" controller="customer"><g:message code="customer.label" default="Client&nbsp;" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link action="create" controller="customer"><g:message code="menu.create" default="Create " /><g:message code="customer.label" default="Client" /></g:link>
  		<li><g:link action="start" controller="project"><g:message code="menu.create" default="Create " /><g:message code="project.label" default="Project" /></g:link>
 		<li><g:link action="list" controller="project"><g:message code="menu.projectinhands" default="Project  In Hands" /></g:link>
        <li><g:link action="list" controller="project" params="[state: 'finished']"><g:message code="menu.finished" default="Finished" /> <g:message code="project.label" default="Project" /></g:link>  
        <li><g:link action="list" controller="project" params="[state: 'invoice']"><g:message code="menu.awaitingpayment" default="Awaiting Payment" /></g:link>  
        <li><g:link action="list" controller="project" params="[state: 'paid']"><g:message code="menu.paid" default="Paid" /><g:message code="project.label" default="Project" /></g:link>  
   <%--      <li><g:link controller='user' >User Manage</g:link>
		<li><g:link controller='user'  action='create'>Register User</g:link>
        <li><g:link controller='industry' >Industry Manage</g:link>
		<li><g:link controller='industry'  action='create'><g:message code="menu.create" default="Create " /> Industry</g:link>
 			<li><g:link action="list" controller="projectOrder">All PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'new']">New PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'processing']">Processing PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'submit']">Submit PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'invoice']">Invoiced PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'finished']">Finished PO List</g:link> --%>
 	</ol>
	</g:ifAnyGranted>

      	  <g:ifAnyGranted role="ROLE_SALES">
	  	<h1><g:message code="menu.manager" default="Manager" /></h1>
	<ol>
		<li><g:link action="list" controller="customer"><g:message code="customer.label" default="Client" /><g:message code="menu.management" default=" Management" /></g:link>
		<li><g:link action="create" controller="customer"><g:message code="menu.create" default="Create " /><g:message code="customer.label" default="Client" /></g:link>
  		<li><g:link action="quotego" controller="project"><g:message code="menu.create" default="Create " /><g:message code="project.label" default="Project" /></g:link>
 		<li><g:link action="list" controller="project"><g:message code="menu.projectinhands" default="Project  In Hands" /></g:link>
  
 	</ol>
	</g:ifAnyGranted>
			  <h1><g:message code="menu.mytask" default="My Task" /></h1>
		   <ol> 
			<li><g:link controller="my" action="index" params="[state:'new']"><g:message code="menu.requestedtasks" default="Requested Tasks" /></g:link>
			<li><g:link controller="my" action="index" params="[state:'processing']"><g:message code="menu.currenttasks" default="Current Tasks" /></g:link>
			<li><g:link controller="my" action="index" params="[state:'submit']"><g:message code="menu.awaitingauth" default="Awaiting Auth" /></g:link>
            
            <g:if test="${!org.springframework.security.context.SecurityContextHolder.context.authentication.principal?.domainClass?.fullTime}">
            
			<li><g:link controller="my" action="index" params="[state:'pass']"><g:message code="menu.readytoinvoice" default="Ready To 
  Invoice" /></g:link>
			<li><g:link controller="my" action="index" params="[state:'invoice']"><g:message code="menu.invoiced" default="Invoiced" /></g:link>
            </g:if>
			<li><g:link controller="my" action="index" params="[state:'finished']"><g:message code="menu.finished" default="Finished" /></g:link>
			</ol>
	<g:ifAnyGranted role="ROLE_USER">

            <h1><g:message code="menu.profiles" default="Profiles" /></h1>
            <ol>
            
			<li><g:link controller="my" action="cv" ><g:message code="menu.uploadcv" default="Upload CV" /></g:link>
			<%--<li><g:link controller="skill" action="index" >My Language</g:link>--%>
			<li><g:link controller="invoiceInfo" action="index" ><g:message code="menu.paymentinfo" default="Payment Info" /></g:link>
			
		   </ol>
		   
     </g:ifAnyGranted>
   
</g:isLoggedIn>
	   <g:isNotLoggedIn>
	   <h1><g:message code="menu.welcome" default="Welcome" /></h1>
		   <ol>
		   <li><g:link action="index" controller="login"><g:message code="default.signin" default="Sign In" /></g:link>
		    <!--<li><g:link action="index" controller="register">Sign Up</g:link>-->
		   </ol>
	   </g:isNotLoggedIn>
 
      </div>
      <div class="span-19 last main">
       <g:layoutBody />
      </div>
      <div class="span-24 last bottom">
© 2007-2008 Lead To Asia Translation &amp; localization Co., Ltd 
<br>Tel: 0085281999847 • Fax: 0085227837978 Email: info@leadtoasia.com • Web:www.leadtoasia.com 
<br>UNIT 1001 FOURSEAS BUILDING 208-212 NATHAN ROAD KOWLOON HONGKONG
      </div>
	 </div>
    </body>
</html>