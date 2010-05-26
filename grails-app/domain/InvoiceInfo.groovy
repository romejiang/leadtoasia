class InvoiceInfo {
 
    String payment
    String paymentDetail
    Boolean head = false 
    User user

    static constraints = {
          
        payment(blank: true , size:0..20,  validator: {val, obj ->
            return org.grails.plugins.lookups.Lookup.valueFor("Payment Sort",
                    val) != null
          })
        paymentDetail(blank: false ,size:0..1000)
    }

    String toString (){ 
        payment
    }
}
