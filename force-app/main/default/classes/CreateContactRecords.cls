public with sharing class CreateContactRecords {

@AuraEnabled
public static Contact CreateContactRecords(Map<String ,Object> obj){
    System.debug('obj'+obj);
    String firstname = (String)obj.get('FirstName');
    System.debug('first name'+firstname);
    String email = (String)obj.get('Email');
    System.debug(email);
    String lastname = (String)obj.get('LastName');
    System.debug(lastname);
    String phone = (String)obj.get('Phone');
    System.debug(phone);
    
    try {
        Contact c=new Contact();
        c.FirstName=firstname;
        c.LastName=lastname;
        c.Email=email;
        c.Phone=phone;
       
        insert c;
        return c;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}
}