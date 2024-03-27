public with sharing class PublishUpdateEvent {
    @AuraEnabled
    public static void publishRecordUpdate(String recordId) {
        
        Record_Update_Event__e event = new Record_Update_Event__e(
            RecordId__c = recordId
        );
        Database.SaveResult result = EventBus.publish(event);
        if (result.isSuccess()) {
            System.debug('Event published successfully: ' + result);
        } else {
            for(Database.Error error : result.getErrors()) {
                System.debug('Error publishing event: ' + error);
            }
        }
    }
}