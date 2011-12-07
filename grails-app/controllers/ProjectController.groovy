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
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
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
                            order("start", "desc")
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


// 销售总监用的，搜索销售人员做的项目
def sales = {

//              return [projectInstanceList:Project.withCriteria() {
//                            and{
//                            isNotNull('sales')
//                              if (params.state) {
//                                eq('state',  params.state)
//                            }
//                            }
//                            order("start", "desc")
//                        }, 
//                    projectInstanceTotal: Project.withCriteria() {
//                            and{
//                            isNotNull('sales')
//                            if (params.state) {
//                                eq('state',  params.state)
//                            }
//                            
//                            }
//                            count("projectNo")
//                        }]

//[1: '本周' , 2:'本月' , 3: '季度' ,4:'全年',5:'所有']
//    Calendar   calendar   =   Calendar.getInstance(); 
//    calendar.set(Calendar.HOUR_OF_DAY ,23)
//    calendar.set(Calendar.MINUTE ,59)
//    Date end = calendar.getTime();
//    Date start = end
//
//    calendar.set(Calendar.HOUR_OF_DAY ,0)
//    calendar.set(Calendar.MINUTE ,0)
//    if (params.datetime) {
//        if (params.int("datetime") == 1) {
//            calendar.set(Calendar.DAY_OF_WEEK,   Calendar.SUNDAY);
//            start = calendar.getTime();
//        }else if(params.int("datetime") == 2){
//            calendar.set(Calendar.DAY_OF_MONTH,   1);
//            start = calendar.getTime();
//        }else if(params.int("datetime") == 3){
//            def m = calendar.get(Calendar.MONTH)
//            def qr = (m/3) as int 
//
//            calendar.set(Calendar.MONTH ,   qr * 3);
//            calendar.set(Calendar.DAY_OF_MONTH,   1);
//            start = calendar.getTime();
//        }else if(params.int("datetime") == 4){
//            calendar.set(Calendar.DAY_OF_YEAR,   1);
//            start = calendar.getTime();
//        }  
//        flash.message =  "从${start.format('yyyy-MM-dd HH:mm')} 到  ${end.format('yyyy-MM-dd HH:mm')}的项目。"
//    }
    Date end  
    Date start  
    def message = '' 
    if (params.datetime && params.startTime && params.endTime) {
        start = Date.parse( "yyyy-M-d HH:mm:ss", params.startTime)
        end = Date.parse( "yyyy-M-d HH:mm:ss", params.endTime)
        message =  "从[${params.startTime}]到[${ params.endTime}]"
    }
    if (params.sale) { 
        message += "${User.get(params.sale.toLong()).userRealName} "
    }
    if (params.state) {
        def state = ['quote' : '报价中', 'processing' : '进行中' ,'finished' : '已完成' , 'invoice' : '等待付款','paid' : '已付款' ,'cancel' : '取消项目' ]
        message += "${state[params.state]}"
    }
    flash.message = message + "的项目。"
//          System.out.println(calendar.get(Calendar.WEEK_OF_YEAR));   //获取是一年的第几周  
//          calendar.set(Calendar.DAY_OF_WEEK,   Calendar.MONDAY);   //将日历翻到这周的周一  
//          System.out.println(calendar.getTime());  
//          calendar.set(Calendar.DAY_OF_WEEK,   Calendar.SUNDAY);   //将日历翻到这周的周日（具体每周是周一开始还是周日，甚至周四周五，都可以设置，方法setFirstDayOfWeek，参数类似）  
//          System.out.println(calendar.getTime());  
//          calendar.add(Calendar.WEEK_OF_YEAR,   1);   //使用add进行增减操作，在“一年的第几周”这一属性在当前值的基础上+1，也就是下一周，上一周则是-1  
//          calendar.set(Calendar.DAY_OF_WEEK,   Calendar.MONDAY);//将日历翻到这周的周一  
//          System.out.println(calendar.getTime());  
//          calendar.set(Calendar.DAY_OF_WEEK,   Calendar.SUNDAY);  
//          System.out.println(calendar.getTime());   

       params.max = 100
        def results = Project.withCriteria {
            and{
                 if (params.sale) {
                    sales{
                        eq('id', params.sale.toLong())
                    }  
                }
                if (params.state) {
                    eq('state',  params.state)
                }
                if (params.datetime) {
                    between("start" , start , end)
                }
   
            }
            order("start", "desc")

        }

        def total = Project.withCriteria {
            and{
                 if (params.sale) {
                    sales{
                        eq('id', params.sale.toLong())
                    }
                } 
                if (params.state) {
                    eq('state',  params.state)
                }
                 if (params.datetime) {
                    between("start" , start , end)
                }
            }
            count('id')
        }


        render(view: "list", model: [projectInstanceList:  results,   projectInstanceTotal:  total ,
             sale: params.sale ,
             state : params.state ])
}
// 管理员和PM用的搜素项目
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



