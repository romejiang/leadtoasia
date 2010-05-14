// 翻译内容和tm词库，的匹配率，以及付款折扣
class Match  implements Comparable , Serializable{
     Integer   wordcount
     String match
     Integer discount//折扣

    static constraints = {
        wordcount(blank: false )
        match(blank: false ,size:0..20, inList:['No match','95% - 99% & 100%','75% - 95%','50%-74%'])
        discount(blank: false,range: 1..100)
    }
    static mapping = {
      table 'catmatch'
      match column:'match_rate'
      sort discount:"desc"
    }

     String toString (){ 
        "$wordcount words Match $match , so $discount% discount"
     }
 
    int compareTo(obj) {
       match.compareTo(obj.match)
    }

    int total(){
        (int)Math.round( wordcount * discount/100)
    }
}
 