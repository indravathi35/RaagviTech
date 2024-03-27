global with sharing class AccountRecordsFlow {
    @InvocableMethod(label = 'Create Account')
    public static List<OutputResult> AccountRecordsFlow(List<getVariabless> getVariables) {
        List<OutputResult> result = new List<OutputResult>();
        try {
            System.debug('variables---');
            for (getVariabless input : getVariables) {
                System.debug('AccountName: ' + input.AccountName);
                System.debug('Phone: ' + input.phoneno);
                System.debug('Email: ' + input.emailad);

                List<String> fields = new List<String>();
                fields.add(input.AccountName);
                fields.add(input.phoneno);
                fields.add(input.emailad);

                Account acc = new Account();
                acc.Name = fields[0];
                acc.Phone = fields[1];
                acc.email__c = fields[2];
                insert acc;

                OutputResult successResult = new OutputResult();
                successResult.resultMessage = 'Account created successfully.';
                result.add(successResult);
            }
        } catch (Exception e) {
            OutputResult errorResult = new OutputResult();
            errorResult.resultMessage = 'Error creating account: ' + e.getMessage();
            result.add(errorResult);
        }
        System.debug('msg---' + result);
        return result;
    }

    global class getVariabless {
        @InvocableVariable
        public String AccountName;
        @InvocableVariable
        public String phoneno;
        @InvocableVariable
        public String emailad;
    }

    global class OutputResult {
        @InvocableVariable
        public String resultMessage;
    }
}