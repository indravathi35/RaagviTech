public with sharing class GetAddress {
    @AuraEnabled(cacheable=true)
    public static List<Account> methodName(String recId){
        
            return [SELECT BillingCity From Account WHERE id=:recId];
            
    }
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String recId)
    {
        
            return [SELECT Id, Subject,CaseNumber FROM Case WHERE AccountId = :recId ];
        }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String recId){
      
            return [SELECT FirstName,LastName,Phone,Email FROM Contact WHERE AccountId=:recId];
            
        
    }
    @AuraEnabled
    public static List<Contact> insertContact(String firstName, String lastName, String email ,String phone) {
        List<Contact> conList=new List<Contact>();
        Contact newContact = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = email,
            Phone=phone
        );
        conList.add(newContact);
        insert conList;
        return conList;
    }
    
}