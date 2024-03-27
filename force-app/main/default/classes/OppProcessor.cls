public class OppProcessor implements Database.Batchable<sObject> {
    public integer recordCount=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Name FROM Opportunity]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> opps){
        for(Opportunity op:opps){
            op.LeadSource='Web';
        }
        update opps;
        recordCount=recordCount+opps.size();
        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total records processed'+recordCount);
    }

}