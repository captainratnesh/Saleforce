({
    queryBillingHierarchy : function(component, event, helper) {
        var responsibleAccountEid = component.get("v.responsibleAccountWrap.eid");
        var action = component.get("c.getBillingHierarchy"); 
        action.setParams({
            responsibleAccountEid : responsibleAccountEid
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.BillingHierarchyWrap",res);
            }
        });
        $A.enqueueAction(action);
    }
    
})