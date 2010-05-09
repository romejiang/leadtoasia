
class SSQMain {
    
 
    def src='history.txt'
 
    def  ssq  =[]
 

    static main(args){
        new SSQMain().init()
    }

    def init = {
      
        new File(src).eachLine{  
            def m = it =~ /(\d*):(.*)\+(.*)/
            def r = m[0][2].split(' ')
          
            ssq.add(new SSQdigit(on: m[0][1] as int,red : r, blue: m[0][3] as int))
        }

//        ssq.each{key ,value->
//            println value
////            hitRate(value)
//        }
        mahit(ssq)


    }
//===========================================
// 移动平滑，命中率
def mahit = { all ->
    def base = 10

    all = all.reverse()
    (0..all.size()-base-1).each{
        def Map redtatol = new TreeMap()
        all[it..it+base-1].each{  value ->
        //print  value.on
            value.red.each{ id ->
                if(redtatol.containsKey(id)){
                   
                    redtatol.put(id, redtatol.get(id)+1)
                }else{
                    redtatol.put(id,1)
                }
            }
        }
        //println "\n"
//        println redtatol
//        def total = 0
//        redtatol.each{ key , value ->
//            total += value
//        }
//
//        println "${total} : ${total/redtatol.size()}"

        def total = 0
        all[it+base].red.each{
            if(redtatol.containsKey(it)){
                total+= redtatol.get(it)
            }
        }
        println all[it+base].red + "||" + total
  
    }
}
//===========================================
// 最长出现的号码
//    def redSeed = [5,7,11,15,20,30,32]
//    def blueSeed = [4,11,14]
//最少出现的号码
//    def redSeed = [1,6,8,19,21,22,24,27]
//    def blueSeed = [3,7,8,12]
// 最多最少的混合 
//    def redSeed = [1,6,8,19,21,22,24,27,5,7,11,15,20,30,32]
//    def blueSeed = [3,7,8,12,4,11,14]
// 都在平均线上的
    def redSeed = [3,4,9,10,12,18,33]
    def blueSeed = [6,9,13,15]


    def hitRate = { SSQdigit hit ->
        def hitblue = 0
        def hitred = 0

        hitblue = blueSeed.contains(hit.blue)?1:0

        def temp =  compare(redSeed,hit.red)

        hitred = temp.size()

        if(hitblue + hitred > 3)println "共中：${hitblue + hitred}，其中红号${temp}，蓝号${hitblue?hit.blue: ''}" 
       
    }

    def compare ={ o1,o2 ->
        def result = []
        o1.each{
            o2.each{  it2->
                if(it as int==it2 as int)result.add(it as int)
            }
        }
        return result
    }
//===========================================

}
class SSQdigit {
    int on = 0;
	List  red = []
	int blue = 0
    String toString(){
        "${on} : ${red} + ${blue}"
    }
}
   