@isTest
public class AssignmentTest {
    @isTest
    public static void assignmentTest(){
            Account acc=new Account();
            acc.Name='indravathi';
            insert acc;
            Contact con=new Contact();
            con.LastName='induamma';
            con.Email='indu@35gmail.com';
            con.AccountId=acc.Id;
            insert con;
        Test.startTest();
         Assignment a=new Assignment();
         a.Assignment('indravathi35@gmail.com');
        Test.stopTest();
    }
}