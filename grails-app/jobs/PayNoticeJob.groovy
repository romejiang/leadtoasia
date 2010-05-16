
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
  
              emailerService.process("ProjectPay" , NoticeMail.findAll().mail ){[
                'to': "manager" ,
                'projectNo':it?.project?.projectNo,
                'pdflink':pdflink,
                'projectOrder': it,
                'project': it?.project
             ]}
        }

        // 该收款的
        results = Project.withCriteria {
            def now = new Date()
            between('invoiceDate', now-25, now-30)
            eq('state', 'invoice')
        }
        results.each{
             def pdflink = "${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/project/show/" + it.id
            

             emailerService.process("ProjectReceiving" , NoticeMail.findAll().mail ){[
                'to': "manager" ,
                'projectNo':it?.projectNo,
                'pdflink':pdflink, 
                'project': it
             ]} 
        }
        // 该完结的项目
        results = Project.findAllByDeadlineBetween(new Date() , new Date()+3)
        results.each{

             emailerService.process("ProjectDeadline" , it?.manager?.mails?.mail ){[
                'to': it?.manager?.userRealName ,
                'projectNo':it?.project?.projectNo,  
                'project': it
             ]}
            
        }
    }
}
