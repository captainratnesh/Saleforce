({
    saveAddChargeRules: function(component, event, helper) {
        var action = component.get("c.createNewActivityChargeRule");
        action.setParams({
            serviceWrapperString: JSON.stringify(component.get("v.prodSerWrappers"))
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    var wrapperObj = component.get("v.prodSerWrappers");
                    wrapperObj.chargeRuleWrapper.serviceUsageRuleName = '';
                    wrapperObj.chargeRuleWrapper.ammountValue = 0;
                    wrapperObj.chargeRuleWrapper.chargeValue = 0;
                    component.set("v.HideSpinner",false);
                    var appEvent = $A.get("e.c:ActivityChargeEvent");
                    appEvent.setParams({
			            "ServiceWrapper": wrapperObj
			        });
			        appEvent.fire();
                    component.destroy();
                } else {
                    document.getElementById("showErrorrAddActivity").style.display = "block";
                    component.set("v.HideSpinner",false);
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrAddActivity").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrAddActivity").style.display = "block";
                }
                component.set("v.HideSpinner",false);
            }
        });
        $A.enqueueAction(action);
    },
    
    getDeserializedWrapper: function(component, event, wrapperString){
        var action = component.get("c.deserializeProductServiceWrapper");
        action.setParams({
            stringToDeserialize		: wrapperString
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var wrapperValue = response.getReturnValue();
                component.set("v.prodSerWrappers",wrapperValue);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrAddActivity").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrAddActivity").style.display = "block";
                }
            }
            component.set("v.HideSpinner",false);
        });
        $A.enqueueAction(action);
    }
})