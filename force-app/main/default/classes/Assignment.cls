public with sharing class Assignment {
    public static void Assignment(String email) {
        List<Account> accList=[SELECT Id,Name FROM Account ];
        for( Account acc:accList){
            List<Contact> conList=[ SELECT Id,Name,Email FROM Contact WHERE AccountId=:acc.Id];
            System.debug('conList'+conList);
            for(Contact c:conList){
                c.Email=email;
                System.debug('updated contact'+c);
            }
    }
        update accList;
}
}