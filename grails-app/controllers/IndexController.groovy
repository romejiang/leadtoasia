 

class IndexController {

    def authenticateService 

    def index = {
    
        def user = authenticateService.userDomain();
        params.order = "desc"
        params.sort = "start"
        params.max = 10 
        if (authenticateService.ifAnyGranted("ROLE_MANAGER,ROLE_ADMIN")) {
            return ["quoteProject":Project.findAllByManagerAndState(user,"quote" ,params) , 
                "processingProject":Project.findAllByManagerAndState(user,"processing" ,params)]
        }else if (authenticateService.ifAnyGranted("ROLE_USER")) {
             return [projectOrderQuote: ProjectOrder.findAllByVendorAndState(user , "new" ,params),
            projectOrderOpen: ProjectOrder.findAllByVendorAndState(user , "processing" ,params)]
        } else if (authenticateService.ifAnyGranted("ROLE_SALES,ROLE_SALES_DIRECTOR")) {
            return ["quoteProject":Project.findAllBySalesAndState(user,"quote" ,params) , 
                "processingProject":Project.findAllBySalesAndState(user,"processing" ,params),
                "paidProject":Project.findAllBySalesAndState(user,"paid" ,params),
                "finishedProject":Project.findAllBySalesAndState(user,"finished" ,params)]
        }
    }
}
