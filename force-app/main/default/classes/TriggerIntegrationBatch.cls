global class TriggerIntegrationBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    Set<Id> BatchConIds=new Set<Id>();
    global TriggerIntegrationBatch(Set<Id> conIds){
        BatchConIds=conIds;
        system.debug('size --- '+conIds.size());
    }
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT id,LastName,Phone,Inserted__c from contact where id in:BatchConIds]);
    }
    global void execute(Database.BatchableContext BC, List<Contact> scope) {  
         CreatingAcessToken access=new CreatingAcessToken();
        string accsstoken=access.getRequestToken();
        List<Contact> con1 = new List<Contact>();
        for(Contact c : scope)
        {  
            Http http = new Http();
        Httprequest request = new Httprequest();
        String jsonPayload = '{"LastName":"' + c.LastName + '","Phone":"' +c.Phone + '"}';
            request.setHeader('accept','application/json');
            request.setHeader('Authorization','Bearer ' + accsstoken);
            request.setEndpoint('https://resourceful-badger-i36i1z-dev-ed.trailblaze.my.salesforce.com/services/apexrest/createContact/;');
          request.setMethod('POST');
          request.setHeader('Content-Type', 'application/json');
          request.setBody(jsonPayload);
          Httpresponse response = http.send(request);
          System.debug('status---'+response.getStatusCode());
          if(response.getStatusCode()==200){
              System.debug('if---');
              contact con2 = new contact();
             con2.Id = c.id;
              con2.Inserted__c = true;
              con1.add(con2);
            
          }
          }
        CheckTrigger.firstTime=false;
        update con1;
    }
    global void finish(Database.BatchableContext BC)
    {
    }

}