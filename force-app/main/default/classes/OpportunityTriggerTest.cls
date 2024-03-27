@isTest
public class OpportunityTriggerTest {
    @isTest
    static void OpportunityTriggerTest(){
        Opportunity opp= new Opportunity();
        opp.delivery_installation_status__c='started';
        opp.Name='indraa';
        opp.StageName='Prospecting';
        opp.CloseDate=System.today();
        insert opp;
      
       List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(opp);
        
        Test.startTest();
        OpportunityTrigger.OpportunityTriggerMethod(oppList);
        Test.stopTest();

        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Opportunity__c = :opp.Id];
        System.assertEquals(1, accounts.size());
        Account createdAccount = accounts[0];
        System.assertEquals('indraa', createdAccount.Name);
        
        List<Contact> contacts = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId = :createdAccount.Id];
        System.assertEquals(1, contacts.size());
        Contact createdContact = contacts[0];
        System.assertEquals('indraa', createdContact.LastName);
        System.assertEquals(createdAccount.Id, createdContact.AccountId);
    }
    @isTest
    public static void testOpportunityUpdateProgress() {
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(
            AccountId = testAccount.Id,
            LastName='vathi');
        insert testContact;

        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Open',
            CloseDate = Date.today(),
            delivery_installation_status__c = 'in progress',
            AccountId = testAccount.Id
        );
        insert testOpportunity;

        
        OpportunityTrigger.OpportunityUpdate(new List<Opportunity>{testOpportunity});

        Opportunity updatedOpportunity = [SELECT StageName FROM Opportunity WHERE Id = :testOpportunity.Id];
        List<OpportunityContactRole> oppConRoles = [SELECT Id FROM OpportunityContactRole WHERE OpportunityId = :testOpportunity.Id];

        System.assertEquals('Open', updatedOpportunity.StageName);

        System.assertEquals(1, oppConRoles.size());
    }

    @isTest
    public static void testOpportunityUpdateCompleted() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Open',
            CloseDate = Date.today(),
            delivery_installation_status__c = 'completed',
            AccountId = testAccount.Id
        );
        insert testOpportunity;

        OpportunityTrigger.OpportunityUpdate(new List<Opportunity>{testOpportunity});
        
        Opportunity updatedOpportunity = [SELECT StageName FROM Opportunity WHERE Id = :testOpportunity.Id];
        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :testAccount.Id];
        List<OpportunityContactRole> oppConRoles = [SELECT Id FROM OpportunityContactRole WHERE OpportunityId = :testOpportunity.Id];
        System.assertEquals('Open', updatedOpportunity.StageName);
        System.assertEquals(1, accounts.size());
        System.assertEquals(0, oppConRoles.size());
    }
}