class InvoiceInfoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def authenticateService
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        params.order="desc"
        params.sort="head"
        [invoiceInfoInstanceList: InvoiceInfo.findAllByUser(authenticateService.userDomain() ,params), 
            invoiceInfoInstanceTotal: InvoiceInfo.countByUser(authenticateService.userDomain())]
    }

    def defaults = {
        def info =  InvoiceInfo.get(params.id)
        if (info) {
            InvoiceInfo.findAllByUserAndHead(authenticateService.userDomain(), true).each{
                it.head = false
                it.save()
            }
            info.head  = true
            info.save(flush: true)
            flash.message = "set default ${info}"
        }else{
            flash.message = "Not Found"
        }
        redirect(action: "list", params: params)
    }

    def create = {
        def invoiceInfoInstance = new InvoiceInfo()
        invoiceInfoInstance.properties = params
        return [invoiceInfoInstance: invoiceInfoInstance]
    }

    def save = {
        def invoiceInfoInstance = new InvoiceInfo(params)
        invoiceInfoInstance.user = authenticateService.userDomain()
        if (invoiceInfoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), invoiceInfoInstance])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [invoiceInfoInstance: invoiceInfoInstance])
        }
    }

    def show = {
        def invoiceInfoInstance = InvoiceInfo.get(params.id)
        if (!invoiceInfoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), params.id])}"
            redirect(action: "list")
        }
        else {
            [invoiceInfoInstance: invoiceInfoInstance]
        }
    }

    def edit = {
        def invoiceInfoInstance = InvoiceInfo.get(params.id)
        if (!invoiceInfoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [invoiceInfoInstance: invoiceInfoInstance]
        }
    }

    def update = {
        def invoiceInfoInstance = InvoiceInfo.get(params.id)
        if (invoiceInfoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (invoiceInfoInstance.version > version) {
                    
                    invoiceInfoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'invoiceInfo.label', default: 'InvoiceInfo')] as Object[], "Another user has updated this InvoiceInfo while you were editing")
                    render(view: "edit", model: [invoiceInfoInstance: invoiceInfoInstance])
                    return
                }
            }
            invoiceInfoInstance.properties = params
            if (!invoiceInfoInstance.hasErrors() && invoiceInfoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), invoiceInfoInstance])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [invoiceInfoInstance: invoiceInfoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def invoiceInfoInstance = InvoiceInfo.get(params.id)
        if (invoiceInfoInstance) {
            try {
                invoiceInfoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invoiceInfo.label', default: 'InvoiceInfo'), params.id])}"
            redirect(action: "list")
        }
    }
}
