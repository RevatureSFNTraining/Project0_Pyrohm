public with sharing class EmployeeTriggerHandler {
    public static void checkIfPastEmployee(List<Employee__c> employees, Map<Id,Employee__c> employeesMap) {
        for(Employee__c e: employees) {
            if(e.End_Employment_Date__c != NULL) {
                EmployeesMap.get(e.Id).addError('Cannot Update Record of Past Employees. For archive use only');
            }
        }
    }
}