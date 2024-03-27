public with sharing class GetPickListValues {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getPicklistValues() {
        List<Schema.PicklistEntry> entries = Account.Status__c.getDescribe().getPicklistValues();
        List<Map<String, String>> values = new List<Map<String, String>>();
        for (Schema.PicklistEntry entry : entries) {
            Map<String, String> valueMap = new Map<String, String>();
            valueMap.put('label', entry.getLabel());
            valueMap.put('value', entry.getValue());
            values.add(valueMap);
        }
        return values;
    }
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> PriorityPicklistValues() {
        List<Schema.PicklistEntry> entries = Account.priority__c.getDescribe().getPicklistValues();
        List<Map<String, String>> values = new List<Map<String, String>>();
        for (Schema.PicklistEntry entry : entries) {
            Map<String, String> valueMap = new Map<String, String>();
            valueMap.put('label', entry.getLabel());
            valueMap.put('value', entry.getValue());
            values.add(valueMap);
        }
        return values;
    }
}