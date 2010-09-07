import java.text.SimpleDateFormat
import com.lucastex.grails.fileuploader.UFile

class ProjectOrder implements Serializable{
//    	读取项目号，
    Project project
 
//	填写项目执行人（或者旁边有个按钮，点击选择译者），
    User vendor
  
//内部 PO：
 
//	服务需求（翻译／编辑／ＤＴＰ），
    String requirement  
    Date start = new Date()
//	交货日期，
    Date deliveryDate   = new Date() + 1
    Date invoiceDate 
//
//外部PO：
 
//	单价，总价，成本
 
    Float rate = 0.0
    Float total= 0.0
    Integer wordcount
    String type
//	付款方式（菜单选项），
    //支付货币单位
    String unit

//	客户付款方式选项。
    String paymentSort
    //付款期限
    Integer paymentTerms = 45
//???生成的PO直接存成word, excel或PDF格式到指定的路径。
    String serviceType
    String state = 'new'

    static hasMany = [attachments :UFile ,matchs:Match]
    SortedSet matchs
    Localization localization

   static mapping = {
      matchs cascade:"all-delete-orphan"
      attachments cascade:"all-delete-orphan"
  }


    static constraints = {
         
		vendor() 

        serviceType(blank: false , validator: {val, obj ->
            return org.grails.plugins.lookups.Lookup.valueFor("Service Type",
                    val) != null
          })
        total(blank: true)
        paymentSort(blank: true , size:0..20,  validator: {val, obj ->
            return org.grails.plugins.lookups.Lookup.valueFor("Payment Sort",
                    val) != null
          })
	    state(blank: false , inList:['new','processing','submit','pass','invoice','finished'])
	    // 新建po，领取任务，完成提交任务，审核通过或者打回继续processing，通过后invoice，最后finished
 
        rate(blank: false)
        wordcount(blank: false)
        type(blank: true , size:0..10, inList:['word','page','hour','minimum'])

        unit(blank: true , size:0..10, validator: {val, obj ->
            return org.grails.plugins.lookups.Lookup.valueFor("Monetary Unit",
                    val) != null
          })
 
        paymentTerms(blank: true , size:0..250)
		start()
        deliveryDate()
        project()
 		requirement(blank: true, size:0..1000)
        localization(nullable: true)
        invoiceDate(nullable: true)
       
    }

    String toString (){
        def df = new SimpleDateFormat("MM/dd/yyyy")
        "${vendor}\n${df.format(deliveryDate)}"
    }

    String paymentTermsString(){
        "${paymentTerms} days after invoice"
    }
}
