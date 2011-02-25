class IndustryController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [industryInstanceList: Industry.list(params), industryInstanceTotal: Industry.count()]
    }

    def create = {
        def industryInstance = new Industry()
        industryInstance.properties = params
        return [industryInstance: industryInstance]
    }

    def save = {
        def industryInstance = new Industry(params)
        if (!industryInstance.hasErrors() && industryInstance.save()) {
            flash.message = "industry.created"
            flash.args = [industryInstance.id]
            flash.defaultMessage = "Industry ${industryInstance.id} created"
            redirect(action: "show", id: industryInstance.id)
        }
        else {
            render(view: "create", model: [industryInstance: industryInstance])
        }
    }

    def show = {
        def industryInstance = Industry.get(params.id)
        if (!industryInstance) {
            flash.message = "industry.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Industry not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [industryInstance: industryInstance]
        }
    }

    def edit = {
        def industryInstance = Industry.get(params.id)
        if (!industryInstance) {
            flash.message = "industry.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Industry not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [industryInstance: industryInstance]
        }
    }

    def update = {
        def industryInstance = Industry.get(params.id)
        if (industryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (industryInstance.version > version) {
                    
                    industryInstance.errors.rejectValue("version", "industry.optimistic.locking.failure", "Another user has updated this Industry while you were editing")
                    render(view: "edit", model: [industryInstance: industryInstance])
                    return
                }
            }
            industryInstance.properties = params
            if (!industryInstance.hasErrors() && industryInstance.save()) {
                flash.message = "industry.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Industry ${params.id} updated"
                redirect(action: "show", id: industryInstance.id)
            }
            else {
                render(view: "edit", model: [industryInstance: industryInstance])
            }
        }
        else {
            flash.message = "industry.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Industry not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def industryInstance = Industry.get(params.id)
        if (industryInstance) {
            try {
                industryInstance.delete()
                flash.message = "industry.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Industry ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "industry.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Industry ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "industry.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Industry not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
