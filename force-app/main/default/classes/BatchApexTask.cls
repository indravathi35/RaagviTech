public class BatchApexTask implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator([SELECT email__c,Name,Rating,BillingStreet,BillingCountry,BillingState,BillingCity,ShippingCity,ShippingCountry,ShippingStreet,ShippingState FROM Account]);
    }
    public void execute(Database.BatchableContext context,List<Account> acc)
    {
        List<Account> recordsToUpdate=new List<Account>();
        for(Account a:acc){
            a.Name='updated from batch';
            a.Rating='Warm';
            a.BillingStreet='Main';
            a.BillingCity='Vizianagaram';
            a.BillingState='Andhrapradesh';
            a.BillingCountry='India';
            a.ShippingStreet='Kolli';
            a.ShippingCity='Bobbili';
            a.ShippingState='Andhrapradesh';
            a.ShippingCountry='India';
            recordsToUpdate.add(a);
        }
        
        update recordsToUpdate;
        
    }
    public void finish(Database.BatchableContext context)
    {
        System.debug('inside finish method');
        List<Account> accountList = [SELECT Id, Name, email__c FROM Account];
        System.debug('accountList====>'+accountList);
        for(Account acc:accountList)
        {
            if(acc.email__c != Null)
            {
                System.debug('inside if');
             Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
             List<String> sendTo = new List<String>();
             sendTo.add(acc.email__c);
             email.setToAddresses(sendTo);
             email.setSubject('test email from apex');
             email.setPlainTextBody('This email is regarding your account'+acc.Name+'. your account has been updated.');
             System.debug('email'+email);
             Messaging.Email[] emails=new Messaging.Email[]{email};
             Messaging.sendEmail(emails);
            }
            else
            {
                System.debug('qhgwjygwuqw');
                List<Contact> con = [Select AccountId,Email From Contact Where AccountId =: acc.Id];
                for(Contact c:con){
                 Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
                 List<String> sendTo = new List<String>();
                 sendTo.add(c.Email);
                 email.setToAddresses(sendTo);
                 email.setSubject('test email from apex');
                 email.setPlainTextBody('This email is regarding your account accname. your account has been updated.');
                 Messaging.Email[] emails=new Messaging.Email[]{email};
                 Messaging.sendEmail(emails);
            }
        }
        }
    }
}