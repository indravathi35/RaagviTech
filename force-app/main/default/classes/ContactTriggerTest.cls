@isTest
public class ContactTriggerTest {
    @isTest
    static void testInsertedContacts(){
        Account testacc= new Account();
        testacc.Name='indhu';
        insert testacc;
        
        Contact testcon= new Contact();
        testcon.LastName='mathi';
        testcon.checked__c=true;
        testcon.AccountId=testacc.Id;
        insert testcon;
        
        List<Contact> conlist=new List<Contact>();
        conlist.add(testcon);
        
        Test.startTest();
        ContactTrigger.insertedcontacts(conlist);
        Test.stopTest();
        
        Account updatedaccs=[SELECT No_of_contact_checked__c,No_of_Child_contacts__c FROM Account Where id=:testacc.Id];
        System.assertEquals(1,updatedaccs.No_of_Child_contacts__c) ;
        System.assertEquals(1,updatedaccs.No_of_contact_checked__c);
    }

}