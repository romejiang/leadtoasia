import grails.test.*

class EmailTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {

//        def mail2 = new Email(mail: 'romejiang2@qq.com');
        
        mockDomain(Email)
        def mail1 = new Email(mail: 'r23423m');

        assertFalse  mail1.validate()
        assertEquals "email", mail1.errors["mail"]

        def mail3 = new Email(mail: 'romejiang2@qq.com',customer :new Customer(name : "name",
                country: "name",
                contact: "name" ) );

        assertTrue mail3.validate()


    }
}
