public class CreatingAcessToken {
    private  string ckey='3MVG9pRzvMkjMb6nai2NezxcfBhTw3_84pVWyIzSIwV7HSPkz2ZEHe_veXgCUZOBOWDDpfUNc7oXwVEFGQmJ4';
    private string csecret='77FD5448743ED5888F25CF125FC5909128BBE7096A528D3F49FA9DCAB063AE5D';
    private string uname='indravathi35@resourceful-badger-i36i1z.com';
    private string password='Amma@1935AF60arHkqz6NXvoDLAjjNvG7';
    public class responsewrapper{
         public string id;
         public string access_token;
         public string instance_url;
    }
    public  string getRequestToken() {
       string reqBody = 'grant_type=password&client_id='+ ckey + '&client_secret=' + csecret + '&username=' + uname + '&password=' + password;
       system.debug('the url: '+reqBody);
       Http h = new Http();
       HttpRequest req = new HttpRequest();
       req.setBody(reqBody);
       req.setMethod('POST');
       req.setEndpoint('https://login.salesforce.com/services/oauth2/token');//auth url
       HttpResponse hresp = h.send(req);
       responseWrapper wResp = (responseWrapper) JSON.deserialize(hresp.getBody(), responseWrapper.class);
       system.debug('response' + wResp);
       system.debug('Instance url' + wResp.instance_url);
       system.debug('session id' + wResp.access_token);
       return wResp.access_token;
        
   }
    

}