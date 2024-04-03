trigger AccountUpdateEvent on Account (after update) {
        for(Account a:Trigger.New){
        PublishUpdateEvent.publishRecordUpdate(a.Id);
    }

}