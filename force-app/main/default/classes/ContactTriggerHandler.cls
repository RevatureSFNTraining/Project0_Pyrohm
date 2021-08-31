public class ContactTriggerHandler {
    public static void stopDuplicateContact(list<Contact> triggerContacts) {
        list<Contact> existingContacts = [SELECT FirstName, LastName FROM Contact];
        for(Contact triggerC: triggerContacts) {
            for(Contact orgC: existingContacts) {
                if((triggerC.LastName == orgC.LastName) && (triggerC.FirstName == orgC.FirstName)) {
                    triggerC.addError('Cannot Insert Contact. Contact already exists in the system');
                    break;
                }
            }
        }
    }
}