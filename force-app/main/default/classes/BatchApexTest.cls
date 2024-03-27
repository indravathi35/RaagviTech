@istest 
public class BatchApexTest {
    @isTest static void testbarchClass(){

        List<Contact> accList = new List<Contact>();
        Set<Id> idlist=new Set<Id>();

        for(integer i = 0 ; i < 5 ;i++ ){

            accList.add(new Contact(LastName = 'Test Contact ' + i ));

        }

        if(!accList.isEmpty())
            
            insert accList;
        for(Contact a:accList){
        idlist.add(a.Id);
        }
        Test.setMock(HttpCalloutMock.class, new BatchTestMock());

        TriggerIntegrationBatch bs = new TriggerIntegrationBatch(idlist);

        Test.startTest();

        	database.executeBatch(bs,200);

        Test.stopTest();

    }

}