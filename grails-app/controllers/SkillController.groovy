class SkillController {

    def authenticateService 
   
    	// 自己维护自己的技能清单
	def index = {
	        def person = User.get( authenticateService.userDomain()?.id)
            [pricingInstanceList: person?.quote]
	}

    def list = {
        redirect(action: "index")
    }


    def create = {
        def pricingInstance = new Pricing()
        pricingInstance.properties = params
     
        return [pricingInstance: pricingInstance]
    }

    def save = {
        def pricingInstance = new Pricing(params)
 
        def tempc = User.get(authenticateService.userDomain()?.id)
        if (tempc.quote && tempc.quote.contains(pricingInstance)) {

            pricingInstance.errors.reject('pricing.user.exist',  
            ['source', 'class Pricing'].toArray(),  
            "[${pricingInstance} is exist]")  

            return render(view: "create", model: [pricingInstance: pricingInstance ])
         }
//            ========================================
        if (pricingInstance.save()) {
            tempc.addToQuote(pricingInstance).save()
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricingInstance])}"
            redirect(action: "index")
        }
        else {
            pricingInstance.discard()
            tempc?.discard()
            render(view: "create", model: [pricingInstance: pricingInstance])
        }
    }

    def show = {
        def pricingInstance = Pricing.get(params.id)
        if (!pricingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "index" )
        }
        else {
            [pricingInstance: pricingInstance]
        }
    }

    def edit = {
        def pricingInstance = Pricing.get(params.id)
        if (!pricingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "index" )
        }
        else {
            return [pricingInstance: pricingInstance]
        }
    }

    def update = {
        def pricingInstance = Pricing.get(params.id)
        if (pricingInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (pricingInstance.version > version) {
                    
                    pricingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'pricing.label', default: 'Pricing')] as Object[], "Another user has updated this Pricing while you were editing")
                    render(view: "edit", model: [pricingInstance: pricingInstance])
                    return
                }
            }
            pricingInstance.properties = params
         

            if (!pricingInstance.hasErrors() && pricingInstance.save(flush: true)) {
                log.info "$pricingInstance to save!"
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'pricing.label', default: 'Pricing'), pricingInstance])}"
                redirect(action: "index" )
            }
            else {
                render(view: "edit", model: [pricingInstance: pricingInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "index" )
        }
    }

    def delete = {
        def pricingInstance = Pricing.get(params.id)
        if (pricingInstance) {
            try {
               
                User.get(authenticateService.userDomain()?.id).removeFromQuote(pricingInstance).save()
                
                pricingInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
                redirect(action: "index" )
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
                redirect(action: "show", id: params.id,)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pricing.label', default: 'Pricing'), params.id])}"
            redirect(action: "index" )
        }
    }
}
