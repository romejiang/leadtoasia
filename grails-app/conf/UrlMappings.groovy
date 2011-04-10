class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(action:"/index", controller:"index")
	  "500"(view:'/error')
	  "400"(view:'/error')
	  "403"(view:'/error')
	}
}
