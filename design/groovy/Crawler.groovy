import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import groovyx.net.http.ContentType

class  Crawler{
	static data = [
	//'http://yyk.39.net/list/arealisthospital.html',
	'http://localhost:8080/help/arealisthospital.html',
	"<a name=\"直辖市\" ></a><div class=\"list_box\">",
"<!--底部相关-->" 

]
	
	static main(arg) {
	
		def content =  getHTML(data[0])
		 // 前后截取，留下内容
		content = content.substring(content.indexOf(data[1]))
		content = content.substring(0,content.indexOf(data[2]))

	 
		def pattern = ~/\<a href\='http:\/\/yyk.39.net\/([\w]*)\/[\w]*\/list.html'>([^>]*)\<\/a\>/  
		def matcher = pattern.matcher(content)  
		def count = matcher.getCount()  
		for(i in 0..<count) {  
			println  "'" + matcher[i][1] + "' : '" + matcher[i][2] + "',"
		}
    
	}

	static getHTML(url){
		def domain = url.substring(0,url.indexOf('/',7))
		def uri = url.substring(url.indexOf('/',7))

	 
		try{
			def http = new HTTPBuilder( domain )
			http.get( path : uri ,
			contentType : ContentType.TEXT ) { resp, data ->
				if (resp.statusLine.statusCode == 200) {
					return data.text
				} 
				return ''
			}
		}catch(Exception e){
			return 'Exception'
		}
	}

    
} 