////============================== 阴历属性
//class  calElement{
//def isToday
////瓣句
//def sYear
//def sMonth
//def sDay
//def week
////农历
//def lYear
//def lMonth
//def lDay
//def isLeap
////八字
//def cYear
//def cMonth
//def cDay
//}
//
//def t = new calElement(isToday: false)
//def ttt = test(1,2)
//def test = { a , c ->
//    a = 1;
//    c = 2;
//    println a + c
//    def arr = [1,2,3,4]
//    
//}

def c = Calendar.getInstance()
c.setTimeInMillis(-2208549300000)

println c.getTime()

def cal = Calendar.getInstance()
    cal.set(1900,0,6,2,5,0)
    println "-2208549300000"
    println cal.getTimeInMillis()
    println cal.getTime()