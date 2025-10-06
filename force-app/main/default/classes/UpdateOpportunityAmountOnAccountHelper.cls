public with sharing class UpdateOpportunityAmountOnAccountHelper {
    public UpdateOpportunityAmountOnAccountHelper() {

    }

    public static void updateAccountOpportunities(Set<Id> accountIds) {
        if(!accountIds.isEmpty()){
            List<Opportunity> oppRecords = [SELECT Id, AccountId, Amount FROM Opportunity WHERE AccountId IN :accountIds];

            if(!oppRecords.isEmpty()){
                Map<Id, Double> accountIdToTotalAmountMap = new Map<Id, Double>();
                for(Opportunity opp: oppRecords){
                    if(opp.AccountId!=null && opp.Amount!=null){
                        if(!accountIdToTotalAmountMap.containsKey(opp.AccountId)){
                            accountIdToTotalAmountMap.put(opp.AccountId,0.0)
                        }
                        accountIdToTotalAmountMap.put(opp.AccountId, accountIdToTotalAmountMap.get(opp.AccountId) + opp.Amount);
                    }
                }

                if(!accountIdToTotalAmountMap.isEmpty()){
                    List<Account> accountsToUpdate = new List<Account>();
                    for(Id accountId: accountIdToTotalAmountMap.keySet()){
                        accountsToUpdate.add(new Account(Id=accountId, Total_Opportunity_Amount__c=accountIdToTotalAmountMap.get(accountId)));
                    }
                    if(!accountsToUpdate.isEmpty()){
                        update accountsToUpdate;
                    }
                }
            }
        }
    }
}