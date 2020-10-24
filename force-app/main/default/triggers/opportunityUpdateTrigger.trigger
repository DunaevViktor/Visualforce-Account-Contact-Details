trigger opportunityUpdateTrigger on Opportunity (after update) {
    
    Set<Id> accountId = new Set<Id>();
    for(Opportunity opp: Trigger.New){
        if(opp.StageName == 'Closed Won') {
            accountId.add(opp.AccountId);
        }
    }
    
    Map<Id, Account> accountMap = new Map<Id, Account>();
    List<Account> accountForMap = [SELECT Id, Number_Closed_Opportunity__c, Total_Amount_Closed_Opp__c
                                   FROM Account WHERE Id IN :accountId];
    for(Account acc: accountForMap){
        accountMap.put(acc.Id, acc);
    }
    
    for(Opportunity opp : Trigger.New) {
        if(opp.StageName == 'Closed Won') {
            Account acc = accountMap.get(opp.AccountId);
            acc.Number_Closed_Opportunity__c += 1;
            acc.Total_Amount_Closed_Opp__c += opp.Amount;
        }
    }
    
    upsert new List<Account>(accountMap.values());
    
}