@isTest
public class TestSetupApex {
    @testSetup
    static void setup(){
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<2;i++){
            Account acc=new Account();
            acc.Name='Test'+i;
            acc.BillingCity='TestCity';
            acc.BillingCountry='TestCountry';
            acc.BillingState='TestState';
            acc.BillingStreet='TestStreet';
            acc.BillingPostalCode='123456';
            if(i==0){
                acc.CopyBillingAddToShipping__c=true;
            }
            accList.add(acc);
        }
        insert accList;
       
    }
    @isTest
    private static void copyBillingToShippingUpdateTest(){
        List<Account> acc=[SELECT Id,Name,CopyBillingAddToShipping__c,BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,ShippingPostalCode,
                           ShippingState,ShippingStreet,ShippingCity,ShippingCountry FROM Account WHERE Name ='Test0'];
        System.debug('Accounts:------    '+acc);
            /*Test.startTest();
            acc.CopyBillingAddToShipping__c=true;
            update acc;
            Test.stopTest();
        
        Account updateAcc=[SELECT Id,ShippingCity FROM Account WHERE Id=:acc.Id];*/
        AccountTrigger.copyBillingToShipping(acc);
        System.assertEquals(acc[0].BillingCity,acc[0].ShippingCity);
    }

}