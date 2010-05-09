class UserService {

    boolean transactional = true

    def addToMails(mail,instance) {
	if (mail){
        def mailString= mails2String(instance.mails)
        log.info(mail.equals(mailString))      
		if (!(mail.equals(mailString))){
//			instance.save(flush:true)

            log.info("$mail|$mailString")
//            mail.getBytes().each{print it}
//            println "="*20
//            mailString.getBytes().each{print it}
  
			if (instance.mails)  {
                instance.mails.toList().each {
                    instance.mails.remove(it)
                } 
            } 
//            instance.save()
			mail.tokenize("\n").each{
				if (it.trim() != ''){ 
						instance.addToMails(new Email(mail: it.trim())) 
				}
			}
		}
	}
    }

    def mails2String(mails){
        if (mails){
            return mails.join("\r\n") 
        }else{
            return ''
        }
    }
}
