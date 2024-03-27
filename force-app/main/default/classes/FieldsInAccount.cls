public with sharing class FieldsInAccount {
    @AuraEnabled
    public static List<String> FieldsInAccount() {
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
       List<String> editableFields = new List<String>();
       for(Schema.SObjectField fieldRef : fields.values()) {
           Schema.DescribeFieldResult fieldResult = fieldRef.getDescribe();
            if(fieldResult.isUpdateable()) {
           editableFields.add(fieldResult.getname());
        }
        System.debug('edita---'+editableFields);
    }
    return editableFields;
}
@AuraEnabled
    public static List<Account> getAccountRecords(List<String> fieldNames) {
        String fieldsString = String.join(fieldNames, ',');
        String query = 'SELECT ' + fieldsString + ' FROM Account';
        return Database.query(query);
    }
@AuraEnabled
  public static void updateRecords(String recordsJson) {
    try {
      List<Account> accs = (List<Account>) JSON.deserialize(
        recordsJson,
        List<Account>.class
      );

      update accs;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}