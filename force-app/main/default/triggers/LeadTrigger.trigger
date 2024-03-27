trigger LeadTrigger on Lead (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        LeadTriggerHandler.updateAfterRevenue(Trigger.new);
    }
}