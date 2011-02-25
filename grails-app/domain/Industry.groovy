// implements  Comparable
class Industry  {
    String name
    String enname
  

    static constraints = {
        name(blank: false, size:0..250)
        enname(blank: false, size:0..250)
    }

    static mapping = {
	    
    }


    String toString (){
        name
    } 
}
