public with sharing class UpdateOpportunityAmountOnAccountHandler {
    public UpdateOpportunityAmountOnAccountHandler() {

    }

    public static void afterInsert(List<Opportunity> newOpportunities) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp: newOpportunities){
            if(opp.AccountId!=null && opp.Amount!=null){
                accountIds.add(opp.AccountId);
            }
        }

        if(!accountIds.isEmpty()){
            UpdateOpportunityAmountOnAccountHelper.updateAccountOpportunities(accountIds);
        }
    }

    public static void afterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity newOpp: newOpportunities){
            Opportunity oldOpp = oldOpportunities.get(newOpp.Id);
            if(newOpp.AccountId != null && newOpp.Amount != null && (oldOpp == null || oldOpp.Amount != newOpp.Amount)){
                accountIds.add(newOpp.AccountId);
            }
        }

        if(!accountIds.isEmpty()){
            UpdateOpportunityAmountOnAccountHelper.updateAccountOpportunities(accountIds);
        }
    }

    
}