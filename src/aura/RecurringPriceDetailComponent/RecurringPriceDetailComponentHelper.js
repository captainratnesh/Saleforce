({
	queryProductChargeRule : function(component, event, helper) {
         var action = component.get("c.queryProductUsageChargeRule");
         console.log('component.get("v.selectedPrice").eid:::'+component.get("v.selectedPrice").eid);
        action.setParams({
            productId: component.get("v.selectedPrice").productEid,
            recurringPriceId : component.get("v.selectedPrice").eid    
        });
        action.setCallback(this, function(response) {      
            var state = response.getState();
            if (state == 'SUCCESS') {
                var chargeRuleList = response.getReturnValue();
                component.set("v.activityChargeWrapper", chargeRuleList);
            }
        });
        $A.enqueueAction(action);
		
	}
})