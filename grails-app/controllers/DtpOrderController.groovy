import grails.converters.JSON

class DtpOrderController {
 
 
    def create = {
        def projectOrderInstance = new ProjectOrder()
        projectOrderInstance.properties = params
 
 
        return [projectOrderInstance: projectOrderInstance,
         parentType:params.parentType ]
    }

  def save = {
 
        def projectOrderInstance = new ProjectOrder(params)
 
        log.info params.matchs?.size()
        if (projectOrderInstance.save(flush: true)) {

 
            /// 保存给free lance 的报价和折扣
            // word计费方式才需要保持匹配率
            if (params.type == 'word') {
                 
                if (params.matchid?.size() > 0) {

                    params.matchid?.eachWithIndex{mid , i ->
                        def p_match = Match.get(mid)
                        def po_match = new Match( wordcount: p_match.wordcount ,
                               match: p_match.match,
                               discount: params.matchs[i])
                        projectOrderInstance.addToMatchs(po_match)
                        po_match.save()
                    }
                    
                }
            }
            projectOrderInstance.save()
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'projectOrder.label', default: 'ProjectOrder'), projectOrderInstance.id])}"
            redirect(action: "show",controller: 'project', id :  params.project.id)
        }
        else {
            render(view: "create", model: [projectOrderInstance: projectOrderInstance,
        pid : params.pid,parentType:params.parentType])
        }
    }
 
    // ajax 验证 是否是兼职员工
    def checkUser = {
	    def user = User.get(params.id)
         if (user && !user.fullTime) {
            def pricing = user.quote?.find{
                params.code == "$it.source-$it.target"
            }
            log.info pricing
            render(['success': true, 'message':  pricing] as JSON)
        }else{
	        render(['success': false] as JSON)
        }
    }
   
}
