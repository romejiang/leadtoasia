 

class IndexController {

    def authenticateService 

    def index = {
    
        def user = authenticateService.userDomain();

        ["quoteProject":Project.findAllByManagerAndState(user,"quote" ,[max:5]) , 
            "processingProject":Project.findAllByManagerAndState(user,"processing" ,[max:5])]
    }
}
