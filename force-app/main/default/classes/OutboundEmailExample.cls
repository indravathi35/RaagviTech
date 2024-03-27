public class OutboundEmailExample {
    public static void sendEmailToUser(){
        Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
        List<String> toAddresses=new LIst<String>{'indravathi35@gmail.com'};
            email.setToAddresses(toAddresses);
            email.setSubject('test email from apex');
            email.setPlainTextBody('this is a test body');
        Messaging.Email[] emails=new Messaging.Email[]{email};
            Messaging.sendEmail(emails);
    }

}