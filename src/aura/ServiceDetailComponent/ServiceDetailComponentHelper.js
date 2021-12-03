({
    getService : function(component, event, helper) {
        var service = component.get("v.getService");
        var action = component.get("c.getServiceDetail"); 
        action.setParams({
            serviceWrap : JSON.stringify(service)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.currentService",res);
                component.set("v.serviceAddress",res.addressInf);
                component.set("v.usageRules",res.usageRuleInf);
                component.set("v.recurringPrices",res.servicePricesInf);
                component.set("v.oneTimePrices",res.oneTimePricesInf);
                component.set("v.scheduleCharges",res.scheduleChargeInf);
                component.set("v.discountCode",res.discountInf);
            }

        });
        $A.enqueueAction(action);
    }
})