
 

import  com.yahoo.platform.yui.compressor.*;

class DeleteMin {
	static String root = 'E:\\project\\Taurus\\web-app'
	static void main(arg){
		 //YUICompressor.main(["--charset",'UTF-8', "E:\\jSmile.js" ,'-o', "E:\\jSmile-min.js"] as String[])
			def it = new File("E:\\jSmile.js")
		    println it.absolutePath
		    println it.absolutePath.substring(0,it.absolutePath.lastIndexOf('.')) + "-min" + it.absolutePath.substring(it.absolutePath.lastIndexOf('.'))

//		  def file = new File(root + '\\js\\jquery')
//		  if(file.isDirectory()){
//			file.list( [accept:{d, f-> f ==~ /.*?-min.*/ }] as FilenameFilter).each{
//				  it.delete()
//			}
//		  }
//		  file = new File(root + '\\js\\domainjs')
//		  if(file.isDirectory()){
//			file.list( [accept:{d, f-> f ==~ /.*?-min.*/ }] as FilenameFilter).each{
//				  it.delete()
//			}
//		  }
//		   file = new File(root + '\\css')
//		  if(file.isDirectory()){
//			file.list( [accept:{d, f-> f ==~ /.*?-min.*/ }] as FilenameFilter).each{
//				  it.delete()
//			}
//		  }

		//new DeleteMin().searchInputFile(new File(root));
		  

	}

    def searchInputFile(inputFile){ 
      def filePattern = ~/.*-min\.(css|js)$/
	if(inputFile.isDirectory()){
	    inputFile.eachFileRecurse{
		if(!it.isDirectory() && it.getName() =~ filePattern){
		    println it.absolutePath
		    it.delete()
		} 
	    }
	}
    }
}