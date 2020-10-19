public with sharing class AccountDetailsViewController {

    public List<Account> accountList {get;set;}
    public List<SelectOption> accountSelectOptionList {get;set;}
    public String accountId {get;set;}
    public Account accountWithAllDetails {get;set;}

    public AccountDetailsViewController() {

        accountList = [SELECT Id, Name FROM Account ORDER BY Name ASC];
        accountSelectOptionList = new List<SelectOption>();
        accountId = accountList.isEmpty() == FALSE ? accountList[0].Id : NULL;
        
        for(Account item : accountList){
            accountSelectOptionList.add(new SelectOption(item.Id, item.Name));
        }
   
        getAllDetails();
    }

    public void getAllDetails(){
        accountWithAllDetails = [SELECT Id, Name, AccountNumber, Type, Phone, Industry,
        AnnualRevenue, Rating, Fax, NumberOfEmployees, SLAExpirationDate__c,
        (SELECT Id, Name, Title, Phone, AccountId FROM Contacts) 
        FROM Account WHERE Id =: accountId];   
    }
}