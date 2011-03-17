import java.text.*
import com.lucastex.grails.fileuploader.UFile
import grails.converters.JSON


class ProjectController {

    static allowedMethods = [save: "POST", update: "POST"]

    def authenticateService
    def emailerService

    def projectService

    def index = {
        redirect(action: "list", params: params)
    }
// 不同的用户和查看不同状态的项目
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "start"
        params.order = "desc"
        if (authenticateService.isLoggedIn()) {
            if (authenticateService.ifAllGranted("ROLE_ADMIN")) {
                log.info "project.list in ROLE_ADMIN"
                return [projectInstanceList: Project.list(params), projectInstanceTotal: Project.count()]    
            }else if(authenticateService.ifAllGranted("ROLE_MANAGER")){	
                log.info "project.list in ROLE_MANAGER"
                if (params.state) {
                    return [projectInstanceList: Project.findAllByManagerAndState(authenticateService.userDomain(),  params.state,params), 
                    projectInstanceTotal: Project.countByManagerAndState(authenticateService.userDomain() ,  params.state)]
                }else{
                    return [projectInstanceList:Project.withCriteria() {
                            and{
                            eq('manager', authenticateService.userDomain())
                            ne('state', 'paid')
                            }
                        }, 
                    projectInstanceTotal: Project.withCriteria() {
                            and{
                            eq('manager', authenticateService.userDomain())
                            ne('state', 'paid')
                            }
                            count("projectNo")
                        }]
                }
            }else if(authenticateService.ifAllGranted("ROLE_SALES_DIRECTOR")){	
                return [projectInstanceList: Project.findAllBySalesIsNotNull( params), 
                    projectInstanceTotal: Project.countBySalesIsNotNull()]
            } else if(authenticateService.ifAllGranted("ROLE_SALES")){	
                return [projectInstanceList: Project.findAllBySales(authenticateService.userDomain(),  params), 
                    projectInstanceTotal: Project.countBySales(authenticateService.userDomain() )]
            }
        }
	    redirect(uri: '/')
    }

    def search = {
        params.max = 100
        def results = Project.withCriteria {
            and{
                eq("manager" , authenticateService.userDomain())
                if (params.client) {
                    customer{
                        eq('id', params.client.toLong())
                    }  
                }
                if (params.keyword) {
                    ilike('content' , '%' +params.keyword+ '%')
                } 
            }
            order("start", "desc")

        }

        def total = Project.withCriteria {
            and{
                eq("manager" , authenticateService.userDomain())
                if (params.role && params.role != '') {
                    customer{
                        eq('id', params.client.toLong())
                    }  
                }
                if (params.keyword) {
                    ilike('content' , '%' +params.keyword+ '%') 
                } 
            }
            count('id')
        }
        render(view: "list", model: [projectInstanceList:  results,   projectInstanceTotal:  total ,
            keyword: params.keyword , client: params.client ])
    }

    def create = {
        def projectInstance = new Project()
        projectInstance.properties = params
        return [projectInstance: projectInstance]
    }

    def save = {
        log.info params.unit
        def projectInstance = new Project(params)
        if (!params.projectNo) {
            projectInstance.projectNo = new Date().format("yyyyMMdd-")
        }
      
        projectInstance.manager = authenticateService.userDomain()
        log.info projectInstance.manager

        if (projectInstance.save(flush: true)) {
            if (!params.projectNo) {
                projectInstance.projectNo += new DecimalFormat("0000").format(projectInstance.id)
            }

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])}"
            redirect(action: "show", id: projectInstance.id)
        }
        else {
            projectInstance.projectNo = ''
            render(view: "create", model: [projectInstance: projectInstance])
        }
    }

    def show = {
        log.info params.id
        def projectInstance = Project.get(params.id)
        if (!projectInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
        else {
        
            [projectInstance: projectInstance]
        }
    }

    def edit = {
        def projectInstance = Project.get(params.id)
        if (!projectInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [projectInstance: projectInstance]
        }
    }

    def update = {
        def projectInstance = Project.get(params.id)
        if (projectInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (projectInstance.version > version) {
                    
                    projectInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'project.label', default: 'Project')] as Object[], "Another user has updated this Project while you were editing")
                    render(view: "edit", model: [projectInstance: projectInstance])
                    return
                }
            }
            projectInstance.properties = params
            if (!projectInstance.hasErrors() && projectInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])}"
                redirect(action: "show", id: projectInstance.id)
            }
            else {
                render(view: "edit", model: [projectInstance: projectInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def projectInstance = Project.get(params.id)
        if (projectInstance) {
            try {
//                projectInstance.attachments?.each {   
//                    it.delete(flush:true)
//                }
//                projectInstance.matchs?.each {   
//                    it.delete(flush:true)
//                }
                if (projectInstance.dtp) {
                     projectInstance.dtp.toList().each {   
                        projectInstance.dtp.remove(it)
                        it?.projectOrder?.delete(flush:true) 
                        it.delete(flush:true)
                    }                   
                }
                if (projectInstance.task) {
                     projectInstance.task.toList().each {   
                        projectInstance.task.remove(it)
                        it?.projectOrder?.delete(flush:true) 
                        it.delete(flush:true)
                    }                   
                }
     
                projectInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
    }
// 上传处理页面
    def upload = {
        log.info "Uploaded file with id=${params.ufileId}"
        log.info params.pid 
        def project = Project.get(params.pid)
        def ufile = UFile.get(params.ufileId)
        if (project && ufile) { 
            project.addToAttachments(ufile)
            project.save()
	    }
        flash.message = flash.message ;
	    redirect(action: "show" , id:params.pid)
    }
    // 生成给客户的pdf账单
    def pdf = {
	    log.info params.id
        def project = Project.get(params.id)
        log.info project
        if (project) {
            [projectInstance: project]
        }else{
            redirect(action: "show", id: params.id)
        }
    }
    
    // 检查项目完成标志，需要手动出发
    def finished = {
	    log.info params.id
        def project = Project.get(params.id)
 
        if (project) {
        
            def result = project?.task?.toList().every{
                (it.projectOrder?.state == 'invoice' || it.projectOrder?.state == 'finished') 
            }
            result = result && project?.dtp?.toList().every{
                (it.projectOrder?.state == 'invoice' || it.projectOrder?.state == 'finished') 
            }
            flash.message = "Under the project there is an outstanding PO."
            log.info "project.finished  $result~!"
            if (result) {
                project.state = 'finished'
                
                if (project.save(flush:true)) {
                    flash.message = "Project " + project+ " is finished."
                } 
            }
        } 
        redirect(action: "list")
    }

    def paid = {
        def project = Project.get(params.id) 
        if (project) {
            project.state = "paid"
            project.invoiceDate = new Date()
            project.save()
        }
        redirect(action: "list",  id: params.id , params: ['state' : 'paid'])
    }

        // 给客户发送invoice
    def sendInvoice = {
        def project = Project.get(params.id) 
        if (project && (project.state == 'finished' || project.state == 'invoice') ) {

             def noticeInstance = new Notice(params)

             def pdflink = "${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}/project/pdf/${params.id}?${System.currentTimeMillis()}" 
                emailerService.process(noticeInstance , project?.customer?.mails?.mail ){[
                'to': project?.customer?.contact ,
                'projectNo':project?.projectNo,
                'pdflink':pdflink,
                //'projectOrder': po,
                'project': project
             ]}
            project.state = "invoice"
            project.save()
            flash.message = "send invoice success!" 
        }else{
            flash.message = "Project not finished."
        }

        redirect(action: "list" )  
    }
    def  invoice = {
        def noticeInstance = Notice.findByName("ProjectInvoice")
        if (!noticeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notice.label', default: 'Notice'), 'ProjectInvoice'])}"
            redirect(action: "list")
        }
        else {
            return [noticeInstance: noticeInstance , id : params.id]
        }
    }
// ajax 获取 客户 定价信息的json
    def getPricing = {
        log.info params.cid
        def customer = Customer.get(params.cid)
        if (customer) {
            def result = customer?.quote.find{
                log.info "db:" + it.source +  it.target +    it.type  
                log.info "params:" +   params.source + params.target + params.type

                it.source == params.source && it.target == params.target &&  it.type == params.type
            }
            if(!result)result = false
            return render(['success': true, 'message': result ] as JSON)
        }
        return render(['success': false])
    }

// 删除项目附件
    def deleteAttachment = {
        def project = Project.get(params.projectId)
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
            return redirect(action: 'show' , id : params.projectId)
        }
        redirect(uri: '/')
    }
    // ===========================================
    // ============ Flow =========================
    // ===========================================
    def start = {
        redirect(action:"wizard")
    }
 

    def  wizardFlow = {
        init{
            action {
                // 初始化一些flow中使用到的数据
                //1.project 
                flow.projectInstance = new Project()

                if(authenticateService.ifAllGranted("ROLE_SALES")){
                    flow.projectInstance.global = false;
                }
                
                // 2.match var rate = [15,15,15,50,50,100,100];
                flow.matchs = [ new Match(discount: 25),
                                        new Match(discount: 25),
                                        new Match(discount: 25),
                                        new Match(discount: 50),
                                        new Match(discount: 50),
                                        new Match(discount: 100),
                                        new Match(discount: 100)]
                flow.matchCount = 0

                // 3.task
                def languageCode = org.grails.plugins.lookups.Lookup.codeList('Language')
                def localizationList = languageCode.collect{ code->
                    new Localization(target: code.code) //,type : 'word'
                }
                flow.localizationInstanceList = localizationList
                // 4.dtp
                def DTPList = languageCode.collect{ code->
                    new Localization(target: code.code  )//,type : 'page'
                }
                flow.DTPInstanceList = DTPList
                flow.source = languageCode.toList()[0].code
                // 5.file

               
                 [ userId : authenticateService.userDomain().id] 
            }
            on("success").to "project"

        }
        project{
            on("next"){
                // 获取项目信息，但生成项目号
                def projectInstance = new Project(params)
                flow.projectInstance = projectInstance
                if (!params.projectNo) {
                    projectInstance.projectNo = 'nothing'
                }
                 if(authenticateService.ifAllGranted("ROLE_SALES")){	
                    projectInstance.sales = authenticateService.userDomain()
                }else{ 
                    projectInstance.manager = authenticateService.userDomain()
                }
                if (projectInstance.validate()) {
 
                }
                else {
                     
                    return  error()
                }

            }.to "match"
        }
        match{
            
            on("previous").to "project"
            on("next"){
            // 获取匹配信息。
                def  upm = []
                 
                params.wordcount.eachWithIndex{ wc , i ->
               
                    log.info wc 
                    log.info params.match[i]
                    log.info params.discount[i] 
                    if (!wc)wc = 0
                    upm.add(   new Match(wordcount : wc , match : params.match[i] ,discount :  params.discount[i] ) )
                    
                }
                flow.matchs  = upm 
                flow.matchCount = params.total
                log.info "project.wizard.match params.total  = ${params.total}"
 
            }.to "task"
        }
        task{
            on("previous").to "match"
            on("next"){
            // 获取本地化任务
                def localizationList = []
                flow.source = params.source
                params.price.eachWithIndex{ obj , i ->
                
                    if (!obj)obj = 0
                    localizationList.add(new Localization(
                        source : params.source ,
                        target : params.target[i],
                        price : obj , 
                        type : params.type[i] ,
                        amount : params.amount[i] ,
                        unit : params.unit[i]
                    ))
                }

                flow.localizationInstanceList = localizationList
                log.info "wizard localization list = " + flow.localizationInstanceList
            
            }.to "dtp"
        }
        dtp{
            on("previous").to "task"
            on("next"){
                        // 获取本地化任务
                def localizationList = []
                //flow.source = params.source
                params.price.eachWithIndex{ obj , i ->
                
                    if (!obj)obj = 0
                    localizationList.add(new Localization(
                        source : flow.source ,
                        target : params.target[i],
                        price : obj , 
                        type : params.type[i] ,
                        amount : params.amount[i] ,
                        unit : params.unit[i]
                    ))
                }

                flow.DTPInstanceList = localizationList
                log.info "wizard dtp list = " + flow.DTPInstanceList
            
            }.to "review"
        }
        review{
            on("previous").to "dtp"
            on("finished"){
                // end ，完成
          
                projectService.finish(flow)
           
                //log.info "flow finished project id: ${flow.projectId} / ${flow.projectInstance.id}"
            }.to "finish"
            on(Exception).to "review"
        }
        finish{
            //log.info "flow finish project id: ${flow.projectId} / ${flow.projectInstance.id}"
//            redirect(controller:"project", action:"show", id : flow.projectId)
            redirect(controller:"project", action:"list")
        }


    }
}
