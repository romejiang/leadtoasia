class Localization implements Comparable , Serializable{

    String source = 'en'
    String target = 'en'
    Float price = 0.0
    String type
    String unit
    Integer amount = 0

    //ProjectOrder projectOrder
    static belongsTo = [projectOrder:ProjectOrder] 

    static constraints = {
        source(blank: false, size:0..20 )
//        validator: {val, obj ->
//            return org.grails.plugins.lookups.Lookup.valueFor("Language",
//                    val) != null
//          }
        target(blank: false, size:0..20)

//        validator: {
//               val, obj ->
//                  obj.properties['source'] != val
//            } 
		type(blank: false , size:0..10, inList:['word','editing','hour','page','minimum'])
		unit(blank: false , size:0..10)
//        , validator: {val, obj ->
//            return org.grails.plugins.lookups.Lookup.valueFor("Monetary Unit",
//                    val) != null
//          }
        price(blank: false)
        projectOrder(nullable: true)
        amount(nullable: true)
     }

    String toString (){ 
        "$source-$target"
    }
    boolean checkDomain (){ 
//        (org.grails.plugins.lookups.Lookup.valueFor("Language",  source) != null 
//        && org.grails.plugins.lookups.Lookup.valueFor("Language",  target) != null
        target != source
//        && org.grails.plugins.lookups.Lookup.valueFor("Monetary Unit", unit) != null )
    }
    static mapping = {
	   
	    sort target:"asc"
    }

    int compareTo(obj) {
       "${source}${target}${type}".compareTo("${obj.source}${obj.target}${obj.type}")
    }

    float income(){
        //def er = new ExchangeRate()
        def er = ExchangeRate.exchange(price * amount , unit)
        er ? er : 0
    }


  float expenses(){
        if (!projectOrder?.vendor?.fullTime) {
            return ExchangeRate.exchange(projectOrder?.total , projectOrder?.unit)
        } else{
            return 0
        }
    }
}
