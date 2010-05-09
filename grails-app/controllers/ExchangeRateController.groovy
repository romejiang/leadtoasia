class ExchangeRateController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [exchangeRateInstanceList: ExchangeRate.list(params), exchangeRateInstanceTotal: ExchangeRate.count()]
    }

    def create = {
        def exchangeRateInstance = new ExchangeRate()
        exchangeRateInstance.properties = params
        return [exchangeRateInstance: exchangeRateInstance]
    }

    def save = {
        def exchangeRateInstance = new ExchangeRate(params)
        if (exchangeRateInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), exchangeRateInstance.id])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [exchangeRateInstance: exchangeRateInstance])
        }
    }

    def show = {
        def exchangeRateInstance = ExchangeRate.get(params.id)
        if (!exchangeRateInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), params.id])}"
            redirect(action: "list")
        }
        else {
            [exchangeRateInstance: exchangeRateInstance]
        }
    }

    def edit = {
        def exchangeRateInstance = ExchangeRate.get(params.id)
        if (!exchangeRateInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [exchangeRateInstance: exchangeRateInstance]
        }
    }

    def update = {
        def exchangeRateInstance = ExchangeRate.get(params.id)
        if (exchangeRateInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (exchangeRateInstance.version > version) {
                    
                    exchangeRateInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'exchangeRate.label', default: 'ExchangeRate')] as Object[], "Another user has updated this ExchangeRate while you were editing")
                    render(view: "edit", model: [exchangeRateInstance: exchangeRateInstance])
                    return
                }
            }
            exchangeRateInstance.properties = params
            if (!exchangeRateInstance.hasErrors() && exchangeRateInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), exchangeRateInstance.id])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [exchangeRateInstance: exchangeRateInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def exchangeRateInstance = ExchangeRate.get(params.id)
        if (exchangeRateInstance) {
            try {
                exchangeRateInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'exchangeRate.label', default: 'ExchangeRate'), params.id])}"
            redirect(action: "list")
        }
    }
}
