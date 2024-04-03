({
    handleAccountSearch : function(component, event, helper) {

        console.log('name---',component.get('v.Name'));
        component.set("v.columns", [
            {label: 'Id', fieldName: 'Id', type: 'text'},
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
        ]);
        var action=component.get('c.AccountSearchController');
        action.setParams({
            "namevalue": component.get('v.Name')
        });
        action.setCallback(this,function(response){       
            var state=response.getState();
            if(state==="SUCCESS")
            {
                console.log('response',JSON.stringify(response.getReturnValue()));
                component.set("v.data",response.getReturnValue());
            }
         
        });
        $A.enqueueAction(action);
    },
    contactSearch :function(component, event, helper) {
        component.set("v.concolumns", [
            {label: 'Id', fieldName: 'Id', type: 'text'},
            {label: 'Name', fieldName: 'LastName', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
        ]);
        var action=component.get('c.getAccountList');
        action.setParams({
            "namevalue": component.get('v.Name')
        });
        action.setCallback(this,function(response){       
            var state=response.getState();
            if(state==="SUCCESS")
            {
                console.log('response',JSON.stringify(response.getReturnValue()));
                component.set("v.condata",response.getReturnValue());
            }
         
        });
        $A.enqueueAction(action);

    }
})