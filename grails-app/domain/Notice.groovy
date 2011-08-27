

class Notice implements Serializable{
    String name
    String title
    String content

    static constraints = {
        name(blank: false ,  unique: true ,size:0..50)
        title(blank: false ,  size:0..240)
        content(blank: false ,  size:0..5000)
    }

    String toString (){
         "${name}"
    }
}
