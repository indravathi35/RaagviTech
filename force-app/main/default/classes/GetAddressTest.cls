@IsTest
public class GetAddressTest {
    @IsTest
    static void testMethodName() {
        
        Account testAccount = new Account(
            Name = 'indravathi',
            BillingCity = 'vizianagaram'
        );
        insert testAccount;
        List<Account> result = GetAddress.methodName(testAccount.Id);
        System.assertEquals(1, result.size());
        System.assertNotEquals(2, result.size());
        System.assertEquals('vizianagaram', result[0].BillingCity);
        System.assertNotEquals('vizag',result[0].BillingCity);
    }

    @isTest
    static void testGetCases() {
        Account testAccount = new Account(Name = 'suresh');
        insert testAccount;
        Case testCase = new Case(
            Subject = 'abcdef',
            AccountId = testAccount.Id
        );
        insert testCase;
        List<Case> result = GetAddress.getCases(testAccount.Id);
        System.assertEquals(1, result.size());
        System.assertNotEquals(3,result.size());
        System.assertEquals('abcdef', result[0].Subject);
        System.assertNotEquals('sgsgh',result[0].Subject);
        
    }

    @isTest
    static void testGetContacts() {
        Account testAccount = new Account(Name = 'krishna');
        insert testAccount;
        Contact testContact = new Contact(
            FirstName = 'rohini',
            LastName = 'sathyadurga',
            Email = 'indu@gmail.com',
            Phone = '1234565432',
            AccountId = testAccount.Id
        );
        insert testContact;
        List<Contact> result = GetAddress.getContacts(testAccount.Id);
        System.assertEquals(1, result.size());
        System.assertNotEquals(7, result.size());
        System.assertEquals('rohini', result[0].FirstName);
        System.assertNotEquals('rohitha', result[0].FirstName);
        System.assertEquals('sathyadurga', result[0].LastName);
        System.assertNotEquals('asathyadurga', result[0].LastName);
        System.assertEquals('indu@gmail.com', result[0].Email);
        System.assertNotEquals('rohini@gmail.com', result[0].Email);
        System.assertEquals('1234565432', result[0].Phone);
        System.assertNotEquals('1234567899', result[0].Phone);
    }

    @isTest
    static void testInsertContact() {
        List<Contact> result = GetAddress.insertContact('indra', 'vathi', 'indravathi35@gmail.com', '6303411827');
        System.assertEquals(1, result.size());
        System.assertNotEquals(9, result.size());
        System.assertEquals('indra', result[0].FirstName);
        System.assertNotEquals('shivvu', result[0].FirstName);
        System.assertEquals('vathi', result[0].LastName);
        System.assertNotEquals('ramya', result[0].LastName);
        System.assertEquals('indravathi35@gmail.com', result[0].Email);
        System.assertNotEquals('kalyan35@gmail.com', result[0].Email);
        System.assertEquals('6303411827', result[0].Phone);
        System.assertNotEquals('9703523531', result[0].Phone);
    }

}