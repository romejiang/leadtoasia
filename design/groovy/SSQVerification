def descdir='history.txt'
def lastNo = 146
//def mailserver = new HashSet()

def hi = new File(descdir) 
hi.write('')
    new File('history1.txt').eachLine{  
        if(it ==~ ~/.*\+.*/){
            println it
            hi.append(lastNo + ':' +it+"\n")
            lastNo--
        }
    }

     