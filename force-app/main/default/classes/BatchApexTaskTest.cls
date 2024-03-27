@isTest
public class BatchApexTaskTest {
    static testMethod void batchtest(){
         Test.startTest();
         ScheduleBatch sbb= new ScheduleBatch();
         String jobName='SchedulingBatch';
         String cron='0 0 0,6,12,18 * * ?';
         System.Schedule(jobName,cron,sbb);
         Test.stopTest();
    }

}