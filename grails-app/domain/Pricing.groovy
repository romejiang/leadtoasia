/**
* 价格体系，针对每个客户的每种语言本地化要求，不同的价格定制
*/

class Pricing implements Comparable , Serializable{
    String source = 'en'
    String target = 'en'
    float price = 0.0
    String type
    String unit
 

    static constraints = {
        source(blank: false, size:0..10 , validator: {val, obj ->
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
  
    }

    String toString (){ 
        "$source-$target $price $unit per $type"
    }

    static mapping = {
	    sort source:"asc"
    }

    int compareTo(obj) {
       toString().compareTo(obj.toString())
    }

}
