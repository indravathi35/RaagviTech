public class TokenGenerator {
    public static void token_Generator(List<Account> s){
        List<Contact> contactsToUpdate = new List<Contact>();
    for(Account acc:s){
            List<Contact> relatedContacts = [SELECT Id, Health_Status__c FROM Contact WHERE AccountId = :acc.Id];
            for (Contact contact : relatedContacts)
            {
                contact.Health_Status__c = acc.Health_Status__c;
                contact.Last_Health_Status_Update__c = Date.today();
                String chars='ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
                String uniquetoken='';
                While(uniquetoken.length()<10){
                Integer n = (Integer)Math.floor(Math.random() * chars.length());
                uniquetoken += chars.substring(n,n+1);
        }
                contact.Token__c=uniquetoken; 
                contactsToUpdate.add(contact);
            }
        }
      if(!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }
    }

}