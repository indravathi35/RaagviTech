public with sharing class InlineEditing {
    @AuraEnabled
   public static void updateAccounts(Map<String, Object> accData) {
      System.debug('contactData============' + accData);
              Account accToUpdate = new Account(
                  Id = (String) accData.get('Id'),
                  Name = (String) accData.get('Name'),
                  Phone =(String) accData.get('Phone')
              );
              update accToUpdate;
              System.debug('conToUpdate---------' + accToUpdate);
  }
  @AuraEnabled
  public static String updateContacts(Map<String, Object> conData) {
    System.debug('contactData============' + conData);
            Contact conToUpdate = new Contact(
                Id = (String) conData.get('Id'),
                LastName = (String) conData.get('Name'),
                Phone =(String) conData.get('Phone')
            );
            update conToUpdate;
            System.debug('conToUpdate---------' + conToUpdate);
            return conToUpdate.Id;
}
@AuraEnabled
  public static void updateOpportunities(Map<String, Object> oppData){
    Opportunity conToUpdate = new Opportunity(
                Id = (String) oppData.get('Id'),
                Name = (String) oppData.get('Name'),
                phone__c =(String) oppData.get('Phone')
            );
            update conToUpdate;
            System.debug('conToUpdate---------' + conToUpdate);
            
  }
  @AuraEnabled
 public static String updateProducts(Map<String, Object> prodData){
  Product2 conToUpdate = new Product2(
                Id = (String) prodData.get('Id'),
                Name = (String) prodData.get('Name'),
                phone__c =(String) prodData.get('Phone')
            );
            update conToUpdate;
            return conToUpdate.Id;

 }
 @AuraEnabled
 public static String updatePriceBooks(Map<String, Object> priceData){
  Pricebook2 conToUpdate = new Pricebook2(
                Id = (String) priceData.get('Id'),
                Name = (String) priceData.get('Name'),
                phone__c =(String) priceData.get('Phone')
            );
            update conToUpdate;
            return conToUpdate.Id;

 }


}