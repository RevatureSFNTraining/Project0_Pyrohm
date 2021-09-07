@isTest

private class SendEmailTest {
    @isTest static void singleTest() {
        Store__c store = new Store__c(Name='Johns Store', Location__c='Washington TWP');
        insert store;
        system.debug(store);
            
        Store__c newStoreID = [select id from store__c where name='Johns Store'];
        system.debug(newStoreID.Id);
        
        Delivery__c deliv = new Delivery__c(Name = 'old Delivery', Store__c = newStoreID.id, Quantity__c = 1000 );
        insert deliv;
        
        Test.startTest();

        Database.DeleteResult result = Database.delete(deliv);

        Integer emailInvocations = Limits.getEmailInvocations();

        Test.stopTest();
        
        system.debug(result.getErrors());

        system.assertEquals(1, emailInvocations);
        
    }
    
}
