public class CallOutSalesforceOrg {
    
    public static void getCases(){
        Http http = new Http();
        Httprequest request = new Httprequest();
        String jsonPayload = '{"name":"' + 'indrvathi' + '","phone":"' +'2544667445'  + '"}';
        request.setEndpoint('callout:salesforcenamed/services/apexrest/accounts/');
        request.setMethod('GET');
        //request.setMethod('PUT');
        //request.setHeader('Content-Type', 'application/json');
        //request.setBody(jsonPayload);
        Httpresponse response = http.send(request);
        System.debug('response'+response.getBody());
        System.debug('response Status Code'+response.getStatusCode());
   
   }
}