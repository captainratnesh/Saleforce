({
    saveDeactivateServices: function(component, event, helper) {
        var reasonEidValue = component.find("ReasonEid").get("v.value");
        var deactivationDateValue = component.get("v.deactivationDate");

        var action = component.get("c.saveDeactivateService");
        action.setParams({
            serviceEid: component.get("v.wrappers").serviceEid,
            reasonEid: reasonEidValue,
            deactivationDate: deactivationDateValue
        });

        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    component.destroy();
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                } else {
                    document.getElementById("showErrorDeactivate").style.display = "block";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorAddAgreement").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorAddAgreement").style.display = "block";
                }
                document.getElementById("showErrorDeactivate").style.display = "block";
            }

        });
        $A.enqueueAction(action);
    }
})