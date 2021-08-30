public with sharing class DistributionContractTriggerHandler {
    public static void stopDeleteActive(list<Distribution_Contract__c> DistContracts) {
        for(Distribution_Contract__c dC: DistContracts) {
            if(dC.Is_Active__c) {
                dC.addError('Cannnot Delete an Active Contract');
            }
        }
    }
}
