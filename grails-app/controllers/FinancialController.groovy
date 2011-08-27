 
class FinancialController {
    def authenticateService
    def emailerService

    def projectOrder = { 
            params.max = Math.min(params.max ? params.max.toInteger() : 20,  100)
 
            params.state = params.state? params.state : "invoice"

            if (authenticateService.isLoggedIn()) {
                if (authenticateService.ifAllGranted("ROLE_FINANCIAL_OFFICER")) { // admin 可以管理所有项目
                    log.info "Financial.projectOrder in ROLE_FINANCIAL_OFFICER"
            
//                    return [projectOrderInstanceList: ProjectOrder.findAllByState(params.state ,params),
//                    projectOrderInstanceTotal: ProjectOrder.countByState(params.state)]

                     return [projectOrderInstanceList: ProjectOrder.withCriteria() {
                            and{
                                vendor{
                                    eq('fullTime', false)
                                }
                                eq('state', params.state)
                            }
                            order("start", "desc")
                        }, 
                            projectOrderInstanceTotal: ProjectOrder.withCriteria() {
                            and{
                                vendor{
                                    eq('fullTime', false)
                                }
                                eq('state', params.state)
                            }
                            count("id")
                        }]
            
                }
            } 
        redirect(uri: '/') 
    }
    def internal = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.sort = "start"
        params.order = "desc"
        params.state = params.state ? params.state : "invoice" 
        if (authenticateService.isLoggedIn()) {
             if(authenticateService.ifAllGranted("ROLE_FINANCIAL_OFFICER")){	
                log.info "project.list in ROLE_FINANCIAL_OFFICER"
                
                    return [projectInstanceList: Project.findAllByGlobalAndState(false,  params.state,params), 
                    projectInstanceTotal: Project.countByGlobalAndState(false ,  params.state)]

                     
                 
            } 
        }
	    redirect(uri: '/')
    }

    def external = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.sort = "start"
        params.order = "desc"
        params.state = params.state ? params.state : "invoice" 
        if (authenticateService.isLoggedIn()) {
             if(authenticateService.ifAllGranted("ROLE_FINANCIAL_OFFICER")){	
                log.info "project.list in ROLE_FINANCIAL_OFFICER"
              
                    return [projectInstanceList: Project.findAllByGlobalAndState(true,  params.state,params), 
                    projectInstanceTotal: Project.countByGlobalAndState(true ,  params.state)]
                 
            } 
        }
	    redirect(uri: '/')
    }

    def test = { 
         params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.sort = "start"
        params.order = "desc"
 
        if (authenticateService.isLoggedIn()) {
             if(authenticateService.ifAllGranted("ROLE_FINANCIAL_OFFICER")){	 
                    return [projectInstanceList: Project.findAllByTest(true,  params.state,params), 
                    projectInstanceTotal: Project.countByTest(true ,  params.state)] 
            } 
        }
	    redirect(uri: '/')
    }

    def paidOrder = {
    
        def po =   ProjectOrder.get(params.id)
        if (po) {
            log.info "projectOrder.finished $po"
            po.state = 'finished'
            po.invoiceDate = new Date()
            po.save(flush: true)

             emailerService.process("ProjectOrderFinished" , po?.vendor?.mails?.mail ){[
                'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
                'projectOrder': po,
                'project': po?.project
             ]}
             flash.message = "为[${po.vendor}]付款成功！"
             return redirect(action: "projectOrder")
        }
        flash.message = "没有找到项目id为${params.id}！"
        redirect(action: "projectOrder")
    
    }
    def paid = { 
        def project = Project.get(params.id) 
        if (project) {
            project.state = "paid"
            project.invoiceDate = new Date()
            project.save()
        }
        redirect(action: params.callback)
    
    }
    def index = { }
}

//
//		<li><g:link action="po" controller="financial">未付款任务</g:link>
//		<li><g:link action="po" controller="financial">已付款的任务</g:link>
//
//		<li><g:link action="internal" controller="financial">未付款国内项目</g:link>
//		<li><g:link action="external" controller="financial">未付款国际项目</g:link>
//  		<li><g:link action="test" controller="financial">所有测试项目</g:link>
// 		<li><g:link action="internal" controller="financial">已付款国内项目</g:link>
// 		<li><g:link action="external" controller="financial">已付款国际项目</g:link>