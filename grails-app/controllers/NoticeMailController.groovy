class NoticeMailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [noticeMailInstanceList: NoticeMail.list(params), noticeMailInstanceTotal: NoticeMail.count()]
    }

    def create = {
        def noticeMailInstance = new NoticeMail()
        noticeMailInstance.properties = params
        return [noticeMailInstance: noticeMailInstance]
    }

    def save = {
        def noticeMailInstance = new NoticeMail(params)
        if (noticeMailInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), noticeMailInstance.id])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [noticeMailInstance: noticeMailInstance])
        }
    }

    def show = {
        def noticeMailInstance = NoticeMail.get(params.id)
        if (!noticeMailInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), params.id])}"
            redirect(action: "list")
        }
        else {
            [noticeMailInstance: noticeMailInstance]
        }
    }

    def edit = {
        def noticeMailInstance = NoticeMail.get(params.id)
        if (!noticeMailInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [noticeMailInstance: noticeMailInstance]
        }
    }

    def update = {
        def noticeMailInstance = NoticeMail.get(params.id)
        if (noticeMailInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (noticeMailInstance.version > version) {
                    
                    noticeMailInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'noticeMail.label', default: 'NoticeMail')] as Object[], "Another user has updated this NoticeMail while you were editing")
                    render(view: "edit", model: [noticeMailInstance: noticeMailInstance])
                    return
                }
            }
            noticeMailInstance.properties = params
            if (!noticeMailInstance.hasErrors() && noticeMailInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), noticeMailInstance.id])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [noticeMailInstance: noticeMailInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def noticeMailInstance = NoticeMail.get(params.id)
        if (noticeMailInstance) {
            try {
                noticeMailInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'noticeMail.label', default: 'NoticeMail'), params.id])}"
            redirect(action: "list")
        }
    }
}
