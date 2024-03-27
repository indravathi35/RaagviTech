trigger acctrigger on Account (before insert) {
    List<String> emailList = new List<String>();
    List<Account> existingEmailList = [SELECT email__c from Account WHERE email__c != NULL];
    
    for(Account accObj : existingEmailList){
        emailList.add(accObj.email__c);
    }
 
    for(Account a : Trigger.new){
        if(emailList.contains(a.email__c)){
            a.email__c.addError('This Email is already present in another Account, Duplication is not possible');
        }
    }
}