@IsTest
public class BatchApexEmailTest {
    public static testMethod void batchTest(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            accounts.add(acc);
        }
        insert accounts;
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 2; i++) {
            Contact con = new Contact(LastName='indravathi'+i,AccountId = accounts[i].Id, Email = 'contact' + i + '@example.com');
            contacts.add(con);
        }
        insert contacts;
        Test.startTest();
        BatchApexTask t=new BatchApexTask();
        database.executeBatch(t);
        Test.stopTest();
    }
    public static testMethod void emailTest(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i, email__c = 'test' + i + '@example.com');
            accounts.add(acc);
        }
        insert accounts;
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 2; i++) {
            Contact con = new Contact(LastName='indravathi'+i,AccountId = accounts[i].Id, Email = 'contact' + i + '@example.com');
            contacts.add(con);
        }
        insert contacts;
        Test.startTest();
        BatchApexTask t=new BatchApexTask();
        database.executeBatch(t);
        Test.stopTest();
    }
}