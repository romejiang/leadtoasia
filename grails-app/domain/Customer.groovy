class Customer implements Serializable {
//    客户名称，
    String name
//	国家，
    String country
//	相关联系方式，
    String contact

 
    String tel = ''
    String fax = ''
//	以及新增服务价格
//	（比如说我们给google做的项目En-HK是0.08 USD每个字，
//	但是客户现在需要EN-SC了，就需要添加新的价格和服务类型）
    static hasMany = [quote: Pricing ,mails: Email]
    SortedSet  quote

    User  registrant

    static constraints = {
        name(blank: false, size:0..250)
 		country(blank: false, size:0..250)
 		contact(blank: false, size:0..250)

 		mails()

 		tel(blank: true, size:0..250,matches:"[0-9|-]+")
 		fax(blank: true, size:0..250,matches:"[0-9|-]+")

 		quote()
        registrant(nullable:true)
    }

    static mapping = {
//		mails sort : 'mail' , order : 'asc'
		 
		mails cascade:"all,delete-orphan"
    }


    String toString (){
        "${name} ${country}"
    }
}
