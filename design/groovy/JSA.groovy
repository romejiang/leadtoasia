import org.xidea.jsi.tools.*

class JSA {
	static void main(arg){
		 JavaScriptCompressor compressor = JSIToolkit.getInstance().getCompressorImpl();

		 def s =  compressor.format("""
function test(aaa,bbb){
return aaa+bbb+aaa;
}
		 """)

		 println '+++++++++++++++++++'
		 println s
	} 
}