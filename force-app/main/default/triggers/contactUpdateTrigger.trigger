trigger contactUpdateTrigger on Contact (after update) {
    
    if(isFirstContactTrigger.isFirstFunc()) {
        
        Set<Id> accountId = new Set<Id>();
        for(Contact con : Trigger.New) {
            accountId.add(con.AccountId);
        }
        
        List<Account> accountForMap = [SELECT Id, Description FROM Account WHERE Id IN :accountId];
        Map<Id, Account> accountMap = new Map<Id, Account>();
        for(Account acc: accountForMap) {
            accountMap.put(acc.Id, acc);
        }
        
        for(Contact con : Trigger.New) {
            Account acc = accountMap.get(con.AccountId);
            acc.Description = con.Description;
        }
        
        upsert new List<Account>(accountMap.values());
    }
    
}