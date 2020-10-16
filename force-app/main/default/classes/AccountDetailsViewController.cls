public with sharing class AccountDetailsViewController {

    public List<Account> accountList {get;set;}
    public List<SelectOption> accountSelectOptionList {get;set;}
    public List<Contact> contactList {get;set;}
    public String accountId {get;set;}

    public AccountDetailsViewController() {

        accountList = [SELECT Id, Name FROM Account ORDER BY Name ASC];
        accountSelectOptionList = new List<SelectOption>();
        accountId = accountList.isEmpty() == FALSE ? accountList[0].Id : NULL;
        
        for(Account item : accountList){
            accountSelectOptionList.add(new SelectOption(item.Id, item.Name));
        }
   
        getContacts();
    }

    public void getContacts(){
        contactList = [SELECT Id, Name, AccountId FROM Contact WHERE AccountId =: accountId];  
    }
}
