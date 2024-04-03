public with sharing class HightlightPanelController {
    @AuraEnabled(cacheable = true)
    public static Account getAccount(String recordId) {
        Account acc = [SELECT Id, Phone, Name, Industry, Website,site,Type,owner.Name FROM Account WHERE Id = :recordId];
        return acc;
    }

}