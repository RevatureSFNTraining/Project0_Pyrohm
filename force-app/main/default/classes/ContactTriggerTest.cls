@isTest 
private class ContactTriggerTest {
    @TestSetup
    static void makeData() {
        List<Contact> someContacts = new List<Contact>();
        for(Integer i = 0; i < 200; i++) {
            Contact aContact = new Contact(LastName = 'c'+i);
            someContacts.add(aContact);
        }
        insert someContacts;
    }

    @isTest static void singleTest() {
        Test.startTest();

        // tests for success on a single record
        Contact c1 = new Contact(LastName = 'dog');
        insert c1;

        // tests for failure on a single record
        Contact c2 = new Contact(LastName = 'c'+1);
        Database.SaveResult sr = Database.insert(c2,false);
        Integer numFailed = 0;
        if(!sr.isSuccess()) {
            numFailed = 1;
        }
        System.assertEquals(1, numFailed);

        Test.stopTest();
    }
    
    @isTest static void bulkTest() {
        Test.startTest();

        // tests for success on bulk test data
        List<Contact> insertContacts = new List<Contact>();
        for(Integer i = 0; i < 200; i++) {
            Contact c = new Contact(LastName = 'r'+i);
            insertContacts.add(c);
        }
        insert insertContacts;
        
        // tests for failure on bulk test data with 1 failure
        List<Contact> insertContacts2 = new List<Contact>();
        for(Integer i = 1; i < 200; i++) {
            Contact c = new Contact(LastName = 's'+i);
            insertContacts2.add(c);
        }
        Contact c1 = new Contact(LastName = 'c'+0);
        insertContacts2.add(c1);
        List<Database.SaveResult> sr = Database.insert(insertContacts2, false);
		Integer numFailed = 0;
        for(Database.SaveResult result : sr){
            if(!result.isSuccess()){
                numFailed += 1;
            }
        }
        System.assertEquals(1, numFailed);
        
        Test.stopTest();      
    }
}