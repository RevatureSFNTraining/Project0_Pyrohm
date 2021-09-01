public with sharing class ContactsTriggerHandler {
    public static void contactUpdate(List<Contact> contact) {
        for(Contact c : contact) {
            c.Description = 'Contact Updated by ' + userInfo.getUserEmail();
        }
    }
}