@isTest
private class ContactTriggerTest {
    @isTest static void singleTest() {
        Contact c = new Contact(LastName = 'glennan');
        insert c;
        
        Contact c1.lastname = [select name from contact where lastname = 'glennan' limit 1];
       	update c1; 
        
        system.debug(c1);
    }
}