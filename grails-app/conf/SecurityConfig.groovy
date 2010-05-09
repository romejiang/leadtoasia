import javax.net.ssl.SSLSocketFactory

security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true

	loginUserDomainClass = "User"
	authorityDomainClass = "Role"
	requestMapClass = "Requestmap"

    adminRole = 'ROLE_ADMIN'
//    professionRole = 'ROLE_PROFESSION'
//
//    //ajaxLoginFormUrl = '/login/authAjax'

    loginFormUrl = '/login/index'
    defaultTargetUrl = '/login/loginsuccess'
//    loginFormUrl = '/login/index'
//    defaultTargetUrl = '/login/loginsuccess'
//    //
      useMail = true
      mailHost = 'smtp.xinnetdns.com'
      mailUsername = 'info@leadtoasia.com'
      mailPassword = 'leadtoasia770310'
      mailProtocol = 'smtp'
      mailFrom = 'info@leadtoasia.com'
      //mailPort = 465

//        grail.mail.host = "smtp.gmail.com"
//        grail.mail.port = 465
//        grail.mail.username = "abc@gmail.com"
//        grail.mail.password = "abc123"
//        javaMailProperties = ["mail.smtp.auth":"true",
//        "mail.smtp.socketFactory.port":"587",
//        "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
//        "mail.smtp.socketFactory.fallback":"false"]
        javaMailProperties = ["mail.smtp.auth":"true", 					   
        //"mail.smtp.socketFactory.port":"465",
        //"mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
        //"mail.smtp.starttls.enable":"true",
        "mail.smtp.socketFactory.fallback":"false"]

//    // user caching
    cacheUsers = false
}
