import grails.converters.JSON

class DtpOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def authenticateService
    def emailerService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        params.sort = "start"
        params.order = "desc"

        if (authenticateService.isLoggedIn()) {
		if (authenticateService.ifAllGranted("ROLE_ADMIN")) { // admin 可以管理所有项目
			log.info "projectOrder.list in ROLE_ADMIN"
			if (params.state){ 
			    return [projectOrderInstanceList: ProjectOrder.findAllByState(params.state ,params),
			    projectOrderInstanceTotal: ProjectOrder.countByState(params.state)]
			}else{
			    return [projectOrderInstanceList: ProjectOrder.list(params),
			    projectOrderInstanceTotal: ProjectOrder.count()]		
			}  
		}else if(authenticateService.ifAllGranted("ROLE_MANAGER")){	// pm 只能访问自己建立的项目
			log.info "projectOrder.list in ROLE_MANAGER"
			 
			def results = ProjectOrder.withCriteria {
				if (params.state){ eq('state',params.state)}
				project{eq('user',authenticateService.userDomain())}

				maxResults(params.max)
				order(params.sort, params.order)
			}
			def counts = ProjectOrder.withCriteria {
				if (params.state){ eq('state',params.state)}
				project{eq('user',authenticateService.userDomain())}
				count('unit')
			}

			return [projectOrderInstanceList: results , projectOrderInstanceTotal: counts]
			 
		}
	} 
	redirect(uri: '/')
    }

    def create = {
        def projectOrderInstance = new ProjectOrder()
        projectOrderInstance.properties = params

        return [projectOrderInstance: projectOrderInstance,
        pid : params.pid,parentType:params.parentType]
    }

    def save = {
//		log.info "total: $params.total"
//		if(!params.total)params.total = 0
        def projectOrderInstance = new ProjectOrder(params)
        
        if (!params.localize) {
      
            projectOrderInstance.errors.rejectValue("project", "noproperties", [message(code: 'projectOrder.label', default: 'ProjectOrder')] as Object[], "Localize  is required!")

            return render(view: "create", model: [projectOrderInstance: projectOrderInstance,
                pid : params.pid,parentType:params.parentType])
        }
        // 父项目
        if (params.pid) {
            projectOrderInstance.project = Project.get(params.pid)
        }
        log.info params.matchs?.size()
        if (projectOrderInstance.save(flush: true)) {


        // 将这个本地化任务，和当前po关联起来
            if(params.localize) {
                if(params.localize in String){
                    params.localize = [params.localize]
                }
                log.info "projectOrder.save $params.localize"         
                params.localize?.each{
                    def loc = Localization.get(it)
                    if (loc) {
                        loc.projectOrder = projectOrderInstance
                        loc.save()
                    }
                }
            } 

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), projectOrderInstance.id])}"
            redirect(action: "show",controller: 'project', id :  params.pid)
        }
        else {
            render(view: "create", model: [projectOrderInstance: projectOrderInstance,
        pid : params.pid,parentType:params.parentType])
        }
    }

    def show = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (!projectOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            [projectOrderInstance: projectOrderInstance,
        pid : params.pid,parentType:params.parentType]
        }
    }

    def edit = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (!projectOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            return [projectOrderInstance: projectOrderInstance,
        pid : params.pid,parentType:params.parentType]
        }
    }

    def update = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (projectOrderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (projectOrderInstance.version > version) {
                    
                    projectOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'projectOrder.label', default: 'ProjectOrder')] as Object[], "Another user has updated this ProjectOrder while you were editing")
                    render(view: "edit", model: [projectOrderInstance: projectOrderInstance,
                        pid : params.pid,parentType:params.parentType])
                    return
                }
            }
            projectOrderInstance.properties = params
            if (!projectOrderInstance.hasErrors() && projectOrderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), projectOrderInstance.id])}"
                redirect(action: "show",controller: 'project', id :  params.pid)
            }
            else {
                render(view: "edit", model: [projectOrderInstance: projectOrderInstance,
        pid : params.pid,parentType:params.parentType])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "show",controller: 'project', id :  params.pid)
        }
    }

    def delete = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (projectOrderInstance) {
            try {
                //删除po拥有的match对象
                if (projectOrderInstance.matchs)  {
                    projectOrderInstance.matchs.toList().each {
                        projectOrderInstance.matchs.remove(it)
                        it.delete()
                    } 
                } 
//清理和本地化任务的关系
                def localization = Localization.findByProjectOrder(projectOrderInstance)
                if (localization) {
                    localization.dtpOrder = null
                    localization.save()
                }

                projectOrderInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
                redirect(action: "show", controller: "project",id : projectOrderInstance?.project?.id)
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
                redirect(action: "show", id: params.id, params : [pid : params.pid,parentType:params.parentType])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
    }

    // ajax 验证 是否是兼职员工
    def checkUser = {
	    def user = User.get(params.id)
         if (user && !user.fullTime) {
//            def pricing = user.quote?.find{
//                params.code == "$it.source-$it.target"
//            }
//            log.info pricing
            render(['success': true, 'message': ''] as JSON)
        }else{
	        render(['success': false] as JSON)
        }
    }
    // ajax 
    def getVendor = {
        if (params.code) {
            log.info params.code
 
            def results = User.findAllByEnabled(true).findAll{user ->
                  params.code.tokenize(',').every{localization ->
                    user?.quote?.any{
                        localization == ("$it.source-$it.target") 
                    }
                  }  
            }
            log.info results
            render(['success': true, 'message':  results] as JSON)
        }else{
        render(['success': false] as JSON)
        }
    }
    // verification 验证项目的状态
    def finished = {
        def po =   ProjectOrder.get(params.id)
        if (po) {
            log.info "projectOrder.finished $po"
            po.state = 'finished';
            po.save(flush: true)
            def config = authenticateService.securityConfig
            if (config.security.useMail) {
                def notice = Notice.findByName("ProjectOrderFinished")
                if (notice) { 
                    def email = [
                        to: [po?.vendor?.email], // 'to' expects a List, NOT a single email address
                        subject: "[${po?.project?.projectNo}] ${notice.title}",
                        text: notice.content // 'text' is the email body
                    ]
                    emailerService.sendEmails([email])   
                }
			}
        }
        redirect(action: "show" , id : params.id)
    }

        // review 验证项目的状态
    def processing = {
        def po =   ProjectOrder.get(params.id)
        if (po) {
            log.info "projectOrder.processing $po"
            po.state = 'processing';
            po.save(flush: true)
            def config = authenticateService.securityConfig
            if (config.security.useMail) {
                def notice = Notice.findByName("ProjectOrderProcessing")
                if (notice) { 
                    def email = [
                        to: [po?.vendor?.email], // 'to' expects a List, NOT a single email address
                        subject:  "[${po?.project?.projectNo}] ${notice.title}",
                        text: notice.content // 'text' is the email body
                    ]
                    emailerService.sendEmails([email])   
                }
			}
        }
        redirect(action: "show" , id : params.id)
    }

        // close 验证项目的状态
    def pass = {
        def po =   ProjectOrder.get(params.id)
        if (po) {
            log.info "projectOrder.pass $po"
            po.state = 'pass';
            po.save(flush: true)
            def config = authenticateService.securityConfig
            if (config.security.useMail) {
                def notice = Notice.findByName("ProjectOrderPass")
                if (notice) { 
                    def email = [
                        to: [po?.vendor?.email], // 'to' expects a List, NOT a single email address
                        subject:  "[${po?.project?.projectNo}] ${notice.title}",
                        text: notice.content // 'text' is the email body
                    ]
                    emailerService.sendEmails([email])   
                }
			}
        }
        redirect(action: "show" , id : params.id)
    }
 
    // 发邮件通知 外部开发人员
    def sendNotice = {
        def po =   ProjectOrder.get(params.id)
        if (po) {

            def pdflink = "${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/my/pdf/${params.id}?${System.currentTimeMillis()}" 
            def noticeInstance = new Notice(params)
            emailerService.process(noticeInstance , po?.vendor?.mails?.mail ){[
                'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
                'pdflink':pdflink,
                'projectOrder': po,
                'project': po?.project
             ]}
            flash.message = "send notice success!" 
        }
        if (params.pid) {
            redirect(action: "show" , controller: "project",id : params.pid )
        }else{
            redirect(action: "show" , id :  params.id)
        }
    }
 
    def  notice = {
        def noticeInstance = Notice.findByName("ProjectOrderNew")
        if (!noticeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notice.label', default: 'Notice'), 'ProjectOrderNew'])}"
            redirect(action: "list")
        }
        else {
            return [noticeInstance: noticeInstance , id : params.id , pid : params.pid]
        }
    }

}
