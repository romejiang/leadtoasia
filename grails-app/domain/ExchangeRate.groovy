//汇率

class ExchangeRate {
    String currency   // 源货币
    String target   //目标
    float rate // 汇率

    static constraints = {
 		currency(blank: false)
		target(blank: false)
		rate(blank: false)
    }
    String toString (){ 
        "$currency $rate"
    }
}
