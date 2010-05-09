 
import grails.converters.JSON

class DtpController {

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
        log.info "loaclization.create $params.pid"
        return [localizationInstance: localizationInstance , pid : params.pid]
    }

    def save = {
        def localizationInstance = new Localization(params)
        if (params.pid) {
            //localizationInstance.project = Project.get(params.pid)
            def project = Project.get(params.pid)
            project.addToDtp(localizationInstance)
 
            if (localizationInstance.save(flush: true)) {
                project.save()
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'localization.label', default: 'Localization'), localizationInstance.id])}"
                redirect(action: "show", controller: 'project', id: params.pid)
            }
        }
            render(view: "create", model: [localizationInstance: localizationInstance , pid : params.pid, parentType:params.parentType])
     
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
                project.removeFromDtp(localizationInstance)
                localizationInstance.delete(flush: true)
                project.save()
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
        log.info params.pid
        def project = Project.get(params.pid)
        if (project) {
            def result = project?.customer?.quote.findAll{
                it.source == params.source && it.target == params.target
            }
            return render(['success': true, 'message': result ] as JSON)
        }
        return render(['success': false])
    }
}
