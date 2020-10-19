public with sharing class AccountDetailsViewController {

    public List<Account> accountList {get;set;}
    public List<SelectOption> accountSelectOptionList {get;set;}
    public String accountId {get;set;}
    public Account accountWithAllDetails {get;set;}
    public Contact newContact {get;set;}
    public Account newAccount {get;set;}
    public Boolean isAccountForm {get;set;}
    public Boolean isContactForm {get;set;}

    public AccountDetailsViewController() {

        accountList = [SELECT Id, Name FROM Account ORDER BY Name ASC];
        accountSelectOptionList = new List<SelectOption>();
        accountId = accountList.isEmpty() == FALSE ? accountList[0].Id : NULL;
        
        for(Account item : accountList){
            accountSelectOptionList.add(new SelectOption(item.Id, item.Name));
        }

        isAccountForm = false;
        isContactForm = false;

        newContact = new Contact();
        newAccount = new Account();
   
        getAllDetails();
    }

    public void getAllDetails(){
        accountWithAllDetails = [SELECT Id, Name, AccountNumber, Type, Phone, Industry,
        AnnualRevenue, Rating, Fax, NumberOfEmployees, SLAExpirationDate__c,
        (SELECT Id, Name, Title, Phone, AccountId FROM Contacts) 
        FROM Account WHERE Id =: accountId];   
    }

    public void openAccountForm() {
        isAccountForm = true;
        newAccount = new Account();
    }

    public void openContactForm() {
        isContactForm = true;
        newContact = new Contact();
    }

    public void closeAccountForm() {
        isAccountForm = false;
    }

    public void closeContactForm() {
        isContactForm = false;
    }

    public void saveAccount() {
        insert newAccount;
        accountSelectOptionList.add(new SelectOption(newAccount.Id, newAccount.Name));
        this.closeAccountForm();
        newAccount = new Account();
    }

    public void saveContact() {
        newContact.AccountId = accountWithAllDetails.Id;
        insert newContact;
        this.getAllDetails();
        this.closeContactForm();
        newContact = new Contact();
    }
}