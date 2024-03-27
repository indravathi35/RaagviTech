public with sharing class AccountWrapperController {
    @AuraEnabled(cacheable=TRUE)
    public  static List<WrapperClass>fetchAccData()
    {
 
        List<WrapperClass> wrapperOppList=NEW List<WrapperClass>();
        FOR(Account opp:[SELECT Id, Name, Amount__c,Description FROM Account])
        {
 
            WrapperClass wrapItemFld=NEW WrapperClass();
            wrapItemFld.Name=opp.Name;
            wrapItemFld.Description=opp.Description;
            wrapperOppList.add(wrapItemFld);
        }
        RETURN wrapperOppList;
    }
 
    public class WrapperClass
    {
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public String Description;   
 
    }
}