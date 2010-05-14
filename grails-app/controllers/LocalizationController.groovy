import grails.converters.JSON

class LocalizationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def project = Project.get(params.pid)
        if (project) { 
            return [localizationInstanceList: Localization.findAllByProject(project ,params), 
            localizationInstanceTotal: Localization.countByProject(project),
            pid : params.pid,parentType:params.parentType]
        }
        [localizationInstanceList: Localization.list(params), 
        localizationInstanceTotal: Localization.count(),
        pid : params.pid,parentType:params.parentType]
    }

    def create = {
        def localizationInstance = new Localization()
        localizationInstance.properties = params
        def project = Project.get(params.pid)
        
        log.info "loaclization.create $params.pid"
        return [localizationInstance: localizationInstance , pid : params.pid , total : project?.totalMatchs() , parentType:params.parentType,]
    }

    def save = {
        def localizationInstance = new Localization(params)
        def project = Project.get(params.pid)
        if (project) {
            //localizationInstance.project = Project.get(params.pid) 
            def duplicate = false
            if (params.parentType == "task") {
                duplicate = project.compareToTask(localizationInstance)
            }else if(params.parentType == "dtp"){
                duplicate = project.compareToDtp(localizationInstance)
            }
            if (duplicate) {
                    flash.message = "${localizationInstance} localization duplicate"
            }else{
                 if (localizationInstance.save(flush: true)) { 
                    if (params.parentType == "task") {
                        project.addToTask(localizationInstance)
                        project.save()
                    }else if(params.parentType == "dtp"){
                        project.addToDtp(localizationInstance)
                        project.save()
                    }
                    
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'localization.label', default: 'Localization'), localizationInstance.id])}"
                    redirect(action: "show", controller: 'project', id: params.pid)
                }
            }
        }
        render(view: "create", model: [localizationInstance: localizationInstance , pid : params.pid, parentType:params.parentType, total : params.total])
     
    }

    def show = {
        def localizationInstance = Localization.get(params.id)
        if (!localizationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localization.label', default: 'Localization'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            [localizationInstance: localizationInstance ,pid : params.pid,parentType:params.parentType]
        }
    }

    def edit = {
        def localizationInstance = Localization.get(params.id)
        if (!localizationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localization.label', default: 'Localization'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            return [localizationInstance: localizationInstance ,pid : params.pid,parentType:params.parentType]
        }
    }

    def update = {
        def localizationInstance = Localization.get(params.id)
        if (localizationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (localizationInstance.version > version) {
                    
                    localizationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'localization.label', default: 'Localization')] as Object[], "Another user has updated this Localization while you were editing")
                    render(view: "edit", model: [localizationInstance: localizationInstance ,pid : params.pid,parentType:params.parentType])
                    return
                }
            }
            localizationInstance.properties = params
            if (!localizationInstance.hasErrors() && localizationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'localization.label', default: 'Localization'), localizationInstance.id])}"
                redirect(action: "show", controller: 'project', id: params.pid)
            }
            else {
                render(view: "edit", model: [localizationInstance: localizationInstance ,pid : params.pid,parentType:params.parentType])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localization.label', default: 'Localization'), params.id])}"
            redirect(action: "show", controller: 'project', id: params.pid)
        }
    }

    def delete = {
        def localizationInstance = Localization.get(params.id)
       
        if (localizationInstance) {
            if (localizationInstance.projectOrder ) {
                flash.message = "PO is exist. so not delete."
                return redirect(action: "show", id: params.id, params : [pid : params.pid,parentType:params.parentType])
            }
            try {
                def project = Project.get(params.pid)
                if ("task" == params.parentType) {
                    project.removeFromTask(localizationInstance)
                }else if ("dtp" == params.parentType){
                    project.removeFromDtp(localizationInstance)
                }
                project.save(flush: true)
                localizationInstance.delete(flush: true)
                
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'localization.label', default: 'Localization'), params.id])}"
                redirect(controller: 'project' , action: "show", id: params.pid)
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'localization.label', default: 'Localization'), params.id])}"
                redirect(action: "show", id: params.id, params : [pid : params.pid,parentType:params.parentType])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localization.label', default: 'Localization'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
    }
// ajax 获取 客户 定价信息的json
    def getPricing = {
        log.info "localization.getPricing params.pid = ${params.pid}" 
        def project = Project.get(params.pid)
        if (project) {
            def result = project?.customer?.quote.findAll{
                it.source == params.source && it.target == params.target
            } 
            if (result) return render(['success': true, 'message': result ] as JSON)
        
        }
        return render(['success': false] as JSON)
    }
}
