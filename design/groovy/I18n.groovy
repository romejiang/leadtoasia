

class I18n {
    def hashtable = new LinkedHashMap();
    static main(args){
	def i = new I18n();
	i.load('messages.properties')

	i.write('default.number.format=20')
	i.save('messages.properties')
    }
   def load(filename) { 
 
	def file = new File(filename)
	file.splitEachLine('='){
	   if(it.size() == 2){
		hashtable.put(it[0],it[1])   
	   } 
	}
    }

    def print(){
	hashtable.each{ key, value ->
		println key + value
	}
    }

    def write (str)  {
	if(str.contains('=')){			    
          hashtable.put(str.split('=')[0],str.split('=')[1])
	}
    }

    def save (filename)  {
	def prefix ;

	//def file = new File(filename)
	hashtable.each{ key, value ->
		def temp = key.contains('.')?key.substring(0,key.indexOf('.')):key
		if(prefix != temp){
			file.write('\n')
			println ''
			prefix = temp
		}

		//file.write(key+'='+value,'utf-8')
		println key+'='+value
	}
    }
}