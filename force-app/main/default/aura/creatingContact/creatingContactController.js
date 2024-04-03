({
    HandleCreate : function(component, event, helper) {
        console.log('Create button');
        var nameInput = component.get('v.Name');
        console.log('val===',nameInput);
        var phoneInput = component.get('v.Phone');
        var emailInput = component.get('v.Email');
        var newContact = {
            sobjectType: "Contact",
            LastName: nameInput,
            Phone: phoneInput,
            Email: emailInput
        };

        var action = component.get("c.createContact");
        action.setParams({
            "newContact": newContact
        });
        $A.enqueueAction(action);
    

    }
    
})