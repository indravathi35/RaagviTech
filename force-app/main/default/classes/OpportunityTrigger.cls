public with sharing class OpportunityTrigger
 {
    public static void OpportunityTriggerMethod(List<Opportunity> oppList)
     {
        for(Opportunity oppobj:oppList)
        {
                if(oppobj.delivery_installation_status__c.equals('started'))
                {
                    Account acc=new Account();
                    acc.Name=oppobj.Name;
                    acc.Opportunity__c=oppobj.Id;
                    insert acc;
                    Contact con=new Contact();
                    con.LastName=acc.Name;
                    con.AccountId=acc.Id;
                    insert con;
                }
        }
    }
    public static void OpportunityUpdate(List<Opportunity> oplist)
    {
        List<Contact> contactList = new List<Contact>();
        List<OpportunityContactRole> oppConRoleList = new List<OpportunityContactRole>();
        for(Opportunity opp : oplist)
        {
            contactList = [SELECT Id FROM Contact WHERE AccountId=:opp.AccountId];
        }
        for(Opportunity oppObj:oplist)
        {
            if(oppObj.delivery_installation_status__c=='in progress')
            {
                oppObj.StageName='Closed Won';
                OpportunityContactRole oppConRole = new OpportunityContactRole();
                oppConRole.OpportunityId=oppObj.Id;
                oppConRole.Role='Decision Maker';
                oppConRole.ContactId=contactList[0].Id;// no hard coding of ids.
                oppConRole.Name__c=oppObj.Name;
                oppConRoleList.add(oppConRole);
            }
            else if(oppObj.delivery_installation_status__c=='completed')
            {
                oppObj.StageName='Closed Lost';
                List<Account> acclist = [SELECT Id FROM account WHERE Opportunity__c IN :oplist ];
                List<OpportunityContactRole> oppList = [SELECT Id FROM OpportunityContactRole WHERE OpportunityId IN:oplist];
                System.debug('accList ::: '+accList);
                System.debug('oppList ::: '+oppList);
                if(!accList.isEmpty() && !oppList.isEmpty())
                {
                    delete accList;
                    delete oppList;
                }
            }
        }
        if(!oppConRoleList.isEmpty())
        {
            insert oppConRoleList;
        }
    }
}