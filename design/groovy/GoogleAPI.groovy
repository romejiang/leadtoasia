import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import groovyx.net.http.ContentType

class  GoogleAPI{
	static main(arg) {

		println translate('中国你好，我爱你，hello')
    
	}

	static translate(source ){
	try{
		def http = new HTTPBuilder( 'http://ajax.googleapis.com' )
		http.get( path : '/ajax/services/language/translate' ,
		contentType : ContentType.JSON,
		query : [q : source ,
		v: '1.0',
		hl: 'zh',
		langpair: 'zh|en'
		]) { resp, json ->
			if (resp.statusLine.statusCode == 200) {
				return  json?.responseData?.translatedText
			} 
			return ''
		}
	}catch(Exception e){
		return ''
	}
	}

    
} 