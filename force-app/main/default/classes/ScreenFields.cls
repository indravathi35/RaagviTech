public with sharing class ScreenFields {
    @InvocableMethod(label = 'ScreenIntegration')
    public static List<OutputResult> ScreenFields(List<getVariabless> getVariables) {
        List<OutputResult> result = new List<OutputResult>();
        for (getVariabless input : getVariables) {
            System.debug('AccountName: ' + input.name);
            System.debug('Phone: ' + input.phone);
            List<String> fields = new List<String>();
                fields.add(input.name);
                fields.add(input.phone);
           boolean res=putFields(fields[0],fields[1]);
           if(res==true){
            OutputResult successResult = new OutputResult();
                successResult.resultMessage = 'Account created successfully.';
                result.add(successResult);
           }
           else{
            OutputResult errorResult = new OutputResult();
            errorResult.resultMessage = 'Error while creating';
            result.add(errorResult);
         }
    }
    return result;
}
     public class getVariabless {
        @InvocableVariable
        public String name;
        @InvocableVariable
        public String phone;

    }
    public class OutputResult {
        @InvocableVariable
        public String resultMessage;
    }
    
    public static boolean putFields(String names,String phones){
        //String jsonPayload = '{"name":"' + name + '","phone":"' +phone  + '"}';
        Http http = new Http();
        Httprequest request = new Httprequest();
        request.setEndpoint('callout:salesforcenamed/services/apexrest/accounts/?name='+names+'&phone='+phones);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        //request.setBody(jsonPayload);
        Httpresponse response = http.send(request);
        System.debug('response'+response.getBody());
        String responseBody = response.getBody();
        System.debug('response Status Code'+response.getStatusCode());
        if(response.getStatusCode()==200){
            Account acc=new Account();
            acc.Name=names;
            acc.Phone=phones;
            insert acc;
            return true;
            
        }
        else{
            return false;
            
        }
}
}