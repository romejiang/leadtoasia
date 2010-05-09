import com.lucastex.grails.fileuploader.UFile


class MyController {

    def authenticateService 
    def emailerService
    def userService
    // 我的po
    def index = {
 
        def user =  authenticateService.userDomain()
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        params.sort = "start"
        params.order = "desc"
        
        log.info user
        if (params.state) {
            [
            title: ["new" : "Requested Tasks",
"processing" : "Current Tasks",
"submit" : "Awaiting Auth",
"pass" : "Ready To  Invoice",
"invoice":"Invoiced List" ,
"finished":"Finished List" ],
            projectOrderInstanceList: ProjectOrder.findAllByVendorAndState(user , params.state ,params),
            projectOrderInstanceTotal: ProjectOrder.countByVendorAndState(user , params.state)]

        }else{
            [projectOrderInstanceList: ProjectOrder.findAllByVendor(user ,params),
            projectOrderInstanceTotal: ProjectOrder.countByVendor(user)]
        }
    }
    // 领取任务
   def activating = {
	def po =   ProjectOrder.get(params.id)
    log.info "my.activating po = ${po}"
	po.state = 'processing';
	if (!po.save()) {
        po.errors.each {
        println it
        }
    }
          
            emailerService.process("ProjectOrderProcessing" , po?.project?.manager?.mails?.mail ){[
                'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
//                'pdflink':pdflink,
                'projectOrder': po,
                'project': po?.project
             ]}


	redirect(action: "index",params: [state:'processing'])
   }
    // 完成任务
   def complete = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (!projectOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "index")
        }
        else {
            [projectOrderInstance: projectOrderInstance]
        }
   }
// 项目完成，上传提交文件
   def upload = {
        log.info "Uploaded PO file with id=${params.ufileId}"
        log.info params.id 
	def projectOrder = ProjectOrder.get(params.id)
    def ufile = UFile.get(params.ufileId)
	if (projectOrder && ufile) {
	    projectOrder.addToAttachments(ufile)
	    projectOrder.save()
	}
    flash.message = flash.message ;
	redirect(action: "complete" , id:params.id)
   }
// 完成工作提交完成
   def finished = {
	def po =   ProjectOrder.get(params.id)
	log.info "my.complete $po"
	po.state = 'submit';
	if (po.save()) { 
            

            emailerService.process("ProjectOrderSubmit" , po?.project?.manager?.mails?.mail ){[
                'to':po?.vendor?.userRealName,
                'projectNo':po?.project?.projectNo,
//                'pdflink':pdflink,
                'projectOrder': po,
                'project': po?.project
             ]}



   }else{
        po.errors.allErrors.each {
            log.error it
        } 
   }
	redirect(action: "index",params: [state:'submit'])
   }
   // 提交账单 invoice
   def invoice = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (projectOrderInstance) {
            [projectOrderInstance: projectOrderInstance]
        }else{
            redirect(action: "index",params: [state:'pass'])
        }
   }
   def invoiced = {
        def projectOrderInstance = ProjectOrder.get(params.id)

        if (projectOrderInstance) {
            projectOrderInstance.state = 'invoice';
            projectOrderInstance.invoiceDate = new Date()

            if (projectOrderInstance.save()) { 
             

                emailerService.process("ProjectOrderInvoice" , projectOrderInstance?.project?.manager?.mails?.mail ){[
                'to':projectOrderInstance?.vendor?.userRealName,
                'projectNo':projectOrderInstance?.project?.projectNo,
//                'pdflink':pdflink,
                'projectOrder': projectOrderInstance,
                'project': projectOrderInstance?.project
             ]}

                return redirect(action: "index",params: [state:'invoice']) 
            }else{
                projectOrderInstance.errors.allErrors.each {
                    log.error it
                } 
            }
        } 
        redirect(action: "index",params: [state:'pass']) 
   }
// 给客户的显示页面
   def show = {
        def projectOrderInstance = ProjectOrder.get(params.id)
        if (!projectOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "index")
        }
        else {
            [projectOrderInstance: projectOrderInstance]
        }
    }
    // 显示为pdf的xml源文件
    def pdf = {
        log.info params.id
        def projectOrderInstance = ProjectOrder.get(new Long(params.id))
        if (!projectOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            [projectOrderInstance: projectOrderInstance,
                pid : params.pid,parentType:params.parentType]
        }
    }

    // 修改密码
	def edit = {

		def person = User.get( authenticateService.userDomain()?.id)
		if (!person) {
			flash.message = "User not found with id "
			redirect action: 'index'
			return
		}

		def result = buildPersonModel(person)
        result.put('mail', userService.mails2String( person.mails))
        return result
	}

	/**
	 * Person update action.
	 */
	def update = {

		def person = User.get(params.id)
		if (!person) {
			flash.message = "User not found with id $params.id"
			redirect action: edit
			return
		}

		long version = params.version.toLong()
		if (person.version > version) {
			person.errors.rejectValue 'version', "person.optimistic.locking.failure",
				"Another user has updated this User while you were editing."
				render view: 'edit', model: buildPersonModel(person)
			return
		}

		def oldPassword = person.passwd
		person.properties = params
		if (!params.passwd.equals(oldPassword)) {
			person.passwd = authenticateService.encodePassword(params.passwd)
		}


        userService.addToMails(params.mail,person)
        if (!person.mails.isEmpty()) {
            person.email = person.mails.toList()[0].mail
            log.info person.mails
        }

		if (person.save()) {
//			Role.findAll().each { it.removeFromPeople(person) }
//			addRoles(person)
			flash.message = "update success!"
			redirect action: 'edit'
		}
		else {
			render view: 'edit', model: buildPersonModel(person)
		}
	}


    // 删除项目附件
    def deleteAttachment = {
        def project = ProjectOrder.get(params.POId)
        if (project) {
       
            def ufile = UFile.get(params.id)
            if (ufile) {
                project.removeFromAttachments(ufile)
                ufile.delete()
                project.save() 
                flash.message = "delete attachment succeed."
            }else{
                flash.message = "not found attachment."
            }
            return redirect(action: params.reaction , id : params.POId)
        }
        redirect(uri: '/')
    }

    // 上传自己的CV简历
    def cv = {
        [user: User.get( authenticateService.userDomain()?.id)]
    }
    def uploadcv = {
        def user = User.get( authenticateService.userDomain()?.id)
        def ufile = UFile.get(params.ufileId)
        if (user && ufile) {
            user.addToAttachments(ufile)
            user.save()
        }
        redirect(action: "cv")
    }

	private Map buildPersonModel(person) {

		List roles = Role.list()
		roles.sort { r1, r2 ->
			r1.authority <=> r2.authority
		}
		Set userRoleNames = []
		for (role in person.authorities) {
			userRoleNames << role.authority
		}
		LinkedHashMap<Role, Boolean> roleMap = [:]
		for (role in roles) {
			roleMap[(role)] = userRoleNames.contains(role.authority)
		}

		return [person: person, roleMap: roleMap]
	}
}
