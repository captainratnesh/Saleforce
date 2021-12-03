({
    validateServiceResource: function(component, event, serviceResourceIdentifier) {
        var action = component.get("c.getServiceResource");
        action.setParams({
            serviceResourceIdentifier: serviceResourceIdentifier
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var responseString = response.getReturnValue();
                if (responseString.indexOf("Error - ") == -1 && responseString.indexOf("invalid service resource") == -1) {
                    this.addServiceResourceToService(component, event, false, responseString)
                } else {
                    component.set("v.message", responseString);
                    document.getElementById("showErrorResource").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorResource").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorResource").style.display = "block";
                }
                document.getElementById("Accspinner").style.display = "none";
            }
        });
        $A.enqueueAction(action);
    },

    addServiceResourceToService: function(component, event, isNewServiceResource, serviceResource) {
        var effectiveDate = component.get("v.effectiveDate");
        var action = component.get("c.applyServiceResourceToService");
        action.setParams({
            srId: serviceResource,
            isNew: isNewServiceResource,
            effectiveDate: JSON.stringify(effectiveDate),
            serviceEid: component.get("v.serviceEid")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == 'SUCCESS') {
                var responseString = response.getReturnValue();
                if (responseString == 'No Error') {
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                    document.getElementById("Accspinner").style.display = "none";
                    component.destroy();
                } else {
                    component.set("v.message", responseString);
                    document.getElementById("showErrorResource").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorResource").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorResource").style.display = "block";
                }
                document.getElementById("Accspinner").style.display = "none";
            }
        });
        $A.enqueueAction(action);
    }
})