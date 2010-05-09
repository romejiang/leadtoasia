
class PayNoticeJob {
    def emailerService
    def authenticateService


    //def timeout = 5000l // execute job once in 5 seconds
    static triggers = {
        cron name: 'myTrigger', cronExpression: "0 0 6,13 * * ?"
    }

    def execute() {
        def results
        // execute task
        // 该付款的
        results = ProjectOrder.withCriteria {
            def now = new Date()
            between('invoiceDate', now-30, now-35)
            eq('state', 'invoice')
        }
        results.each{
             def pdflink = "${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/projectOrder/show/" + it.id
              
            def config = authenticateService.securityConfig
            if (config.security.useMail) {
                  def notice = Notice.findByName("ProjectPay")
                if (notice) { 
                    def email = [
                        to: NoticeMail.findAll().mail, // 'to' expects a List, NOT a single email address
                        subject: "[${it?.project?.projectNo}] ${notice.title}",
                        text: notice.content +  pdflink // 'text' is the email body
                    ]
                    emailerService.sendEmails([email])   
                }
			}
        }

        // 该收款的
        results = Project.withCriteria {
            def now = new Date()
            between('invoiceDate', now-25, now-30)
            eq('state', 'invoice')
        }
        results.each{
             def pdflink = "${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/project/show/" + it.id
              
            def config = authenticateService.securityConfig
            if (config.security.useMail) {
                  def notice = Notice.findByName("ProjectReceiving")
                if (notice) { 
                    def email = [
                        to: NoticeMail.findAll().mail, // 'to' expects a List, NOT a single email address
                        subject: "[${it}] ${notice.title}",
                        text: notice.content +  pdflink // 'text' is the email body
                    ]
                    emailerService.sendEmails([email])   
                }
			}
        }
        // 该完结的项目
        results = Project.findAllByDeadlineBetween(new Date() , new Date()+3)
        results.each{
            def config = authenticateService.securityConfig
            if (config.security.useMail) {
                  def notice = Notice.findByName("ProjectDeadline")
                if (notice) { 
                    def email = [
                        to: it?.manager?.mails?.mail, // 'to' expects a List, NOT a single email address
                        subject: "[${it.projectNo}] ${notice.title}",
                        text: notice.content  // 'text' is the email body
                    ]
                    emailerService.sendEmails([email])   
                }
			}
        }
    }
}
