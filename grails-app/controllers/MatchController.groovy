class MatchController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
 
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        log.info "match.list"
   
        if (params.pid) {
            def project = Project.get(params.pid)
            [matchInstanceList: project?.matchs , pid : params.pid]
        }else{
            redirect(action: "list", controller: "project")
        }    
    }

    def create = {
        def matchInstance = new Match()
        matchInstance.properties = params

         log.info "match.create $params.pid"
        return [matchInstance: matchInstance, pid : params.pid]
    }

    def save = {
        def matchInstance = new Match(params)
        log.info "match.save $params.pid"
    
        
        if (matchInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'match.label', default: 'Match'), matchInstance])}"
            
            def project = Project.get(params.pid)
            project.addToMatchs(matchInstance)
            project.save()
            matchInstance.save()
            log.info project?.matchs
         
            redirect(action: "show", controller: 'project', id: params.pid)
        }
        else {
            render(view: "create", model: [matchInstance: matchInstance , pid : params.pid])
        }
    }

    def show = {
        def matchInstance = Match.get(params.id)
        if (!matchInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'match.label', default: 'Match'), params.id])}"
            redirect(action: "list")
        }
        else {
            log.info "match.show $params.pid"
            [matchInstance: matchInstance , pid : params.pid]
        }
    }

    def edit = {
        def matchInstance = Match.get(params.id)
        if (!matchInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'match.label', default: 'Match'), params.id])}"
            redirect(action: "list")
        }
        else {
             
            log.info "match.edit $params.pid"
            return [matchInstance: matchInstance , pid :params.pid]
        }
    }

    def update = {
        def matchInstance = Match.get(params.id)
        if (matchInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (matchInstance.version > version) {
                    
                    matchInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'match.label', default: 'Match')] as Object[], "Another user has updated this Match while you were editing")
                    render(view: "edit", model: [matchInstance: matchInstance , pid: params.pid])
                    return
                }
            }
            matchInstance.properties = params
            if (!matchInstance.hasErrors() && matchInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'match.label', default: 'Match'), matchInstance])}"
                redirect(action: "show", controller: 'project', id: params.pid)
            }
            else {
                render(view: "edit", model: [matchInstance: matchInstance , pid: params.pid])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'match.label', default: 'Match'), params.id])}"
            redirect(action: "show", controller: 'project', id: params.pid)
        }
    }

    def delete = {
        def matchInstance = Match.get(params.id)
        if (matchInstance && params.pid) {
            try {
                 
                Project.get(params.pid).removeFromMatchs(matchInstance).save()

                matchInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'match.label', default: 'Match'), params.id])}"
                redirect(action: "show", controller: 'project',id: params.pid )
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'match.label', default: 'Match'), params.id])}"
                redirect(action: "show", id: params.id, params: [pid: params.pid])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'match.label', default: 'Match'), params.id])}"
            redirect(action: "list", params: [pid: params.pid])
        }
    }
}
