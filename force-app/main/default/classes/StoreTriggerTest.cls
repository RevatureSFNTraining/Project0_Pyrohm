@isTest

private class StoreTriggerTest {
    @isTest static void singleTest() {
     	Store__c c = new Store__c(name = 'glennan', location__c = 'washington');
        insert c;
        
        system.debug(c);
        
        Store__c d = new Store__c(name = 'glennan', location__c = 'washington');
  
        
        system.debug(d);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(d, false);   
        Test.stopTest();
        
        System.debug(result);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
      
    }

    
}
