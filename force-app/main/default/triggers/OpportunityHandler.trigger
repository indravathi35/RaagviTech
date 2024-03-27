trigger OpportunityHandler on Opportunity (before insert,after insert,after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTrigger.OpportunityTriggerMethod(Trigger.New);
        }
    }
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            OpportunityTrigger.OpportunityUpdate(Trigger.New);
        }
    }
}