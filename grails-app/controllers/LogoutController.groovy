/**
 * Logout Controller (Example).
 */
class LogoutController {

	/**
	 * Index action. Redirects to the Spring security logout uri.
	 */
	def index = {
		// TODO  put any pre-logout code here
        System.gc()
		redirect(uri: '/j_spring_security_logout')
	}
}
