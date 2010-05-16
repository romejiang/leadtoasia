import java.text.SimpleDateFormat
import com.lucastex.grails.fileuploader.UFile

class Project implements Serializable{
// 项目编号
	String projectNo
    //客户项目号
    String fromNo 
//    客户名称，

    Customer customer
    User manager //项目经理
 
//	项目日期（自动生成），
    Date start = new Date()
//	项目内容，
    String content
//	项目交付日期，
    Date deadline  = new Date() + 1
    Date invoiceDate  

//	项目状态 = open close paid processing
    String state = 'open'
// PO
    static hasMany = [task: Localization, dtp: Localization , matchs:Match, attachments :UFile]
////    orders: ProjectOrder
    SortedSet matchs
    SortedSet task
    SortedSet dtp



    static constraints = {
        
		projectNo(blank: false, size:0..250)
		fromNo(blank: true, size:0..250)
 		customer()
		start()
		deadline(validator:{val, obj->
			  return val.after(obj.start)
			})
        invoiceDate(nullable: true)
        state(blank: false , inList:['open','finished','invoice','paid','processing'])
 
		content(blank: true, size:0..255) 

        manager()
//        dtp( nullable: true)
    }

    static mapping = {
 
          matchs cascade:"all-delete-orphan"
          attachments cascade:"all-delete-orphan"
 

         task joinTable:[name:'project_task']
         dtp joinTable:[name:'project_dtp']
//         task sort : 'target' , order : 'asc'
//         dtp sort : 'target' , order : 'asc'
//         matchs sort : 'discount' , order : 'asc'

    }

    String toString (){ 
        "$projectNo"
    }

    int totalMatchs(){
        matchs?.sum{   it.total()   }
    }

    boolean compareToTask(obj){
        task?.any{
                    it.target.compareTo(obj.target) == 0 && it.source.compareTo(obj.source) == 0
        }
    }

    boolean compareToDtp(obj){
        dtp?.any{
                    it.target.compareTo(obj.target) == 0 && it.source.compareTo(obj.source) == 0
        }
    }

    Report buildReport(){
        if (state == 'paid' && invoiceDate != null ) {
            income = this.task.sum{
                er.exchange()
            }
            Report report = new Report(project: this , start : this.start, deadline : this.invoiceDate)
            float income //收 入
            float expenses  //支出
            float profit // 盈利
            return 
        }
        return null
    }
}
