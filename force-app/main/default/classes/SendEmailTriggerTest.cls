@isTest

private class SendEmailTest {
    @isTest static void singleTest() {
        
        Delivery__c d = new Delivery__c(Name = 'New Delivery', Store__c = 'a005f000001hXCtAAM', Quantity__c = 10 );
        insert d;
        
        Test.startTest();
        
        

        System.debug(d);
        
		Database.DeleteResult result = Database.delete(d, false);
        
        System.debug(result);
        
        Integer num = Limits.getEmailInvocations();
        
        system.debug(num);
        
        System.assertEquals(num, 1);
        
        
       
        Test.stopTest();
        
        
        
    }
}