// 管理员和PM用的搜素项目
    def searchBySales = {
        params.max = 100
        def results = Project.withCriteria {
            and{
                eq("sales" , authenticateService.userDomain())
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
                eq("sales" , authenticateService.userDomain())
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

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance])}"
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
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance])}"
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
                projectInstance.attachments?.toList().each {  
                    projectInstance.removeFromAttachments(it)
                    it.delete(flush:true) 
                }
                projectInstance.matchs?.toList().each {   
                    projectInstance.removeFromMatchs(it)
                    it.delete(flush:true) 
                }
 
                def dtp = projectInstance.dtp.collect{it.id}

                projectInstance.dtp?.toList().each {   
//                    projectInstance.dtp.remove(it) 
                    projectInstance.removeFromDtp(it)
                }      

                    
                    dtp.each {   
                         def localization = Localization.get(it)
                         if (localization?.projectOrder) {
                            localization?.projectOrder?.delete(flush:true) 
                         }else{
                            localization?.delete(flush:true)
                        }
                    }
 
                     def task = projectInstance.task.collect{it.id}
                     projectInstance.task?.toList().each {   
//                        projectInstance.task.remove(it) 
                        projectInstance.removeFromTask(it)
                    }     
                    task.each {   
                         def localization = Localization.get(it)
                         if (localization?.projectOrder) {
                            localization?.projectOrder?.delete(flush:true) 
                         }else{
                            localization?.delete(flush:true)
                        }
                    }
                      
 
//                projectInstance.save(flush: true)
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
                (it.projectOrder?.state == 'pass' || it.projectOrder?.state == 'invoice' || it.projectOrder?.state == 'finished') 
            }
            result = result && project?.dtp?.toList().every{
                (it.projectOrder?.state == 'pass' || it.projectOrder?.state == 'invoice' || it.projectOrder?.state == 'finished') 
            }
            flash.message = "Under the project there is an outstanding PO."
            log.info "project.finished  $result~!"
            if (result) {
                project.state = 'finished'
                project.finishedDate = new Date()
                if (project.save(flush:true)) {
                    flash.message = "Project " + project+ " is finished."
                } 
            }

        } 
        redirect(action: "list")
    }

    ///// 取消这个项目
    def cancel = {
         
        def project = Project.get(params.id)
 
        if (project) {
             project.state = "cancel"
             project.save()
        } 
        redirect(action: "show" , id: params.id)

    }
/////  接收销售人员提交的项目
    def accept = {
         
        def project = Project.get(params.id)
 
        if (project) {
             project.state = "processing"
             project.save()

            emailerService.process("ProjectAccept" , project?.sales?.mails?.mail ){[
                'to': project?.sales?.userRealName ,
                'projectNo':project?.projectNo, 
                //'projectOrder': po,
                'project': project
             ]}
        } 
        redirect(action: "show" , id: params.id)

    }
    //将项目设置为已完成支付
    def paid = {
        def project = Project.get(params.id) 
        if (project) {
            project.state = "paid"
            project.invoiceDate = new Date()
            project.save()
        }
        redirect(action: "list",  id: params.id , params: ['state' : 'paid'])
    }


// 给销售人员发邮件
    def toSales = {
        def project = Project.get(params.id)
        if (!project) {
            flash.message = "没有找到项目。"
             redirect(action: "list")
        }
        if (!project?.sales) {
            flash.message = "没有销售人员可以发信。"
            redirect(action: "list")
        }
        def wordcount  = 0
        project?.matchs?.each{match ->
            wordcount += match.wordcount
        }

        
        def noticeInstance = Notice.findByName("ProjectSubmit")
        if (!noticeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notice.label', default: 'Notice'), 'ProjectSubmit'])}"
            redirect(action: "list")
        }
        else {
            return [noticeInstance: noticeInstance , id : params.id , "wordcount": wordcount]
        }
    }

    def sendToSales = {
         def project = Project.get(params.id) 
         
        if (project && (project.state == 'finished' || project.state == 'invoice') ) {
  
             def noticeInstance = new Notice(params)

             emailerService.process(noticeInstance , project?.sales?.mails?.mail ){[
                'to': project?.sales?.userRealName ,
                'projectNo':project?.projectNo, 
                //'projectOrder': po,
                'project': project
             ]}
            //project.state = "invoice"
            project.save()
            flash.message = "send invoice success!" 
        }else{
            flash.message = "Project not finished."
        }

        redirect(action: "list" )  
    }

// 更新项目字数
    def uptotal = {
        
        def project = Project.get(params.id)
        if (!project) {
            flash.message = "没有找到项目。"
            redirect(action: "list")
        } 

        def wordcount  = 0
        project?.matchs?.each{match ->
            wordcount += match.wordcount
        }

        return [ "project" : project , id : params.id , "wordcount": wordcount]
    }
 
    def uptotalTo = {
        def project = Project.get(params.id)

        if (params.wordcount && project) {
//                println params.wordcount
                project?.matchs?.each{match ->
                    match.wordcount = params.int("wordcount")
                    match.save();
                }   

                project?.task?.each{task ->
                    task.amount = params.int("wordcount")
                    task.save();
                }   

                ProjectOrder.findAllByProject(project).each{po ->
                    po.wordcount = params.int("wordcount")
                    po.total = po.wordcount * po.rate
                }
         }

         redirect(action: "list")
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

/// ####################################################
/// ####################################################
/// ####################################################

    def maxId = {
        def ps = Project.list(max:1 , sort:"id" , order:"desc")
        if (ps.size > 0) {
            render(ps[0].id)
        }else{
            render("")
        } 
    }
    
    def clients = {
        def list = Customer.listOrderByName(order : 'asc')

        def result = new StringBuffer()
        result.append("var projects = [")
        list.each{
            result.append("{value: '" + it.id + "',")
            result.append("label: '" + it.name + "'},")
        }
        result.append("];")

        render(text: result.toString() , contentType:"text/json" , encoding:"UTF-8")
    }
}
