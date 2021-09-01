public with sharing class ContactsTriggerHandler {
    public static void contactUpdate(List<Contact> contact) {
        for(Contact c : contact) {
            c.Description = 'Contact updated successfully by ' + userInfo.getUserName();
        }
    }
}