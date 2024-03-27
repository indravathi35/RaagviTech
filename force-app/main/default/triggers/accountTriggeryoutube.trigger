trigger accountTriggeryoutube on Account (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            //AccountTrigger.copyBillingToShipping(Trigger.New);
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            //AccountTrigger.copyBillingToShipping(Trigger.New);
        }
    }
}