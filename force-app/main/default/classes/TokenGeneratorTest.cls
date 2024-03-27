@isTest
public class TokenGeneratorTest {
    @isTest
    static void tokenGeneratorTest(){
        Account testacc=new Account();
        testacc.Name='lekhasree';
        testacc.Health_Status__c='Normal';
        insert testacc;
        
        Contact testcon=new Contact();
        testcon.LastName='sree';
        testcon.AccountId=testacc.Id;
        testcon.Health_Status__c='Below Normal';
        insert testcon;
        
        List<Account> accountList = new List<Account>();
        accountList.add(testacc);
        
        Test.startTest();
        TokenGenerator.token_Generator(accountList);
        Test.stopTest();
        Contact updatedContact = [SELECT Health_Status__c, Last_Health_Status_Update__c, Token__c FROM Contact WHERE Id = :testcon.Id];

        System.assertEquals(testacc.Health_Status__c, updatedContact.Health_Status__c);
        System.assertEquals(Date.today(), updatedContact.Last_Health_Status_Update__c);
        System.assertNotEquals(null, updatedContact.Token__c);
        
    }

}