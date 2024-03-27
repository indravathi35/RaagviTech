@isTest
private class AccountTriggerNewTest {
    @testSetup
    static void setAccounts() {
        List<Account> accList = new List<Account>();
        for(Integer i=1; i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test Tigger'+i ;
            acc.Industry = 'Energy';
            acc.Related_Records__c=True;
            accList.add(acc);
        }
        insert accList;
    }
    @isTest
    static void updateRatingTestMethodPositve(){
        List<Account> updateRating =[Select id,Name,Rating,Industry from Account where Name ='Test Tigger1' Limit 1] ;
        Test.startTest();
        AccountTriggerTask.populateRating(updateRating);
        Test.stopTest();
        System.assertEquals('Hot',updateRating[0].Rating);
    }
    @isTest
    static void updateRatingTestMethodNegative(){
        List<Account> updateRating =[Select id,Name,Rating,Industry from Account where Name ='Test Tigger1' Limit 1] ;
        updateRating[0].Industry='Agriculture';
        update updateRating;
        Test.startTest();
        AccountTriggerTask.populateRating(updateRating);
        Test.stopTest();
        System.assertNotEquals('Hot',updateRating[0].Rating);
    }
    @isTest
    static void createOpportunityTestMethodPositive(){
        List<Account> accounts = [SELECT Id, Name, Related_Records__c, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Name = 'Test Tigger1' LIMIT 1];
        Test.startTest();
        AccountTriggerTask.createOpp(accounts);
        Test.stopTest();
        System.assertEquals(1, accounts.size(), 'Exactly one Account with the name "Test Tigger1" should be found');
        if (!accounts.isEmpty()) {
            Account account = accounts[0];
            List<Opportunity> opportunities = account.Opportunities;
            System.assertEquals(false, opportunities.isEmpty(), 'Opportunities related to the Account are not null');
        }
    }
    @isTest
    static void createOpportunityTestMethodNegative(){
        List<Account> accounts = [SELECT Id, Name,Related_Records__c, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Name = 'Test Tigger1' LIMIT 1];
  		accounts[0].Related_Records__c=False;
        update accounts;
        Test.startTest();
        AccountTriggerTask.createOpp(accounts);
        Test.stopTest();
        System.assertEquals(true, accounts[0].Opportunities.isEmpty(), 'Opportunities related to the Account should be empty');
       /*if (!accounts.isEmpty()) {
            Account account = accounts[0];
            List<Opportunity> opportunities = account.Opportunities;
           system.debug(accounts);
            System.assertEquals(True, opportunities.isEmpty(), 'Opportunities related to the Account are not null');
        } */
    }
    @isTest
    static void createContactTestMethodPositive(){
        List<Account> accounts = [SELECT Id, Name,Related_Records__c, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name = 'Test Tigger1' LIMIT 1];
        Test.startTest();
        AccountTriggerTask.createRelatedContact(accounts);
        Test.stopTest();
        System.assertEquals(1, accounts.size(), 'Exactly one Account with the name "Test Tigger1" should be found');
        if (!accounts.isEmpty()) {
            Account account = accounts[0];
            List<Contact> Contacts = account.Contacts;
            System.assertEquals(false, Contacts.isEmpty(), 'Contacts related to the Account are not null');
        }
    }
     @isTest
    static void createContactTestMethodNegative(){
        List<Account> accounts = [SELECT Id, Name,Related_Records__c, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name = 'Test Tigger1' LIMIT 1];
        accounts[0].Related_Records__c=False;
        update accounts;
        Test.startTest();
        AccountTriggerTask.createRelatedContact(accounts);
        Test.stopTest();
        System.assertEquals(1, accounts.size(), 'Exactly one Account with the name "Test Tigger1" should be found');
        if (!accounts.isEmpty()) {
            Account account = accounts[0];
            List<Contact> Contacts = account.Contacts;
            System.assertEquals(True, Contacts.isEmpty(), 'Contacts related to the Account are not null');
        }
    }
    @isTest
    static void updateDescriptionTest() {
        List<Opportunity> oppList = new List<Opportunity>();
        for (Integer i = 1; i <= 10; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Trigger New ' + i;
            opp.CloseDate = System.today();
            opp.StageName = 'Prospecting';
            opp.Amount = 3000;  // Adjust the Amount to be within the range
            oppList.add(opp);
        }
        insert oppList;
        Test.startTest();
        //opportunityHandlerClass.updateDescription(oppList);
        Test.stopTest();
        List<Opportunity> updatedOpportunities = [SELECT Id, Name, Description FROM Opportunity WHERE Id IN :oppList];
        for (Opportunity opp : updatedOpportunities) {
            System.debug('Opportunity Name: ' + opp.Name);
            System.debug('Description: ' + opp.Description);
        }
    }
}