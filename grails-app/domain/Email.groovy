// implements  Comparable
class Email  {
    String mail
  

    static constraints = {
        mail(blank: false, size:0..250, email:true)
    }

    static mapping = {
	    sort mail:"asc"
    }


    String toString (){
        mail
    } 
}
