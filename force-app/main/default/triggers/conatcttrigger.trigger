trigger conatcttrigger on Contact (after insert,after update) {
    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {
            List<Case> cases= new List<Case>();
            for(Contact cn:Trigger.new){
                Case c=new Case();
                c.ContactId=cn.Id;
                c.subject=cn.Name+cn.MobilePhone;
                c.ClosedDate__c=cn.Birthdate;
                cases.add(c);
            }
            if(!cases.isEmpty()){
                insert cases;
            }
        }
    }
}