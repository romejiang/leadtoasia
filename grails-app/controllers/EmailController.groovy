class EmailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [emailInstanceList: Email.list(params), emailInstanceTotal: Email.count()]
    }

    def create = {
        def emailInstance = new Email()
        emailInstance.properties = params
        return [emailInstance: emailInstance]
    }

    def save = {
        def emailInstance = new Email(params)
        if (emailInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'email.label', default: 'Email'), emailInstance])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [emailInstance: emailInstance])
        }
    }

    def show = {
        def emailInstance = Email.get(params.id)
        if (!emailInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), params.id])}"
            redirect(action: "list")
        }
        else {
            [emailInstance: emailInstance]
        }
    }

    def edit = {
        def emailInstance = Email.get(params.id)
        if (!emailInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [emailInstance: emailInstance]
        }
    }

    def update = {
        def emailInstance = Email.get(params.id)
        if (emailInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (emailInstance.version > version) {
                    
                    emailInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'email.label', default: 'Email')] as Object[], "Another user has updated this Email while you were editing")
                    render(view: "edit", model: [emailInstance: emailInstance])
                    return
                }
            }
            emailInstance.properties = params
            if (!emailInstance.hasErrors() && emailInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'email.label', default: 'Email'), emailInstance])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [emailInstance: emailInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def emailInstance = Email.get(params.id)
        if (emailInstance) {
            try {
                emailInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'email.label', default: 'Email'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'email.label', default: 'Email'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), params.id])}"
            redirect(action: "list")
        }
    }
}
