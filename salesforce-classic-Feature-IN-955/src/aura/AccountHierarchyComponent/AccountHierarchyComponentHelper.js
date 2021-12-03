({
    getChildAccount : function(component, event, helper) {
        var accountEid = component.get("v.tractBillingAccount.eid");
        var action = component.get("c.getChildAccountDetails"); 
        action.setParams({
            accountEid : accountEid
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.childAccounts",res);
            }

        });
        $A.enqueueAction(action);
    }
})