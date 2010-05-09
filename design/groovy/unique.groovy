

def file = new File("d:\\user.txt")
def list= file.readLines()
list = list.unique()
def f2= new File('d:\\user2.txt')
f2.write('','utf-8');
list.each{
	
	f2.append(it+"\n",'utf-8')
}
 // unique 