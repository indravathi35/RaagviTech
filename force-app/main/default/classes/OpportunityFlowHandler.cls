global with sharing class OpportunityFlowHandler {
    @InvocableMethod(label = 'OpportunityFlow')
    global static List<OutputResult> OpportunitRecordsFlow(List<getVariabless> getVariables) {
        List<OutputResult> result = new List<OutputResult>();
        List<Opportunity> oppList=new List<Opportunity>();
        
            for (getVariabless input : getVariables) {
                Opportunity op=new Opportunity();
                op.Name = input.OpportunityName;
                op.Description = input.Description;
                op.StageName=input.StageName;
                op.CloseDate=input.CloseDate;
                oppList.add(op);

                }
            try{
            insert oppList;
            OutputResult successResult = new OutputResult();
                successResult.resultMessage = 'Opportunity created successfully.';
                result.add(successResult);
             }
        catch(Exception e){
            OutputResult errorResult = new OutputResult();
            errorResult.resultMessage = 'Error creating opportunity: ' + e.getMessage();
            result.add(errorResult);

        }
        return result;
    }

    global class getVariabless {
        @InvocableVariable
        public String OpportunityName;
        @InvocableVariable
        public String Description;
        @InvocableVariable
        public Date CloseDate;
        @InvocableVariable
        public String StageName ;
    }
    global class OutputResult {
        @InvocableVariable
        public String resultMessage;
    }

}