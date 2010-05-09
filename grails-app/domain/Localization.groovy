class Localization implements Serializable{

    String source = 'en'
    String target = 'en'
    Float price = 0.0
    String type
    String unit
    Integer amount = 0

    ProjectOrder projectOrder
  

    static constraints = {
        source(blank: false, size:0..10 ,  validator: {val, obj ->
            return org.grails.plugins.lookups.Lookup.valueFor("Language",
                    val) != null
          })
        target(blank: false, size:0..10, validator: {
               val, obj ->
                  obj.properties['source'] != val
            })

        
		type(blank: false , size:0..10, inList:['word','hour','page','minimum'])
		unit(blank: false , size:0..10, validator: {val, obj ->
            return org.grails.plugins.lookups.Lookup.valueFor("Monetary Unit",
                    val) != null
          })
        price(blank: false)
        projectOrder(nullable: true)
        amount(nullable: true)
     }

    String toString (){ 
        "$source-$target"
    }

    static mapping = {
	    sort source:"asc"
	    sort target:"asc"
    }
 
}
