@isTest

private class ContactsTriggerTest {
    @isTest static void singleTest() {
     	Contact c = new Contact(lastname = 'glennan', description = 'hello');
        insert c;
        
        c.lastname = 'lennon';
        update c;
        
        Contact x = [select description from contact where lastname = 'glennan'];
       	System.debug(x);
        System.debug(c);
        System.assertEquals('Contact Updated by ' + userInfo.getUserEmail(), c.description);
    }    
}
