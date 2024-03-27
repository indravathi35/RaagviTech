@isTest
class AccountTriggerHandlerTest {
    @isTest
    static void insertedcontactsTest(){
        Account testacc = new Account();
        testacc.Name = 'indravathi';
        insert testacc;
        
        Contact testcon = new Contact();
        testcon.LastName = 'vathi';
        testcon.AccountId = testacc.Id;
        testcon.checked__c = true;
        insert testcon;
        
        List<Contact> conList= new List<Contact>();
            conList.add(testcon);
            
        Test.startTest();
        AccountTriggerHandler.insertedcontacts(conList);
        Test.stopTest();
        Account updatedacc=[SELECT Id, No_of_Child_contacts__c, No_of_contact_checked__c FROM Account WHERE Id = :testacc.Id];
        System.assertEquals(1,updatedacc.No_of_Child_contacts__c) ;
        System.assertEquals(1,updatedacc.No_of_contact_checked__c);
    }
    @isTest
    static void deletedcontactsTest(){
        Account testacc=new Account();
        testacc.Name='LekhaSri';
        insert testacc;
        Contact testcon=new Contact();
        testcon.LastName='SRI';
        testcon.AccountId=testacc.Id;
        insert testcon;
        
        List<Contact> conList=new List<Contact>();
        conList.add(testcon);
        
        Test.startTest();
        AccountTriggerHandler.deletedcontacts(conList);
        Test.stopTest();
        
        
    }

}