public with sharing class StaticDataController {
    @AuraEnabled(cacheable=true)
    public static String resourceMethod(){
        try {
    
        StaticResource resource = [SELECT Body FROM StaticResource WHERE Name = 'taskaura'];
        String data=resource.Body.toString();
        System.debug(resource);
        //Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(jsonData);
        //System.debug(data);
        return data;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}