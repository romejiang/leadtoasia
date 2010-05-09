

def file = new File("d:\\2.Temp\\Groovy\\sp短信运营商.txt")
def list= file.readLines()
 
def f2= new File('d:\\2.Temp\\Groovy\\sp短信运营商2.txt')
f2.write('','utf-8');
list.each{
	if(it.contains("北京")){
		println it
		f2.append(it+"\n",'utf-8')
		}
}
 // unique 