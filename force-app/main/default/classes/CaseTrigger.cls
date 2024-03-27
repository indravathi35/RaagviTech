public with sharing class CaseTrigger {


    public static Id CASE_RECORDTYPEID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Paid').getRecordTypeId();


    public static void CaseTriggerMethod(List<Case> caseList) {
        System.debug('case_recordtypeid'+CASE_RECORDTYPEID);
        for(Case caseobj:caseList)
        {   
            System.debug('caseobj'+caseobj);
            if(caseobj.RecordTypeId==CASE_RECORDTYPEID && (caseobj.ContactReason__c.equals('Mobile and Electronics') || caseobj.ContactReason__c.equals('Voice Services')))
            {
                Task task = new Task();
                task.subject= 'casetask';
                task.WhatId=caseobj.Id;
                insert task;

            } 
            else{
                caseobj.ContactReason__c.addError('You do not have the permission to add this Contact Reason');

            }
           
        }
        
    }
    
}