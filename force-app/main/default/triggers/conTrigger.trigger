trigger conTrigger on Contact (after insert,after delete ,after update) {

    if(Trigger.isAfter && Trigger.isInsert){
        ContactTrigger.insertedcontacts(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        ContactTrigger.deletedcontacts(Trigger.old);
    }
    
}