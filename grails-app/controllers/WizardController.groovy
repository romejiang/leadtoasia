 

class WizardController {
    def authenticateService
  
    def projectService
    def emailerService

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
                flow.projectId = flow?.projectInstance?.id
                redirect(controller:"project", action:"show", id : flow.projectId)
            }.to "finish"
            on(Exception).to "review"
        }
        finish{
//            log.info "flow finish project id: ${flow.projectId} / ${flow.projectInstance.id}"
//            redirect(controller:"project", action:"show", id : flow.projectId)
//            redirect(controller:"project", action:"list")
        } 
    }
//


//############################################################################
//############################################################################
//############################################################################

    def quotego = {
        redirect(action:"quote")
    }
    def  quoteFlow = {
        init{
            action {
                // 初始化一些flow中使用到的数据
                //1.project 
                flow.projectInstance = new Project()
 
                flow.projectInstance.global = false;
                flow.projectInstance.state = "quote";
                
                // 2.match var rate = [15,15,15,50,50,100,100];
                flow.matchs = [ new Match(discount: 100)]
                flow.matchCount = 0

                // 3.task
                def languageCode = org.grails.plugins.lookups.Lookup.codeList('Language')
                def localizationList = languageCode.collect{ code->
                    new Localization(target: code.code) //,type : 'word'
                }
                flow.localizationInstanceList = localizationList
           
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


                def  upm = [] 
                upm.add(   new Match(wordcount : params.matchCount , match : 'No match' ,discount : 100) )
                flow.matchs  = upm 
                flow.matchCount = params.matchCount
 
                if (projectInstance.validate()) {
 
                }
                else {
                     
                    return  error()
                }

            }.to "task"
        } 
        task{
            on("previous").to "project"
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
            
            }.to "review"
        } 
        review{
            on("previous").to "task"
            on("finished"){
                // end ，完成
          
                projectService.finish(flow)
           
                //log.info "flow finished project id: ${flow.projectId} / ${flow.projectInstance.id}"
            
                emailerService.process("ProjectQuote" , flow?.projectInstance?.manager?.mails?.mail ){[
                    'to': flow?.projectInstance?.manager?.userRealName ,
                    'projectNo':flow?.projectInstance?.projectNo,  
                    'project': flow?.projectInstance
                 ]}

                 flash.projectId = flow?.projectInstance?.id

                 println flash.projectId + "============"

                redirect(controller:"project", action:"show", id : flash.projectId)
            }.to "finish"
            on(Exception).to "review"
        }
        finish{
//            println "flow finish project id: ${flash?.projectId} / ${flow.projectInstance.id}"

//            def pid = flash.projectId
           // flash.projectId = null;
//            redirect(controller:"project", action:"show", id : pid)
//            redirect(controller:"project", action:"list")
        } 
    }


}
