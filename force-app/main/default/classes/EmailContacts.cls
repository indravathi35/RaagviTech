public with sharing class EmailContacts {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String recId){
            List<Contact> conList=[SELECT LastName,Email FROM Contact WHERE AccountId=:recId];
            return conList;
           
    }
@AuraEnabled(cacheable=true)
public static Map<Id, String> getFolders() {
            Map<Id, String> folderMap = new Map<Id, String>();
            Id orgId = UserInfo.getOrganizationId();
            Id usId = UserInfo.getUserId();
            String fol1='Unfield Public Classic Email Templates';
            String fol2='My Personal Email Templates';

            folderMap.put(orgId, fol1);
            folderMap.put(usId, fol2);
            for(Folder emailFolder : [SELECT Id, Name, DeveloperName, Type FROM Folder WHERE Type = 'Email']) {
                folderMap.put(emailFolder.Id, emailFolder.Name);
            }
            
            return folderMap;
        }
    @AuraEnabled(cacheable=true)
    public static List<EmailTemplate> emailTemplates(String folderId){
        String orgId = UserInfo.getOrganizationId();
        String usId = UserInfo.getUserId();
        System.debug('orgid----'+orgId);
        System.debug('usId---'+usId);
        List<EmailTemplate> allEmailTemplates;
        if(folderId.equals(orgId)){
            allEmailTemplates = [select Subject,Body FROM EmailTemplate WHERE FolderId =: orgId];
           System.debug('temp---'+allEmailTemplates);
           
       }
       else if(folderId.equals(usId)){
        allEmailTemplates = [select Subject,Body FROM EmailTemplate WHERE FolderId =: usId];
        System.debug('temp---'+allEmailTemplates);
        }
      else{
            allEmailTemplates = [Select Subject,Body From EmailTemplate Where Folder.Id =:folderId]; 
        }
     return allEmailTemplates;
    }
    @AuraEnabled(cacheable=true)
    public static void sendEmailController(String toAddress,String subject,String body) {
            messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
            mail.setToAddresses(new List<String>{ toAddress });
            mail.setSubject(subject);
            mail.setHtmlBody(body);
            Messaging.sendEmail(new List<messaging.SingleEmailMessage>{ mail });
        }
}