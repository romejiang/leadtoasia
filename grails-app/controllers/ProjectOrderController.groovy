import grails.converters.JSON

class ProjectOrderController {

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
				project{eq('manager',authenticateService.userDomain())}

				maxResults(params.max)
				order(params.sort, params.order)
			}
			def counts = ProjectOrder.withCriteria {
				if (params.state){ eq('state',params.state)}
				project{eq('manager',authenticateService.userDomain())}
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
 
        def vendors= User.withCriteria {
            and{
                eq('enabled' , true)
                quote{
                    eq('source',  projectOrderInstance.localization?.source)
                    eq('target',  projectOrderInstance.localization?.target)
                }
            }
        }
  
        return [projectOrderInstance: projectOrderInstance,
         parentType:params.parentType , vendors : vendors]
    }

    def save = {
	 
        def projectOrderInstance = new ProjectOrder(params)
 
        log.info params.matchs?.size()
        if (projectOrderInstance.save(flush: true)) {
 
            /// 保存给free lance 的报价和折扣
            // word计费方式才需要保持匹配率
            if (params.type == 'word') {
                 
                if (params.matchid?.size() > 0) {

                    params.matchid?.eachWithIndex{mid , i ->
                        def p_match = Match.get(mid)
                        def po_match = new Match( wordcount: p_match.wordcount ,
                               match: p_match.match,
                               discount: params.matchs[i])
                        projectOrderInstance.addToMatchs(po_match)
                        po_match.save()
                    }
                    
                }
            }
            projectOrderInstance.save()
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), projectOrderInstance.id])}"
            redirect(action: "show",controller: 'project', id :  params.project.id)
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
                redirect(action: "show",controller: 'project', id : projectOrderInstance.project?.id)
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
//                def localization = projectOrderInstance.localization
//                if (localization) {
//                    localization.projectOrder = null
//                    localization.save()
//                }
                projectOrderInstance.localization = null
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
        log.info params.code
        if (user && !user.fullTime) {
            def pricing = user.quote?.find{
                params.code == "$it.source-$it.target"
            }
            log.info pricing
            render(['success': true, 'message':  pricing] as JSON)
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
            po.state = 'finished'
            po.invoiceDate = new Date()
            po.save(flush: true)
   
             emailerService.process("ProjectOrderFinished" , po?.vendor?.mails?.mail ){[
                'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
//                'pdflink':pdflink,
                'projectOrder': po,
                'project': po?.project
             ]}
             return redirect(controller: 'project',action: "show" , id : po?.project?.id)
        }
        redirect(action: "show" , id : params.id)
    }

    def  goback = {
        def noticeInstance = Notice.findByName("ProjectOrderBack")
        if (!noticeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notice.label', default: 'Notice'), 'ProjectOrderNew'])}"
            redirect(action: "list")
        }
        else {
            return [noticeInstance: noticeInstance , id : params.id , pid : params.pid]
        }
    }
        // review 验证项目的状态
    def processing = {
  
        def po =   ProjectOrder.get(params.id)
        if (po) {
            log.info "projectOrder.processing $po"
            po.state = 'processing';
            po.save(flush: true)

             def noticeInstance = new Notice(params)
            emailerService.process(noticeInstance ,  po?.vendor?.mails?.mail){[
               'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
//                'pdflink':pdflink,
                'projectOrder': po,
                'project': po?.project
             ]}
            flash.message = "send back notice success!" 
        }
        if (params.pid) {
            redirect(action: "show" , controller: "project",id : params.pid )
        }else{
            redirect(action: "show" , id :  params.id)
        }
    }

        // close 验证项目的状态
    def pass = {
        def po =   ProjectOrder.get(params.id)
        if (po) {
            log.info "projectOrder.pass $po"
            if (po.vendor.fullTime) {
               po.state = 'finished'; 
            }else{
                po.state = 'pass'; 
            }
        
            po.save(flush: true)
           

            emailerService.process("ProjectOrderPass" , po?.vendor?.mails?.mail ){[
                'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
//                'pdflink':pdflink,
                'projectOrder': po,
                'project': po?.project
             ]}

            return redirect(controller: 'project',action: "show" , id : po?.project?.id)
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
