public with sharing class ContactCreateController {
    @AuraEnabled
    public static void createContact(Contact newContact) {
        try {
            insert newContact;
            System.debug('Contact created successfully: ' + newContact.Id);
        } catch (Exception e) {
            System.debug('Error creating contact: ' + e.getMessage());
            throw new AuraHandledException('Error creating contact: ' + e.getMessage());
        }
    }
}