({
    getDisplayEffectiveDate: function(component, event, helper) {
        var action = component.get("c.showUpdateQuantity");

        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS'){
            	var effectiveDate = response.getReturnValue();
            	component.set("v.displayEffectiveDate", effectiveDate);
            }else if (state === 'ERROR') {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrUpdate").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrUpdate").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    saveUpdateQty: function(component, displayEffectiveDate, newQuantityValue, effectiveDateValue) {
        var action = component.get("c.UpdateQuantityInTract");
        action.setParams({
            serviceEidValue: component.get("v.wrappers").serviceEid,
            newQuantity: newQuantityValue,
            displayEffectiveDate: displayEffectiveDate,
            effectiveDate: effectiveDateValue
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    component.set("v.newQuantity", null);
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                    component.destroy();
                } else {
                    document.getElementById("showErrorrUpdate").style.display = "block";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrUpdate").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrUpdate").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    }
})