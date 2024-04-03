global class OrgIntegrationCreateContact {
    @future(callout=True)
    global static void createContact(Set<Id> conListIds){ 
        CreatingAcessToken access=new CreatingAcessToken();
        string accsstoken=access.getRequestToken();
        List<Contact> conList=[SELECT Id,LastName,Phone,Email FROM Contact WHERE Id IN:conListIds  ];
        List<Contact> con1 = new List<Contact>();
        
      for(Contact c:conList ){
        Http http = new Http();
        Httprequest request = new Httprequest();
        String jsonPayload = '{"LastName":"' + c.LastName + '","Phone":"' +c.Phone + '"}';
         request.setHeader('Authorization','Bearer ' + accsstoken);
         request.setEndpoint('https://resourceful-badger-i36i1z-dev-ed.trailblaze.my.salesforce.com/services/apexrest/createContact/;');
          request.setMethod('POST');
          request.setHeader('Content-Type', 'application/json');
          request.setHeader('accept','application/json');
          request.setBody(jsonPayload);
          Httpresponse response = http.send(request);
          system.debug('resss--'+response);
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