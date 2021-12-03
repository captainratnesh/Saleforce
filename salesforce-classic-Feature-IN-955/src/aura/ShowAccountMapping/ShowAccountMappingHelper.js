({
    showAccValue : function(component, event, helper) {
        var action = component.get("c.showAccountMap"); 
        action.setParams({
            accountId : component.get("v.AccountID")
        }); 
		action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var existingWrap = response.getReturnValue();
                component.set("v.MapOfFieldVsValue",existingWrap.mapOfNamesVsVales);
                component.set("v.accountWrap",existingWrap);
                console.log('MapOfFieldVsValue:::::'+JSON.stringify(existingWrap.mapOfNamesVsVales));
            }
        });
        $A.enqueueAction(action);
    }
})