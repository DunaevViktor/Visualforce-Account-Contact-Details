public with sharing class AccountDetailsViewController {

    public List<Account> accountList {get;set;}
    public List<SelectOption> accountSelectOptionList {get;set;}
    public List<SelectOption> paginationSizeOptions{get;set;}
    public String accountId {get;set;}
    public Account accountWithAllDetails {get;set;}
    public Integer numOfRecords {get; set;} 
    public Integer numOfPages {get;set;}
    public Integer size{get;set;}  
    public Contact newContact {get;set;}
    public Account newAccount {get;set;}
    public Boolean isAccountForm {get;set;}
    public Boolean isContactForm {get;set;}

    public ApexPages.StandardSetController contactsController {get;set;}

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

        size = 5;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
   
        getAllDetails();
    }

    //Gets details for a given account
    public void getAllDetails(){
        accountWithAllDetails = [SELECT Id, Name, AccountNumber, Type, Phone, Industry,
        AnnualRevenue, Rating, Fax, NumberOfEmployees, SLAExpirationDate__c
        FROM Account WHERE Id =: accountId];

        contactsController = new ApexPages.StandardSetController(Database.getQueryLocator(
            [SELECT Id, Name, Title, Phone, AccountId FROM Contact WHERE AccountId =: accountWithAllDetails.Id]));
        contactsController.setPageSize(size);

        numOfRecords = contactsController.getResultSize();
        numOfPages = setNumOfPages(size, numOfRecords);
    }

    public List<Contact> getContacts(){
        return contactsController.getRecords();
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

    //Updates the number of pages
    public void refreshPageSize() {
        contactsController.setPageSize(size);
        numOfRecords = contactsController.getResultSize();
        numOfPages = setNumOfPages(size, numOfRecords);
    }

    //Calculates the number of pages
    public Integer setNumOfPages(Integer size, Integer numOfRecords){
        Integer remainder = Math.mod(numOfRecords, size);
        if(remainder == 0){
            return numOfRecords/size;
        }
        else{
            return numOfRecords/size + 1;
        }
    }

    //Adds a new account to the database
    public void saveAccount() {
        insert newAccount;
        accountSelectOptionList.add(new SelectOption(newAccount.Id, newAccount.Name));
        this.closeAccountForm();
        newAccount = new Account();
    }

    //Adds a new contact to the database
    public void saveContact() {
        newContact.AccountId = accountWithAllDetails.Id;
        insert newContact;
        this.getAllDetails();
        this.closeContactForm();
        newContact = new Contact();
    }
}