public class ContactTrigger {
    public static void insertedcontacts(List<Contact> clist)
    {
        List<Account> accs= new List<Account>();
       // List<Account> relatedaccs = new List<Account>();
        
    for(Contact c:clist){
        List<Account> relatedaccs=[SELECT Id,No_of_Child_contacts__c,No_of_contact_checked__c from Account Where Id=:c.AccountId ];
        for(Account a:relatedaccs){
        a.No_of_Child_contacts__c=a.No_of_Child_contacts__c+1;
            if(c.checked__c==true){
                a.No_of_contact_checked__c=a.No_of_contact_checked__c+1;
            }
            accs.add(a);
        }
    }
        /*if(!accs.isEmpty())
        {
            update accs;
        }*/
    }
    public static void deletedcontacts(List<Contact> clist){
        List<Account> accs= new List<Account>();
        for(Contact c:clist){
            List<Account> relatedaccs=[SELECT Id,No_of_Child_contacts__c from Account Where Id=:c.AccountId];
            for(Account a:relatedaccs){
                a.No_of_Child_contacts__c=a.No_of_Child_contacts__c-1;
                update accs;
            }
        }
    }
   
     /* public static void updatedcontacts(List<Contact> conListNew)
    {
        System.debug('updatedcontacts=====>');
        
        for(Contact con : conListNew )
        {
            System.debug('con.Checked__c===>'+con.Checked__c);
        
            if(con.Checked__c == True)
            {
                List<Account> accList = [SELECT Id,No_of_contact_checked__c FROM Account WHERE Id = :con.AccountId];
                for(Account acc : accList)
                {
                    acc.No_of_contact_checked__c = acc.No_of_contact_checked__c + 1;
                    Update acc;
                }
            }
            else if(con.Checked__c==false)
            {
                System.debug('Checked is ===> False');
            }
        }
        
    }*/
    public static void updatedcontacts(List<Contact> conList , Map<Id,Contact> conListOld)
    {
        List<Account> accListUpd = new List<Account>();
        for(Contact con : conList )
        {
            if(con.Checked__c==True && con.Checked__c!=conListOld.get(con.Id).Checked__c)
            {
                List<Account> accList = [SELECT Id,No_of_contact_checked__c FROM Account WHERE Id = :con.AccountId];
                for(Account acc : accList)
                {
                    acc.No_of_contact_checked__c = acc.No_of_contact_checked__c+1;
                    update acc;
                }
            }
            else if(con.Checked__c==false && con.Checked__c!=conListOld.get(con.Id).Checked__c)
            {
                List<Account> accList = [SELECT Id FROM Account WHERE Id = :con.AccountId];
                for(Account acc : accList)
                {
                    acc.No_of_contact_checked__c = acc.No_of_contact_checked__c-1;
                    update acc;
                }
            }
        }
}
}