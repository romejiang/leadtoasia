class CustomerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def customerService
    def authenticateService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (authenticateService.ifAllGranted("ROLE_SALES_DIRECTOR")) { 
             [customerInstanceList: Customer.findAllByRegistrantIsNotNull( params), 
                customerInstanceTotal: Customer.countByRegistrantIsNotNull( )]
        }else if (authenticateService.ifAllGranted("ROLE_SALES")) {
            
             [customerInstanceList: Customer.findAllByRegistrant(authenticateService.userDomain() ,params), 
                customerInstanceTotal: Customer.countByRegistrant(authenticateService.userDomain())]
        }else {
            [customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count()]
        }
    }

    def search = {
        params.max = 100
         if (authenticateService.ifAnyGranted("ROLE_SALES_DIRECTOR,ROLE_SALES")) { 
            return redirect(action: "list");
         }
        if (params.keyword && params.keyword != '') {
            
            log.info "customer.search keyword = ${params.keyword}  "
            return  render(view: "list", model: [customerInstanceList: Customer.findAllByNameIlike('%'+params.keyword +'%'),
                customerInstanceTotal: Customer.countByNameIlike('%'+params.keyword +'%' ),
                keyword:  params.keyword ])
        }
        flash.message = "请输入查询关键字！"
        redirect(action: "list", params: params)
    }

    def create = {
        def customerInstance = new Customer()
        customerInstance.properties = params
        return [customerInstance: customerInstance]
    }

    def save = {
        def customerInstance = new Customer(params)
	    customerService.addToMails(params.mail,customerInstance)
         if (authenticateService.ifAllGranted("ROLE_SALES")) {
            customerInstance.registrant = User.get(authenticateService.userDomain()?.id)
         }

        if (customerInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [customerInstance: customerInstance,mail : params.mail])
        }
    }

    def show = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerInstance: customerInstance]
        }
    }

    def edit = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerInstance: customerInstance ,mail :customerService.mails2String( customerInstance.mails)]
        }
    }

    def update = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerInstance.version > version) {
                    
                    customerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customer.label', default: 'Customer')] as Object[], "Another user has updated this Customer while you were editing")
                    render(view: "edit", model: [customerInstance: customerInstance])
                    return
                }
            }
            customerInstance.properties = params
    	    customerService.addToMails(params.mail,customerInstance)

            if (!customerInstance.hasErrors() && customerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [customerInstance: customerInstance ,mail : params.mail])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            try {
                customerInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }
}
