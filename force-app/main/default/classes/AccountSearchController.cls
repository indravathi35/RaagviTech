public with sharing class AccountSearchController {
    //public static List<Account> searchAccountList=NEW List<Account>();
    @AuraEnabled
    public static List<Account> AccountSearchController(String namevalue) {
        String searchInput='%'+Namevalue+'%';

        List<Account> AccountList=[SELECT Id, Name, Website, Phone FROM Account WHERE Name LIKE :searchInput WITH SECURITY_ENFORCED];
        //searchAccountList=AccountList;
        return AccountList;
    }
    @AuraEnabled
    public static List<Contact> getAccountList(String namevalue) {
      List<Account>  searchAccountList=AccountSearchController.AccountSearchController(namevalue);
        List<Contact> conList=new List<Contact>();
        conList=[SELECT ID,LastName,Phone,AccountId FROM Contact WHERE AccountId IN: searchAccountList];
        return conList;
    }


    
}