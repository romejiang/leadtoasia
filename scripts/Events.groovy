eventCreateWarStart = { warLocation, stagingDir ->
       //ant.delete(dir:"${stagingDir}/", failonerror:true)

    //println "######## War  ${stagingDir}.................done!"
    if(config.war.exclude.files)
        config.war.exclude.files.each{
             Ant.delete(
                file:"${stagingDir}/${it}")
                println "config war exclude file : ${stagingDir}/${it}"
        }
     
    if(config.war.exclude.dirs)
        config.war.exclude.dirs.each{
            ant.delete(dir:"${stagingDir}/${it}", failonerror:true)
            println "config war exclude dir : ${stagingDir}/${it}"
        }
    
//    stagingDir.eachFileRecurse{
//        if(it.name.endsWith('.js')||it.name.endsWith('.css')){
//            def f= it.absolutePath
//            
//            println "Minizing ${f}......................"
//            ant.java(jar:"${basedir}/lib/yuicompressor-2.4.2.jar",
//                     fork: true){
//                arg(value: "${f}")
//                arg(value: "-o")
//                arg(value: "${f}")
//            }
//            println "Minizing ${f}.................done!"
//        }
//    }
}

eventCreateWarEnd = {warLocation, stagingDir ->
    
}