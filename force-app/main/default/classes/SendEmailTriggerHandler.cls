public class SendEmail {
    public static void cancelledDelivery(List<Delivery__c> d) {
        //Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        system.debug(d);
        //query associated stores
     
        List<Store__c> stores = [SELECT Name, CreatedById FROM Store__c WHERE Store__c.id = :d[0].store__c ];
        List<User> userEmail = [SELECT Email FROM User WHERE id = :stores[0].CreatedById];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {userEmail[0].email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Delivery Cancelled!');
        mail.setPlainTextBody('We are emailing you to inform you the delivery' + d[0].id + 'has been cancelled, thanks.');
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                     new Messaging.SingleEmailMessage[] { mail });
            
        // Call a helper method to inspect the returned results
        inspectResults(results);
    }
    
     private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
        
        // sendEmail returns an array of result objects.
        // Iterate through the list to inspect results. 
        // In this class, the methods send only one email, 
        // so we should have only one result.
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                sendResult = false;
                System.debug('The following errors occurred: ' + res.getErrors());                 
            }
        }
        
        return sendResult;
    }
}