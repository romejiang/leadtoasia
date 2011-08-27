class PricingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def object
        def all
         if (params.parentType == 'customer') {
               object = Customer.get(params.pid)
               log.info params.parentType
            }else  if (params.parentType == 'user') {
                object = User.get(params.pid)
                log.info params.parentType
            }else{
                all = Pricing.list()
            }
            
            [pricingInstanceList: all? all : object.quote,  pid : params.pid,parentType:params.parentType]
    }

    def create = {
        def pricingInstance = new Pricing()
        pricingInstance.properties = params
     
        return [pricingInstance: pricingInstance, pid : params.pid,parentType:params.parentType]
    }

    def save = {
        def pricingInstance = new Pricing(params)
//            ========================================
          // 保存到客户的价格体系
          def tempc
            if (params.parentType == 'customer') {
                tempc = Customer.get(params.pid)
                if (tempc.quote && tempc.quote.contains(pricingInstance)) {

                    pricingInstance.errors.reject('pricing.customer.exist',  
                    ['source', 'class Pricing'].toArray(),  
                    "[${pricingInstance} is exist]")  
 
                    return render(view: "create", model: [pricingInstance: pricingInstance,  pid : params.pid,parentType : params.parentType ])
                } 
            // 保存到user的价格体系
            }else if (params.parentType == 'user') {
                tempc = User.get(params.pid)
                if (tempc.quote && tempc.quote.contains(pricingInstance)) {

                    pricingInstance.errors.reject('pricing.user.exist',  
                    ['source', 'class Pricing'].toArray(),  
                    "[${pricingInstance} is exist]")  
 
                    return render(view: "create", model: [pricingInstance: pricingInstance,  pid : params.pid,parentType : params.parentType ])
                }                
                
            }
//            ========================================
        if (pricingInstance.save()) {
            
            if (!tempc.addToQuote(pricingInstance).save()) {
                tempc.errors.each{
                    log.info "${it}"
                }
            }
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricingInstance])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            pricingInstance.discard()
            tempc?.discard()
            render(view: "create", model: [pricingInstance: pricingInstance, pid : params.pid,parentType:params.parentType])
        }
    }

    def show = {
        def pricingInstance = Pricing.get(params.id)
        if (!pricingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            [pricingInstance: pricingInstance, pid : params.pid,parentType:params.parentType]
        }
    }

    def edit = {
        def pricingInstance = Pricing.get(params.id)
        if (!pricingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
        else {
            return [pricingInstance: pricingInstance, pid : params.pid,parentType:params.parentType]
        }
    }

    def update = {
        def pricingInstance = Pricing.get(params.id)
        if (pricingInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (pricingInstance.version > version) {
                    
                    pricingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'pricing.label', default: 'Pricing')] as Object[], "Another user has updated this Pricing while you were editing")
                    render(view: "edit", model: [pricingInstance: pricingInstance, pid : params.pid,parentType:params.parentType])
                    return
                }
            }
            pricingInstance.properties = params
            // ================================================
  // 保存到客户的价格体系
//            if (params.parentType == 'customer') {
//                def tempc = Customer.get(params.pid)
//                if (tempc.quote ) {
//                    def results = tempc.quote.find{
//                        log.info it.compareTo(pricingInstance)
//                        log.info "$it | $pricingInstance | $it.id | $params.id"
//                        it.compareTo(pricingInstance)  == 0 && it.id != new Long(params.id)
//                    }
//                    if (results) {
//                        pricingInstance.errors.reject('pricing.customer.exist',  
//                        ['source', 'class Pricing'].toArray(),  
//                        "[${pricingInstance} is exist]")  
//                        log.info "return edit view."
//                      
//                        pricingInstance.discard()
//                        return render(view: "edit", model: [pricingInstance: pricingInstance,  pid : params.pid,parentType : params.parentType ])
//                    }
//                }
//         
//            // 保存到项目的价格体系
//            }else if (params.parentType == 'user') {
//                //User.get(params.pid).addToQuote(pricingInstance).save()
//                def tempc = User.get(params.pid)
//                if (tempc.quote ) {
//                    def results = tempc.quote.find{
//                        log.info it.compareTo(pricingInstance)
//                        it.compareTo(pricingInstance)  == 0 
//                    }
//                    if (results) {
//                        pricingInstance.errors.reject('pricing.user.exist',  
//                        ['source', 'class Pricing'].toArray(),  
//                        "[${pricingInstance} is exist]")  
//                        log.info "return edit view."
//                      
//                        pricingInstance.discard()
//                        return render(view: "edit", model: [pricingInstance: pricingInstance,  pid : params.pid,parentType : params.parentType ])
//                    }
//                }
//            }
// ================================================
            

            if (!pricingInstance.hasErrors() && pricingInstance.save(flush: true)) {
                log.info "$pricingInstance to save!"
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricingInstance])}"
                redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
            }
            else {
                render(view: "edit", model: [pricingInstance: pricingInstance, pid : params.pid,parentType:params.parentType])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
    }

    def delete = {
        def pricingInstance = Pricing.get(params.id)
        if (pricingInstance) {
            try {
                if (params.parentType == 'customer') {
                    Customer.get(params.pid).removeFromQuote(pricingInstance).save()
                }else if (params.parentType == 'user') {
                    User.get(params.pid).removeFromQuote(pricingInstance).save()
                }
                pricingInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
                redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
                redirect(action: "show", id: params.id, params : [pid : params.pid,parentType:params.parentType])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "list", params : [pid : params.pid,parentType:params.parentType])
        }
    }
}
