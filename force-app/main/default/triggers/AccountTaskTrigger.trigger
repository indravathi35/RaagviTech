trigger AccountTaskTrigger on Account (before insert, after insert, before update, after update,before delete) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            AccountTriggerTask.updateDesc(Trigger.New);
            AccountTriggerTask.populateRating(Trigger.New);
            AccountTriggerTask.emailAlert(Trigger.New);
        }else if(Trigger.isAfter){
            AccountTriggerTask.createOpp(Trigger.New);
            AccountTriggerTask.createRelatedContact(Trigger.New);
             AccountTriggerTask.conTask(Trigger.New);
            AccountTriggerTask.bulkInsertion(Trigger.new);
            //In after insert Trigger.New is read only
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountTriggerTask.updatePhone(Trigger.New, Trigger.oldMap);
           // AccountTriggerHandler.populateRating(Trigger.New,Trigger.oldMap);
        }else if(Trigger.isAfter){
             AccountTriggerTask.updateRelatedContact(Trigger.New,Trigger.oldMap);
             AccountTriggerTask.healthUpdate(Trigger.New,Trigger.OldMap);
        }
    }
    if(Trigger.isDelete){
        if(Trigger.isBefore){
          AccountTriggerTask.preventDeletion(Trigger.old);
        }else if(Trigger.isAfter){
        }
    }

}