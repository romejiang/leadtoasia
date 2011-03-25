 

class IndexController {

    def authenticateService 

    def index = {
    
        def user = authenticateService.userDomain();

        ["quoteProject":Project.findAllByManagerAndState(user,"quote")]
    }
}
