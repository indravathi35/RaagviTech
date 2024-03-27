global class InboundApex implements Messaging.InboundEmailHandler {
     global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope env){
         Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
         List<String> lines=email.plainTextBody.split('\n');
         String des=lines[0].substring(0,lines[0].length()-10);
         String maildate=lines[0].substring(lines[0].length()-10,lines[0].length());
         String md=maildate.replace('/','-');
         
        try{
            case cs=new case();
            cs.Subject=email.subject;
            cs.SuppliedName=lines[1];
            cs.Description=des;
            cs.emaildate__c=Date.valueOf(md);
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