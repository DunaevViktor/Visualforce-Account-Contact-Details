trigger accountUpdateTrigger on Account (after update) {
    
    if(isFirstAccountTrigger.isFirstFunc()) {
        
        Set<Id> accountId = new Set<Id>();
        for(Account acc : Trigger.New) {
            accountId.add(acc.Id);
        }
        
        List<Account> accountList = [SELECT Id, Description, (SELECT Id, Description FROM Contacts)
                                     FROM Account WHERE Id IN :accountId];
        
        List<Contact> contacts = new List<Contact>();
        
        for (Account acc : accountList) {
            for(Contact con: acc.Contacts) {
                con.Description = acc.Description;
                contacts.add(con);
            }
        }
        
        upsert contacts;
    }
    
}