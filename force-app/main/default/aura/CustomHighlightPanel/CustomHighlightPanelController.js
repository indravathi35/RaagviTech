({
    doInit : function(component, event, helper) {
        var recordId = component.get('v.recordId');
        console.log('recid--',component.get('v.recordId'));
        
        var action = component.get("c.getAccount");
        action.setParams({
            "recordId": recordId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var account = response.getReturnValue();
                var accountId = account.Id;
                var accountPhone = account.Phone;
                var accountName = account.Name;
                var accountIndustry = account.Industry;
                var accountWebsite = account.Website;
                var accountType = account.Type;
                var accountowner=account.Owner.Name;
                console.log('ownerrr',accountowner);
                component.set("v.accountId", accountId);
                component.set("v.accountowner", accountowner);
                component.set("v.accountPhone", accountPhone);
                component.set("v.accountName", accountName);
                component.set("v.accountIndustry", accountIndustry);
                component.set("v.accountWebsite", accountWebsite);
                component.set("v.accountType", accountType);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    console.error('Error: ', errors);
                }
            }
        });
        $A.enqueueAction(action);
    },
    handleClick:function(component, event, helper){
        console.log('in follow---');
        var buttonstate = component.get('v.buttonstate');
        component.set('v.buttonstate', !buttonstate);
    }
    
})