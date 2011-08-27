import com.lucastex.grails.fileuploader.UFile

/**
 * User domain class.
 */
class User implements Serializable{
	static transients = ['pass' , 'string']
	static hasMany = [authorities: Role , quote: Pricing  , attachments :UFile ,mails: Email , industrys : Industry]
    SortedSet  quote
	static belongsTo = Role

	/** Username */
	String username
	/** User Real Name*/
	String userRealName
	/** MD5 Password */
	String passwd
	/** enabled */
	boolean enabled = true

	String email
	boolean emailShow  = true

	/** description */
	String description = ''

	/** plain password to create a MD5 password */
	String pass = '[secret]'
 
// ==============================
    boolean fullTime = true //内部，外部
//   内部==============================
    String tel = ''
    String fax = ''
    Boolean useSoft = false
    Integer level = 0;
//外部==============================
   
 

	static constraints = {
		username(blank: false, unique: true)
		userRealName(blank: false)

		mails()
		description(blank: true, size:0..1000)
		tel(blank: true, size:0..250,matches:"[0-9|-]+")
 		fax(blank: true, size:0..250,matches:"[0-9|-]+")

		passwd(blank: false)
		fullTime()
        industrys()
        useSoft()
        level(size: 0..5)
	  
	}

	String getString(){
		"${userRealName} ${fullTime?'':'@'} [${industrys.join(',')}]"
	}

	String toString(){
		"${userRealName} ${fullTime?'':'@'}"
	}
}
