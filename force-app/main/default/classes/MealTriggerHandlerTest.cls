@isTest
public with sharing class MealTriggerHandlerTest {
    @TestSetup
    static void makeData(){
        List<Meal__c> Meals = new list<Meal__c>();
        for(Integer i = 0; i < 200; i++) {
            Meal__c aMeal = new Meal__c(Name = '0'+i);
            Meals.add(aMeal);
        }
        insert Meals;

        List<Food__c> Foods = new List<Food__c>();
        for(Integer i = 0; i < 200; i++) {
            Food__c aFood = new Food__c(Name = 'Tomato'+i);
            Foods.add(aFood);
        }
        insert Foods;
    }
}
