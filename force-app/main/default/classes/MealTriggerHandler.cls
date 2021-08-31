public with sharing class MealTriggerHandler {
    public static void checkIfOutOfStock(list<Meal__c> insertMeals) {
        for(Meal__c aMeal: insertMeals) {
            Food__c aFood = [SELECT Stock_Amount__c FROM Food__c WHERE Id =: aMeal.Food__c LIMIT 1];
            if(aMeal.Food_Recipe_Amount__c >= aFood.Stock_Amount__c) {
                aMeal.addError('Cannot Insert Meal, Out of Stock on the Food');
            }
        }
    }
}