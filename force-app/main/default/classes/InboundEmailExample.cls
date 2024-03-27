global class InboundEmailExample implements Messaging.InboundEmailHandler {
     global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope env){
         Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        try{
            case cs=new case();
            cs.Subject=email.subject;
            cs.Description=email.plainTextBody;
            cs.Origin='Email';
            cs.Priority='High';
            insert cs;
            Result.success=true;
        }
        catch(Exception e){
            Result.success=false;
            Result.message='Failed'+e.getMessage();
        }
         return result;
        }
}