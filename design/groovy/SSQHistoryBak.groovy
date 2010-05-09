def descdir='historybak.txt'
def lastNo = 146
def flag = 7
def index = 0;
def store ='' ;
//def mailserver = new HashSet()

def hi = new File(descdir) 
hi.write('')
    new File('history2.txt').eachLine{  
        if(it.trim() ==~ ~/\d{2}/){
            if(index != 0 && (index % flag == 0)){
                println store
                hi.append(lastNo + ':' +store+"\n")
                lastNo--
                store =''
            } 
            if(index % flag == 6){
                store += "+" + it
            }else{
                store += " " + it
            }
            index++

        }
    }

     