class CustomerService {

    boolean transactional = true

    def addToMails(mail,customerInstance) {
	if (mail){
        def mailString= mails2String(customerInstance.mails)
        log.info(mail.equals(mailString))      
		if (!(mail.equals(mailString))){
//			customerInstance.save(flush:true)

            log.info("$mail|$mailString")
//            mail.getBytes().each{print it}
//            println "="*20
//            mailString.getBytes().each{print it}
  
			if (customerInstance.mails)  {
                customerInstance.mails.toList().each {
                    customerInstance.mails.remove(it)
                } 
            } 
            customerInstance.save()
			mail.tokenize("\n").each{
				if (it.trim() != ''){ 
						customerInstance.addToMails(new Email(mail: it.trim())) 
				}
			}
		}
	}
    }

    def mails2String(mails){
        if (mails){
            return mails.join("\r\n") 
        }
    }
}
