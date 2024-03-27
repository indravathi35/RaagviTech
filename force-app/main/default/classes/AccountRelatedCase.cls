public with sharing class AccountRelatedCase {
    @AuraEnabled
    public static Account getAccountFields(String AccountId){
        Account accn=[SELECT Id,Subject__c,Phone__c,email__c,Status__c,Priority__c FROM Account WHERE Id=:AccountId];
        return accn;
    }
    @AuraEnabled
    public static void AccountRelatedCase(String AccountId,Map<String ,Object> obj) {
        Case c= new Case();
        c.AccountId=AccountId;
        c.Subject=(String)obj.get('Subject');
        c.Phone__c=(String)obj.get('Phone');
        c.Email__c=(String)obj.get('Email');
        c.Status=(String)obj.get('Status');
        c.Priority=(String)obj.get('Priority');
        insert c;
        Account acc=new Account();
        acc.Id=AccountId;
        acc.Subject__c=(String)obj.get('Subject');
        acc.Phone__c=(String)obj.get('Phone');
        acc.email__c=(String)obj.get('Email');
        acc.Status__c=(String)obj.get('Status');
        acc.Priority__c=(String)obj.get('Priority');
        update acc;

    }
}