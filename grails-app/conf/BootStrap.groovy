import org.grails.plugins.springsecurity.service.AuthenticateService
import java.util.Locale
import grails.util.Environment

class BootStrap {
     def authenticateService 
     def init = { servletContext ->


            def roleAdmin = new Role(	authority: 'ROLE_ADMIN' ,description :'ROLE_ADMIN')
            def roleManager = new Role(	authority: 'ROLE_MANAGER' ,description :'ROLE_MANAGER')

            def roleSales = new Role(	authority: 'ROLE_SALES' ,description :'ROLE_SALES')
            def roleSalesDirector = new Role(	authority: 'ROLE_SALES_DIRECTOR' ,description :'ROLE_SALES_DIRECTOR')

            def roleFinancial = new Role(	authority: 'ROLE_FINANCIAL_OFFICER' ,description :'ROLE_FINANCIAL_OFFICER')
            def roleVendorManager  = new Role(	authority: 'ROLE_VENDOR_MANAGER' ,description :'ROLE_VENDOR_MANAGER')

            def roleTranslator = new Role(	authority: 'ROLE_USER' ,description :'ROLE_USER')
 

              roleAdmin.save()
              roleManager.save()
              roleSales.save()
              roleSalesDirector.save()
              roleTranslator.save()
              roleFinancial.save()
              roleVendorManager.save()

            def notices = ["ProjectOrderNew",
            "ProjectOrderProcessing",
            "ProjectOrderSubmit",
            "ProjectOrderPass",
            "ProjectOrderInvoice",
            "ProjectOrderFinished",
            "ProjectInvoice",
            "ProjectPay",
            "ProjectReceiving",
            "ProjectDeadline",
            "ProjectOrderBack",
            "ProjectQuote",
            "ProjectAccept",
            "ProjectSubmit"
            ]

            notices.each{
                def notice = Notice.findByName(it)
                if (!notice) {
                    new Notice( name: it ,
                                        title: it ,
                                        content: it).save(flush:true)
                }
            }


        switch (Environment.current) {
            case Environment.DEVELOPMENT:
                System.out = new  PrintStream(System.out, true, "gbk") 

             def admin = new User(
                                            username: 'admin',
                                            userRealName: 'admin',
                                            passwd: authenticateService.encodePassword('123123'),
                                            tel:"123123",
                                            mails : [new Email(mail: 'admin@mail.com')],
                                            email: 'admin@mail.com')
            def manager = new User(
                                            username: 'manager',
                                            userRealName: 'manager',
                                            passwd: authenticateService.encodePassword('123123'),
                                            tel:"123123",
                                            mails : [new Email(mail: 'manager@mail.com')],
                                            
                                            email: 'manager@mail.com')

             def sales = new User(
                                            username: 'sales',
                                            userRealName: 'sales',
                                            passwd: authenticateService.encodePassword('123123'),
                                            tel:"123123",
                                            mails : [new Email(mail: 'sales@mail.com')], 
                                            email: 'sales@mail.com')

            def salesDirector = new User(
                                            username: 'salesDirector',
                                            userRealName: 'salesDirector',
                                            passwd: authenticateService.encodePassword('123123'),
                                            tel:"123123",
                                            mails : [new Email(mail: 'salesDirector@mail.com')], 
                                            email: 'salesDirector@mail.com')

           def financial = new User(
                                            username: 'financial',
                                            userRealName: 'financial',
                                            passwd: authenticateService.encodePassword('123123'), 
                                            tel:"123123",
                                            mails : [new Email(mail: 'financial@mail.com')], 
                                            email: 'financial@mail.com').save()

           def vendorManager = new User(
                                            username: 'vendorManager',
                                            userRealName: 'vendorManager',
                                            passwd: authenticateService.encodePassword('123123'), 
                                            tel:"123123",
                                            mails : [new Email(mail: 'vendorManager@mail.com')], 
                                            email: 'vendorManager@mail.com').save()

            def translator = new User(
                                            username: 'user',
                                            userRealName: 'translator',
                                            passwd: authenticateService.encodePassword('123123'), 
                                            tel:"123123",
                                            mails : [new Email(mail: 'translator@mail.com')],

                                            email: 'translator@mail.com')
            def translator2 = new User(
                                            username: 'user2',
                                            userRealName: 'translator',
                                            passwd: authenticateService.encodePassword('123123'), 
                                            tel:"123123",
                                            mails : [new Email(mail: 'translator2@mail.com')],

                                            email: 'translator2@mail.com',
					    fullTime:false)

//              roleAdmin.addToPeople(admin).save()
//              roleManager.addToPeople(manager).save()
//
//              roleSales.addToPeople(sales).save()
//              roleSalesDirector.addToPeople(salesDirector).save()
//
//              roleTranslator.addToPeople(translator).save()
//              roleTranslator.addToPeople(translator2).save()
//
//              roleFinancial.addToPeople(financial).save()
//              roleVendorManager.addToPeople(vendorManager).save()


            break
            case Environment.PRODUCTION:


                def admin = new User(
                                            username: 'admin',
                                            userRealName: 'admin',
                                            passwd: authenticateService.encodePassword('123123'),
                                            tel:"123123",
                                            mails : [new Email(mail: 'admin@mail.com')],
                                            email: 'admin@mail.com')

                roleAdmin.addToPeople(admin).save()

            break
        }
 

//	      def customer = new Customer(      name: 'google',
//		       country : 'usa',
//		       contact : '23423').save()
//
//		def pricing = new Pricing(  sourceAndTarget : 'en-hk' ,
//		      price : 12.0 ,
//		      customer : customer).save()
//		def pricing2 = new Pricing(  sourceAndTarget : 'en-zh' ,
//		      price : 12.0 ,
//		      customer : customer).save()
     }
     def destroy = {
     }
} 