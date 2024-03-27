public class AccountTriggerTask {
    public static void bulkInsertion(List<Account> accountList)
    {
        System.debug('accountList'+accountList);
        List<Contact> contactList = new List<Contact>();
        for(Account acc : accountList) {
            // Create the first child Contact related to the Account
            Contact contact1 = new Contact();
            contact1.FirstName = 'Contact 1 First Name';
            contact1.LastName = 'Contact 1 Last Name';
            contact1.AccountId = acc.Id;
            contactList.add(contact1);
            // Create the second child Contact related to the Account
            Contact contact2 = new Contact();
            contact2.FirstName = 'Contact 2 First Name';
            contact2.LastName = 'Contact 2 Last Name';
            contact2.AccountId = acc.Id;
            contactList.add(contact2);
        }
        // Insert the Contact records
        insert contactList;
    }
    public static String generateRandomToken(Integer length) {
        Blob randomBytes = Crypto.generateAesKey(256);
        String base64Token = EncodingUtil.base64Encode(randomBytes);
        return base64Token.substring(0, length);
    }
    public static void healthUpdate(List<Account> newList, Map<Id, Account> accOldMap){
        List<Contact> conList=new List<Contact>();
        for(Account acc: newList){
            if(acc.Health_Status__c != accOldMap.get(acc.Id).Health_Status__c){
                List<Contact> relatedContact = [Select id from contact where accountid =: acc.Id];
                for(Contact con:relatedContact){
                    //String uniqueId = 'C-' + String.valueOf(DateTime.now().getTime()).substring(5);
                    con.Contact_Health_Status__c= acc.Health_Status__c;
                    con.Contact_Health_Status_Date__c=System.today();
                    con.Unique_Token_Value__c = generateRandomToken(20);
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    public static void emailAlert(List<Account> newList){
        List<String> emailSet = new List<String>();
        for (Account acc : [SELECT Email__c FROM Account WHERE Email__c != null]) {
            emailSet.add(acc.Email__c);
        }
        for (Account acc : newList) {
            if (emailSet.contains(acc.Email__c)) {
                acc.addError('duplicate email id Make sure you give right one ');
            }
        }
    }
    public static Id technologyPartner = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Technology User').getRecordTypeId();
    public static Id technologyPartner1 = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Non Technology User').getRecordTypeId();
    public static void conTask(List<Account> accList){
        List<Contact> conList1 = new List<Contact>();
        for (Account acc : accList) {
            Contact con = new Contact();
            if (acc.Type == 'Technology Partner') {
                con.RecordTypeId = technologyPartner;
            } else {
                con.RecordTypeId = technologyPartner1;
            }
            con.LastName = acc.Name;
            con.Phone = acc.Phone;
            con.Email = acc.Email__c;
            con.AccountId = acc.Id;
            con.Description = 'Account ID : ' + acc.Id + '   Account Name : ' + acc.Name;
            conList1.add(con);
        }
        System.debug('account created' + conList1);
        if (!conList1.isEmpty()) {
            insert conList1;
        }
    }
    public static void preventDeletion(List<Account> accList3){
        Profile p = [select id from profile where name ='system administrator'];
        for(Account acc:accList3){
            if(UserInfo.getProfileId() != p.id||acc.Active__c == 'Yes'){
               // acc.addError(label.Account_Delete_Label);
               acc.addError('Account should not be delelted');
            }
        }
    }
    public static void updateRelatedContact(List<Account> accList, Map<Id, Account> accOldMap){
        List<Contact> conList=new List<Contact>();
        Map<Id, Account> accMap=new Map<Id, Account>();
        for(Account acc:accList){
            //map will store only those accounts whose phone is updated
            if(acc.Phone != accOldMap.get(acc.id).phone){
                accMap.put(acc.Id, acc);
            }
        }
        for(contact con: [select id, HomePhone, AccountId From contact where accountid in:accMap.keySet()]){
            if(accMap.containsKey(con.AccountId)){
                con.HomePhone=accMap.get(con.accountid).phone;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    /*  public static void populateRating(List<Account>accList1, Map<Id, Account> accOldMAP){
for(Account acc:accList1){
if((accOldMAP ==null && acc.Industry !=null && acc.Industry== 'Media')
||(acc.Industry != accOldMAP.get(acc.Id).Industry && acc.Industry == 'Media')){
acc.Rating='Hot';
}
}
}*/
    public static void updatePhone(List<Account> accList3, Map<Id, Account> accOldMap){
        for(Account acc:accList3){
            if(acc.phone != accOldMap.get(acc.Id).phone){
                acc.Description='Phone is Updated | old value = ' + accOldMap.get(acc.Id).phone+'  New value = '+acc.Phone;
            }
        }
    }
    public static void createOpp(List<Account>accList2){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accList2){
            if(acc.Related_Records__c){
                 Opportunity opp = new Opportunity();
                opp.Name=acc.Name;
                opp.CloseDate=System.today();
                opp.StageName='Prospecting';
                opp.Amount=400000;
                opp.AccountId=acc.Id;
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
    public static void createRelatedContact(List<Account>accList){
        System.debug('con1');
        List<Contact> conList = new List<Contact>();
        for(Account acc:accList){
            if(acc.Related_Records__c){
                Contact con = new Contact();
            con.FirstName=acc.Name;
            con.LastName=acc.Name;
            con.AccountId=acc.Id;
            conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
    public static void updateDesc(List<Account>accList){
        for(Account acc:accList){
            acc.Description='Account is created';
        }
    }
    public static void populateRating(List<Account>accList1){
        for(Account acc:accList1){
            if(acc.Industry=='Media' || acc.Industry=='Energy'){
                acc.Rating='Hot';
            }
            else{
                acc.rating = 'Warm';
            }
        }
    }


}