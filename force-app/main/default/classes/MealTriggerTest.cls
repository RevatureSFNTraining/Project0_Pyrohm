@isTest
private class MealTriggerTest {
    @TestSetup
    static void makeData(){
        List<Food__c> foods = new List<Food__c>();
        foods.add(new Food__c(Name = 'aFood1', Stock_Amount__c = 5));
        foods.add(new Food__c(Name = 'aFood2', Stock_Amount__c = 50));
        insert foods;
    }

    @isTest static void singleTest() {
        Test.startTest();
        
        Food__c aFood1 = [SELECT Id, Stock_Amount__c FROM Food__c WHERE Name = 'aFood2' LIMIT 1];
        Meal__c aMealSuccess = new Meal__c(Name = 'meal success', Food__c = aFood1.Id, Food_Recipe_Amount__c = 10);
        Food__c aFood2 = [SELECT Id, Stock_Amount__c FROM Food__c WHERE Name = 'aFood1' LIMIT 1];
        Meal__c aMealFail = new Meal__c(Name = 'meal fail', Food__c = aFood2.Id, Food_Recipe_Amount__c = 10);

        Database.SaveResult srSuccess = Database.insert(aMealSuccess, false);
        Database.SaveResult srFail = Database.insert(aMealFail, false);
        
		Integer numSuccess = 0;
        if(srSuccess.isSuccess()) {
            numSuccess++;
        }
        Integer numFail = 0;
        if(!srFail.isSuccess()) {
            numFail++;
        }
        
        System.assertEquals(1, numSuccess);
        System.assertEquals(1, numFail);
        
        Test.stopTest();
    }

    @isTest static void bulkTestSuccess() {
        Test.startTest();
        
        Food__c aFood1 = [SELECT Id, Stock_Amount__c FROM Food__c WHERE Name = 'aFood2' LIMIT 1];
        
        List<Meal__c> mealsSuccess = new List<Meal__c>();
        
        for(Integer i = 0; i < 200; i++) {
            mealsSuccess.add(new Meal__c(Name = 'meal success '+i, Food__c = aFood1.Id, Food_Recipe_Amount__c = 10));
        }
        
        List<Database.SaveResult> srSuccess = Database.insert(mealsSuccess, false);
        
        Integer numSuccess = 0;
        for(Database.SaveResult sr: srSuccess) {
            if(sr.isSuccess()) {
                numSuccess++;
            }
        }
        
        System.assertEquals(200, numSuccess);
        
        Test.stopTest();
    }
    
    @isTest static void bulkTestFail() {
        Test.startTest();
        
        Food__c aFood2 = [SELECT Id, Stock_Amount__c FROM Food__c WHERE Name = 'aFood1' LIMIT 1];
        
        List<Meal__c> mealsFail = new List<Meal__c>();
        
        for(Integer i = 0; i < 200; i++) {
            mealsFail.add(new Meal__c(Name = 'meal fail ' +i, Food__c = aFood2.Id, Food_Recipe_Amount__c = 10));
        }
        
        List<Database.SaveResult> srFail = Database.insert(mealsFail, false);
        
        Integer numFail = 0;
        for(Database.SaveResult sr: srFail) {
            if(!sr.isSuccess()) {
                numFail++;
            }
        }
        
        System.assertEquals(200, numFail);
        
        Test.stopTest();
    }
    
    @isTest static void bulkTestMix() {
        Test.startTest();
        
        Food__c aFood1 = [SELECT Id, Stock_Amount__c FROM Food__c WHERE Name = 'aFood2' LIMIT 1];
        Food__c aFood2 = [SELECT Id, Stock_Amount__c FROM Food__c WHERE Name = 'aFood1' LIMIT 1];
        
        List<Meal__c> mealsSuccess = new List<Meal__c>();
        List<Meal__c> mealsFail = new List<Meal__c>();
        
        for(Integer i = 0; i < 100; i++) {
            mealsSuccess.add(new Meal__c(Name = 'meal success '+i, Food__c = aFood1.Id, Food_Recipe_Amount__c = 10));
        }
        for(Integer i = 0; i < 100; i++) {
            mealsFail.add(new Meal__c(Name = 'meal fail ' +i, Food__c = aFood2.Id, Food_Recipe_Amount__c = 10));
        }
        
        List<Database.SaveResult> srSuccess = Database.insert(mealsSuccess, false);
        List<Database.SaveResult> srFail = Database.insert(mealsFail, false);
        
        Integer numSuccess = 0;
        for(Database.SaveResult sr: srSuccess) {
            if(sr.isSuccess()) {
                numSuccess++;
            }
        }
        Integer numFail = 0;
        for(Database.SaveResult sr: srFail) {
            if(!sr.isSuccess()) {
                numFail++;
            }
        }
        
        System.assertEquals(100, numSuccess);
        System.assertEquals(100, numFail);
        
        Test.stopTest();
    }
}