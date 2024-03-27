public class AccountRecords {
    public static void bulkInsertion()
    {
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=11;i++)
        {
            Account acc = new Account();
            acc.Name = 'S'+i;
            accList.add(acc);
        }
        if(!accList.isEmpty())
        {
            insert accList;
        }
        for(Account acc : accList)
        {
            for(Integer j=1;j<=3;j++)
            {
                Contact c = new Contact();
                c.AccountId=acc.Id;
                c.LastName=acc.Name+j;
                insert c;
            }
        }
    }
    
    public static void bulkUpdate(Id id)
    {
        List<Contact> conListupd = new List<Contact>();
        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId=: id];
        System.debug('conList=====>'+conList);
        Integer i=0;
        for(Contact con : conList)
        {
            if(Math.mod(i, 2)==0)
            {
                con.Checked__c=true;
                System.debug('for====>');
            }
            
            conListupd.add(con);
            i++;
        }
        System.debug('conListupd====>'+conListupd);
        if(!conListupd.isEmpty())
        {
            System.debug('Update====>');
            update conListupd;
        }
    }
    public static void bulkDelete()
    {
        List<Contact> conList = [SELECT Id FROM CONTACT WHERE AccountId=:'0015j00001BuK6MAAV'];
        delete conList;
    }
}