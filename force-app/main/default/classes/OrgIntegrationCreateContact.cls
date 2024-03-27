global class OrgIntegrationCreateContact {
    @future(callout=True)
    public static void createContact(Set<Id> conListIds){ 
        List<Contact> conList=[SELECT Id,LastName,Phone,Email FROM Contact WHERE Id IN:conListIds  ];
        List<Contact> con1 = new List<Contact>();
      for(Contact c:conList ){
        Http http = new Http();
        Httprequest request = new Httprequest();
        String jsonPayload = '{"LastName":"' + c.LastName + '","Phone":"' +c.Phone + '"}';
          request.setEndpoint('callout:salesforcenamed/services/apexrest/contacts/');
          request.setMethod('PUT');
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
     
}