public with sharing class ContactTriggerHandler {
    public static void stopDuplicateContact(list<Contact> triggerContacts) {
        list<Contact> existingContacts = [SELECT Name FROM Contact];
        for(Contact triggerC: triggerContacts) {
            for(Contact orgC: existingContacts) {
                if(triggerC.Name = orgC.Name) {
                    triggerC.addError('Cannot Insert Contact. Contact already exists in the system');
                    break;
                }
            }
        }
    }
}
