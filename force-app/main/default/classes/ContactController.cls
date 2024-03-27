// ContactController.cls
public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactsByAccount(String accountId) {
        return [SELECT Id, Name,Phone, Description FROM Contact WHERE AccountId = :accountId];
    }
}