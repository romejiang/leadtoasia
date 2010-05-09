import grails.test.*

class CustomerTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

     void testMailsSort() {
        mockDomain(Email)

        def mail1 = new Email(mail: '222@qq.com');
        def mail2 = new Email(mail: '111@qq.com');
        def mail3 = new Email(mail: '333@qq.com');

        mockDomain(Customer)

        def customer = new Customer(name : "name",
                country: "name",
                contact: "name" ) 

                customer.addToMails(mail1)
                customer.addToMails(mail2)
                customer.addToMails(mail3)

                assertTrue customer.validate()

                println customer.errors

                customer.save()
                println customer.mails

                assertToString customer.mails , "[111@qq.com, 222@qq.com, 333@qq.com]"

                customer = Customer.get(1)

                assertToString customer.mails , "[111@qq.com, 222@qq.com, 333@qq.com]"
                
                 

     }
    void testSave() {

        
        mockDomain(Email)

        def mail1 = new Email(mail: 'romejiang@qq.com');
        def mail2 = new Email(mail: 'romejiang2@qq.com');

        mockDomain(Customer)

        def customer = new Customer(name : "name",
                country: "name",
                contact: "name",
                mails: [mail1 , mail2] ,
                tel: "name",
                fax: "name") 

                assertFalse customer.validate()
                assertEquals "matches" , customer.errors["tel"]
                assertEquals "matches" , customer.errors["fax"]
                
                


           def customer2 = new Customer(name : "name",
                country: "name",
                contact: "name",
                mails: [mail1 , mail2] ,
                tel: "123123",
                fax: "123123123")              
        
        assertTrue customer2.validate()
 
    }
}
