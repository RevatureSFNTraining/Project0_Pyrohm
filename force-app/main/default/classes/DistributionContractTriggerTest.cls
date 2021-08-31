@isTest
private class DistributionContractTriggerTest {
    @TestSetup
    static void makeData(){
        
        List<Distribution_Contract__c> dContracts = new List<Distribution_Contract__c>();
        Account a = new Account(name='hi');
        Distributor__c d = new Distributor__c(name='hi');
        insert a;
        insert d;
        a = [SELECT Id FROM Account WHERE Name = 'hi' LIMIT 1];
        d = [SELECT Id FROM Distributor__c WHERE Name = 'hi' LIMIT 1];
        for(Integer i = 0; i < 100; i++) {
            Distribution_Contract__c aDContract = new Distribution_Contract__c(Name = 'true contracts', Is_Active__c = true, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
            dContracts.add(aDContract);
        }
        for(Integer i = 0; i < 100; i++) {
            Distribution_Contract__c aDContract = new Distribution_Contract__c(Name = 'false contracts', Is_Active__c = false, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
            dContracts.add(aDContract);
        }

        insert dContracts;
    }

    @isTest static void singleTest() {
        Test.startTest();
        Account a = [SELECT Id FROM Account WHERE Name = 'hi' LIMIT 1];
        Distributor__c d = [SELECT Id FROM Distributor__c WHERE Name = 'hi' LIMIT 1];
        
        // Test Success on one record
        Distribution_Contract__c aDistContract = new Distribution_Contract__c(Name = 'test contract', Is_Active__c = false, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
        insert aDistContract;
        Database.DeleteREsult dr1 = Database.delete(aDistContract, false);
        Integer numSuccess = 0;
        if(dr1.isSuccess()) {
            numSuccess = 1;
        }
        
        // Test Fail on one record
        Distribution_Contract__c aDistContract2 = new Distribution_Contract__c(Name = 'test contract', Is_Active__c = true, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
        insert aDistContract2;
        Database.DeleteResult dr = Database.delete(aDistContract, false);
        Integer numFail = 0;
        if(!dr.isSuccess()) {
            numFail = 1;
        }
        System.assertEquals(1, numFail);
        System.assertEquals(1, numSuccess);
        Test.stopTest();
    }

    @isTest static void bulkTest() {
		Test.startTest();
        Account a = [SELECT Id FROM Account WHERE Name = 'hi' LIMIT 1];
        Distributor__c d = [SELECT Id FROM Distributor__c WHERE Name = 'hi' LIMIT 1];
        
        List<Distribution_Contract__c> distrContractsSuccess = new List<Distribution_Contract__c>();
        List<Distribution_Contract__c> distrContractsFail = new List<Distribution_Contract__c>();
        
        for(Integer i = 0; i < 200; i++) {
            Distribution_Contract__c aDContract = new Distribution_Contract__c(Name = 'true contracts', Is_Active__c = true, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
            distrContractsFail.add(aDContract);
        }
        for(Integer i = 0; i < 200; i++) {
            Distribution_Contract__c aDContract = new Distribution_Contract__c(Name = 'false contracts', Is_Active__c = false, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
            distrContractsSuccess.add(aDContract);
        }
        
        insert distrContractsFail;
        insert distrContractsSuccess;
        
        List<Database.deleteResult> drsSuccess = Database.delete(distrContractsSuccess, false);
        List<Database.deleteResult> drsFail = Database.delete(distrContractsFail, false);

        Integer numSuccess = 0;
        for(Database.DeleteResult dr: drsSuccess) {
            if(dr.isSuccess()) {
                numSuccess++;
            }
        }
        Integer numFail = 0;
        for(Database.DeleteResult dr: drsFail) {
            if(!dr.isSuccess()) {
                numFail++;
            }
        }
        
        System.assertEquals(200, numSuccess);
        System.assertEquals(200, numFail);
        
        Test.stopTest();
    }
    
    @isTest static void bulkTestMix() {
        Test.startTest();
        Account a = [SELECT Id FROM Account WHERE Name = 'hi' LIMIT 1];
        Distributor__c d = [SELECT Id FROM Distributor__c WHERE Name = 'hi' LIMIT 1];
        
        List<Distribution_Contract__c> distrContracts = new List<Distribution_Contract__c>();
        
        for(Integer i = 0; i < 100; i++) {
            Distribution_Contract__c aDContract = new Distribution_Contract__c(Name = 'true contracts', Is_Active__c = true, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
            distrContracts.add(aDContract);
        }
        for(Integer i = 0; i < 100; i++) {
            Distribution_Contract__c aDContract = new Distribution_Contract__c(Name = 'false contracts', Is_Active__c = false, Account__c = a.Id, Distributor__c = d.Id, Cost__c = 5, Product_Count__c = 5);
            distrContracts.add(aDContract);
        }
        
        insert distrContracts;
        
        Integer numFails = 0;
        Integer numSuccess = 0;
        List<Database.DeleteResult> drs = Database.delete(distrContracts, false);
        for(Database.DeleteResult dr: drs) {
            if(!dr.isSuccess()) {
                numFails++;
            } else {
                numSuccess++;
            }
        }
        
        System.assertEquals(100, numFails);
        System.assertEquals(100, numSuccess);
        
        Test.stopTest();
    }
}