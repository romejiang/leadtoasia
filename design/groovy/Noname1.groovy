println "Test" + new Date().format('yyyy-MM-dd')

def str = """
<a href="" onClick="javascript:BigPic.innerHTML='<a target=_blank href=/Image/20090511161932389.jpg><img src=/Image/20090511161932389.jpg border=0 width=450 height=338></a>'" ><font color="#FF0000">照片</font></a>
                              
<a href="" onClick="javascript:BigPic.innerHTML='<a target=_blank href=/Image/20090511161932390.jpg><img src=/Image/20090511161932390.jpg border=0 width=450 height=338></a>'"><font color="#FF0000">照片1</font></a>

<a href="" onClick="javascript:BigPic.innerHTML='<a target=_blank href=/Image/20090511161932391.jpg><img src=/Image/20090511161932391.jpg border=0 width=450 height=338></a>'"><font color="#FF0000">照片2</font></a>

<a href="" onClick="javascript:BigPic.innerHTML='<a target=_blank href=/Image/20090511161932392.jpg><img src=/Image/20090511161932392.jpg border=0 width=450 height=338></a>'"><font color="#FF0000">照片3</font></a>"""

finder = str =~ /\d+\.jpg/   
finder.each{   
	println  it   
}  

 

//写入xml文件，使用大括号{}将生成标签，使用在括号()用来定义属性。
import groovy.xml.MarkupBuilder
def writer = new StringWriter()
def xml = new MarkupBuilder(writer)
xml.item() {
  thumb('&26000')
  img('a good car for you')
  caption('a good car for you')
 }
xml.item() {
  thumb('&26000')
  img('a good car for you')
  caption('a good car for you')
 }
println writer.toString()