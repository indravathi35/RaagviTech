@isTest
public class EmailContactsTest {
    @isTest
    static void testGetContacts() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        Contact testContact1 = new Contact(LastName='TestContact1', Email='test1@example.com', AccountId=testAccount.Id);
        Contact testContact2 = new Contact(LastName='TestContact2', Email='test2@example.com', AccountId=testAccount.Id);
        insert new List<Contact>{testContact1, testContact2};

        Test.startTest();
        List<Contact> result = EmailContacts.getContacts(testAccount.Id);
        System.assertEquals(2, result.size());

        Test.stopTest();
    }
    @isTest
    static void testGetFolders() {
        Map<Id, String> expectedFolders = new Map<Id, String>{
            UserInfo.getOrganizationId() => 'Unfield Public Classic Email Templates',
            UserInfo.getUserId() => 'My Personal Email Templates'
        };
        Map<Id, String> result = EmailContacts.getFolders();
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(3, result.size(), 'Expected number of folders in the map');
        for (Id folderId : expectedFolders.keySet()) {
            System.assertEquals(expectedFolders.get(folderId), result.get(folderId), 'Folder name should match');
        }
    }

    @isTest
    static void testEmailTemplates() {
        EmailTemplate testTemplate = new EmailTemplate(
            Subject = 'Test Subject', Body = 'Test Body'
        );
        List<EmailTemplate> result = EmailContacts.emailTemplates('00D5j00000CulxhEAB');
        List<EmailTemplate> result1 = EmailContacts.emailTemplates('0055j000009SPfRAAW');
        List<EmailTemplate> result2 = EmailContacts.emailTemplates('00l5j000000KJnWAAW');
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(30, result.size(), 'Expected one email template in the list');
    }


    @isTest
    static void testSendEmailController() {
        Test.startTest();
        EmailContacts.sendEmailController('test@example.com', 'Test Subject', 'Test Body');
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        System.assertEquals(1, invocations, 'An email has not been sent');
    }
}