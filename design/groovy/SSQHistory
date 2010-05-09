def descdir='D:\\QQDownload\\pinyi\\mail\\'
//def mailserver = new HashSet()

new File('D:\\QQDownload\\pinyi\\0.地址大全\\邮件地址').eachFileMatch(~/.*?\.txt/){
    new File(it.absolutePath).eachLine{ mailadds ,index->
        try{
        if(mailadds.contains('@')){
            def ms = mailadds.substring(mailadds.indexOf('@')+1)
            new File(descdir + ms[0] + '\\').mkdir()
            new File(descdir + ms[0] + '\\' + ms + '.txt').append(mailadds + "\n")
            if(index%10 == 0)print '.'
        }
        }catch(Exception e){
        }
    }
    println 'end ' + it.name
}

 
