trigger UpdateOpportunityAmountOnAccount on SOBJECT (after insert,after delete,after update,after undelete) {

    switch on trigger.operationType{
        when AFTER_INSERT {
            UpdateOpportunityAmountOnAccountHandler.afterInsert(trigger.new);
        }
        when AFTER_DELETE {
            UpdateOpportunityAmountOnAccountHandler.afterInsert(trigger.old);
        }
        when AFTER_UPDATE {
            UpdateOpportunityAmountOnAccountHandler.afterUpdate(trigger.new, trigger.oldMap);  
        }
        when AFTER_UNDELETE {
            UpdateOpportunityAmountOnAccountHandler.afterInsert(trigger.new);
        }
    }

}