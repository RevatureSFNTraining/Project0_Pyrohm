trigger DeliveryTrigger on Delivery__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {

        }
        when BEFORE_UPDATE {
           
        }
        when BEFORE_DELETE {

        }
        when AFTER_INSERT {

        }
        when AFTER_UPDATE {
			
        }
        when AFTER_DELETE {
            SendEmail.cancelledDelivery(Trigger.old);
        }
        when AFTER_UNDELETE {

        }
        when else {

        }
    }
}