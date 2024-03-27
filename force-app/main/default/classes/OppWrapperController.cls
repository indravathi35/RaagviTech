public WITH sharing class OppWrapperController {
            @AuraEnabled(cacheable=TRUE)
           public static wrapper fetchOppData(){
               wrapper wrp = new wrapper();
               wrp.accList = [SELECT Id, Name,Phone,Description FROM Account];
               wrp.oppList = [SELECT Id, Name,Amount,Description FROM Opportunity];
               return wrp;
           }
           public class wrapper{
            @AuraEnabled
              public List<Account> accList {get;set;}
              @AuraEnabled
              public List<Opportunity> oppList {get;set;}
           } 
        }  
       