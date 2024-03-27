public with sharing class AccountTriggerHandler {
            public static void insertedcontacts(List<Contact> clist)
            {
                List<Account> accs= new List<Account>();
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
                if(!accs.isEmpty())
                {
                    update accs;
                }
            }
            public static void deletedcontacts(List<Contact> clist){
                List<Account> accs= new List<Account>();
                for(Contact c:clist){
                    List<Account> relatedaccs=[SELECT Id,No_of_Child_contacts__c from Account Where Id=:c.AccountId];
                    for(Account a:relatedaccs){
                        a.No_of_Child_contacts__c=a.No_of_Child_contacts__c-1;
                        accs.add(a);
                    }
                }
                if(!accs.isEmpty())
                {
                    update accs;

                }
}
}