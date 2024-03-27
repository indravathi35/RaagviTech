trigger CaseHandler on Case (after insert,after update) {
    if(Trigger.isAfter)
    if(Trigger.isInsert||Trigger.isUpdate){
        CaseTrigger.CaseTriggerMethod(Trigger.New);
    }

}