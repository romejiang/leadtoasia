import com.lucastex.grails.fileuploader.UFile

/**
 * User domain class.
 */
class User implements Serializable{
	static transients = ['pass']
	static hasMany = [authorities: Role , quote: Pricing  , attachments :UFile ,mails: Email]
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
	  
	}
	String toString(){
		"${userRealName} ${fullTime?'<':'>'}"
	}
}
