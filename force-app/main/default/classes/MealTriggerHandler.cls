public with sharing class MealTriggerHandler {
    public static void checkIfOutOfStock(list<Meal__c> insertMeals) {
        List<Food__c> Foods = [SELECT Id, Stock_Amount__c FROM Food__c];
        Map<Meal__c, Food__c> foodMealMap = new Map<Meal__c,Food__c>();

        for(Meal__c aMeal: insertMeals) {
            for(Food__c aFood: Foods) {
                if(aMeal.Food__c == aFood.Id) {
                    foodMealMap.put(aMeal, aFood);
                }
            }
        }

        for(Meal__c aMeal: foodMealMap.keySet()) {
            if(aMeal.Food_Recipe_Amount__c > foodMealMap.get(aMeal).Stock_Amount__c) {
                aMeal.addError('Cannot Insert Meal, Out of Stock on the Food');
            }
        }
    }
}