public with sharing class StoreTriggerHandler {
    public static void validateNameUniqueness(list<Store__c> store) {
        list<Store__c> existingStores = [SELECT Name FROM Store__c];
        for (Store__c s : existingStores) {
            for (Store__c newStore : store) {
                system.debug('new store :' + newStore + ', Old Store : ' + s);
                if (newStore.Name == s.Name) {
                    newStore.addError(newStore.name + ' is taken please choose a new name');
                }
            }
        }
    }
}
