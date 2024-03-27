trigger ContactIntegrationTrigger on Contact (After update) {
    //String jsonString = json.serialize(Trigger.New);
    
    Set<Id> conIds=new Set<Id>();
    for(Contact c:Trigger.New){
        conIds.add(c.Id);
    }
    system.debug('trigger size -- '+trigger.new.size());
    if(CheckTrigger.firstTime){
    database.executeBatch(new TriggerIntegrationBatch(conIds),100);
    }
}