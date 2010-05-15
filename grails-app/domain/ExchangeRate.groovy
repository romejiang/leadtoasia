//汇率
// 目标都是美圆
class ExchangeRate {
    String currency   // 源货币 
    Double rate // 汇率

    static constraints = {
 		currency(blank: false,unique : true) 
		rate(blank: false)
    }
    String toString (){ 
        "$currency USD $rate"
    }
//    float a = 999.3599f; //设数值 
//    int b = (int)Math.round(a * 100); //小数点后两位前移，并四舍五入 
//    float c = (double)b / 100.00; //还原小数点后两位 
    double exchange(double source){
        def temp = (int)Math.round((source * rate)*100)
        (double)temp / 100.00
    }

    double exchange(double source , String currency ){
        if (currency == 'USD') {
            return source
        }
        def ex = ExchangeRate.findByCurrency(currency)
        ex?ex.exchange(source) : 0
    }

}
