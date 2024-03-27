public with sharing class ButtonMetaHandler {
    @AuraEnabled(cacheable=true)  
    public static List < ClickButton__mdt > fetchMetaListLwc() {
         
        List <ClickButton__mdt> fetchMeta = [ SELECT Id,MasterLabel, color__c, Subject__c ,poplabel__c FROM ClickButton__mdt ];
        return fetchMeta;
         
   }
   @AuraEnabled(cacheable=false)
   public static Id createTask(Map<String ,Object> obj ){
    String subj = (String)obj.get('Subject');
    Task t = new Task();
    t.Subject=subj;
    
    insert t;
    return t.Id;
   }
  @AuraEnabled(cacheable=false)
    public static Id createDraft(Map<String,Object> obj){
      String subj=(String)obj.get('Subject');
      draft__c dt=new draft__c();
      dt.Name=subj;
      System.debug('obj'+dt);
      insert dt;
      return dt.Id;
    
  }      
}