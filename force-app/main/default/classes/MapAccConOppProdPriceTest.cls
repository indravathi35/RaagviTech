@isTest
public class MapAccConOppProdPriceTest {
    @isTest
    public static void testMapAccConOppProdPrice() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert con;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',StageName='Prospecting',CloseDate=Date.newInstance(2024, 02, 29) ,Contactopp__c = con.Id);
        insert opp;
        Product2 prod = new Product2(Name = 'Test Product', Opportunity__c = opp.Id);
        insert prod;
        Pricebook2 pb = new Pricebook2(Name = 'Test Pricebook',Product__c=prod.Id);
        insert pb;
        Test.startTest();
        MapAccConOppProdPrice.wrapper result = MapAccConOppProdPrice.MapAccConOppProdPrice();
        Test.stopTest();
        System.assertEquals(1, result.ContactMap.size());
        System.assertEquals(1, result.oppMap.size());
        System.assertEquals(1, result.ProductMap.size());
        System.assertEquals(1, result.PriceMap.size());
    }
}