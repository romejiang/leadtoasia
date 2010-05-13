import java.text.*
import org.springframework.transaction.interceptor.TransactionAspectSupport
import org.springframework.transaction.annotation.*

class ProjectService {
 
    boolean transactional = true
//    def log

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    def finish(flow) throws Exception {
                println "==============================================="
                //1.project 
                println flow.projectInstance
                if (!flow.projectInstance.save()) {
                    throw new  Exception(flow.projectInstance.errors)  
                }
                // 2.match
                flow.matchs.each{
                    if (it.wordcount && it.wordcount > 0) {
                        if (it.save()) {
                            flow.projectInstance.addToMatchs(it)
                        }
                    }
                }

                // 3.task
                 
                flow.localizationInstanceList.each{
                    if (it.price && it.price > 0) {
//                    it.project = flow.projectInstance
                    println "task ${it}"
                        if (it.save()) {
                            flow.projectInstance.addToTask(it)
                        }else{
                            it.errors.each{ error ->
                                log.error error
                            }
                            throw new  Exception(it.errors)  
                        }
                    }
                }

                // 4.dtp
                flow.DTPInstanceList.each{
                    if (it.price && it.price > 0) {
                        println "DTP ${it}"
                         if (it.save()) {
                             flow.projectInstance.addToDtp(it)
                        }else{
                            it.errors.each{ error ->
                                log.error error
                            }
                            throw new  Exception(it.errors)  
                        }
                    }
                }

                // 5.file
 
                flow.projectInstance.save(flush: true) 
                if (!flow.projectInstance.projectNo || flow.projectInstance.projectNo == 'nothing') {
                        flow.projectInstance.projectNo = new Date().format("yyyyMMdd-") + new DecimalFormat("0000").format(flow.projectInstance.id)
                        flow.projectInstance.save() 
                } 
                
//                sessionFactory.currentSession.clear()
//                TransactionAspectSupport.currentTransactionInfo().transactionStatus.setRollbackOnly() 
                return true
    }
}
