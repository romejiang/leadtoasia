def src='history.txt'
def srcbak='historybak.txt'
def lastNo = 146

def ssq  = [:]
//def Set<SSQdigit>  ssq = new HashSet<SSQdigit>(
//    [
//      compare : { Object o1, Object o2 ->
//     SSQdigit b1=(SSQdigit)o1;
//     SSQdigit b2=(SSQdigit)o2;
//     if (b1.equals(b2)) return 0
//     return (b2.hit - b1.hit) == 0? (int)(b2.timestamps - b1.timestamps) : b2.hit - b1.hit;
//    }
//   ] as Comparator
//   );  


 
new File(src).eachLine{  
    def m = it =~ /(\d*):(.*)\+(.*)/
    def ssqd = new SSQdigit(red: m[0][2], blue: m[0][3])
   
    ssq.put(m[0][1] , ssqd)
  
}

class SSQdigit {
	String red = ''
	String blue = ''
    String toString(){
        "${red} + ${blue}"
    }
}
 
     