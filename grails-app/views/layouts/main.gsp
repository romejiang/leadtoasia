<html>
    <head>
        <title><g:layoutTitle default="Grails" /> Lead To Asia CRM</title>
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
        <div id="grailsLogo" class="logo"><a href="/leadtoasia"><img src="${resource(dir:'images',file:'logo.png')}" alt="leadtoasia" border="0" id="logoimg"  height="50"/></a><span>Lead To Asia Translation & localization Co., Ltd</span>
        <g:isLoggedIn>
        <div class="panel"> 
             
             <g:loggedInUserInfo field="userRealName"/>&nbsp;| 
             <g:link controller="my" action="edit" style="color: #fff">Profiles</g:link>&nbsp;|
            <g:link action="index" controller="logout" style="color: #fff">Logout</g:link>
        </div> 
        </g:isLoggedIn>
        </div>
	 <div class="container">	 
      <div class="span-5 left">
<g:isLoggedIn>
 <g:ifAnyGranted role="ROLE_ADMIN">
	  	  <h1>Administrator</h1>
	  <ol>
		<li><g:link controller='customer' >Client Manage</g:link>
		<li><g:link controller='customer'  action='create'>New Client</g:link>
		<li><g:link controller='project' >Project Manage</g:link>
		<li><g:link controller='project' action='create'>Create Project</g:link>
		<li><g:link controller='user' >User Manage</g:link>
		<li><g:link controller='user'  action='create'>New User</g:link>
		<li><g:link controller='notice' >Notice Manage</g:link>
		<li><g:link controller='notice'  action='create'>Create Notice</g:link>
		<li><g:link controller='lookup'  action='index'>Lookup Manage</g:link>
		<li><g:link controller='lookupValue'  action='index'>Value Manage</g:link>
		<li><g:link controller='role'  action='index'>Role Manage</g:link> 
		<li><g:link controller='requestmap'   action='index'>Request Map</g:link> 
	    <li><g:link controller='noticeMail'   >NoticeMail Manage</g:link> 
		<li><g:link controller='noticeMail'   action='create'>Create NoticeMail</g:link> 
		<li><g:link controller='exchangeRate' action='index'>Exchange Rate </g:link> 
		<li><g:link controller='exchangeRate' action='exchange'>Test Exchange</g:link> 
	 </ol>
     	  	  <h1>Report</h1>
	  <ol> 
		<li><g:link controller='report' action="build">Build Report</g:link> 
		<li><g:link controller='report' >Last Report</g:link>
		<li><g:link controller='report'  action='history'>History Report</g:link>
	 </ol>
	</g:ifAnyGranted>

  	  <g:ifAnyGranted role="ROLE_MANAGER">
	  	<h1>Manager</h1>
	<ol>
		<li><g:link action="list" controller="customer">Client Manage</g:link>
		<li><g:link action="create" controller="customer">New Client</g:link>
  		<li><g:link action="start" controller="project">New Project</g:link>
 		<li><g:link action="list" controller="project">Project In Hands</g:link>
        <li><g:link action="list" controller="project" params="[state: 'finished']">Finished Project</g:link>  
        <li><g:link action="list" controller="project" params="[state: 'invoice']">Wait Pay Project</g:link>  
        <li><g:link action="list" controller="project" params="[state: 'paid']">Paid Project</g:link>  
 <!-- 			<li><g:link action="list" controller="projectOrder">All PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'new']">New PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'processing']">Processing PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'submit']">Submit PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'invoice']">Invoiced PO List</g:link>
 		<li><g:link action="list" controller="projectOrder" params="[state: 'finished']">Finished PO List</g:link> -->
 	</ol>
	</g:ifAnyGranted>
			  <h1>My Task</h1>
		   <ol> 
			<li><g:link controller="my" action="index" params="[state:'new']">Requested Tasks</g:link>
			<li><g:link controller="my" action="index" params="[state:'processing']">Current Tasks</g:link>
			<li><g:link controller="my" action="index" params="[state:'submit']">Awaiting Auth</g:link>
			<li><g:link controller="my" action="index" params="[state:'pass']">Ready To 
  Invoice</g:link>
			<li><g:link controller="my" action="index" params="[state:'invoice']">Invoiced</g:link>
			<li><g:link controller="my" action="index" params="[state:'finished']">Finished</g:link>
			</ol>
	<g:ifAnyGranted role="ROLE_USER">

            <h1>Profiles</h1>
            <ol>
            
			<li><g:link controller="my" action="cv" >Upload CV</g:link>
			<li><g:link controller="skill" action="index" >My Language</g:link>
			<li><g:link controller="invoiceInfo" action="index" >Payment Info</g:link>
			
		   </ol>
		   
     </g:ifAnyGranted>
   
</g:isLoggedIn>
	   <g:isNotLoggedIn>
	   <h1>Welcome</h1>
		   <ol>
		   <li><g:link action="index" controller="login">Sign In</g:link>
		   <li><g:link action="index" controller="register">Sign Up</g:link>
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