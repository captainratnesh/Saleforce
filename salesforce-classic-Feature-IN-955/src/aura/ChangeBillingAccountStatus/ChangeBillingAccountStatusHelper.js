({
    getStatusChangeReason: function(component, event, reasonFor) {
        var action = component.get("c.getBillingAccountStatusChangeReason");
        action.setParams({
            reasonFor: reasonFor
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var reasonList = response.getReturnValue();
                component.set("v.reasonList", reasonList);
                document.getElementById("Accspinner").style.display = "none";
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
    suspendBillingAccount: function(component, event, reasonEid) {
        var action = component.get("c.suspendBillingAccount");
        action.setParams({
            accountString: JSON.stringify(component.get("v.billingAccount")),
            reasonEid: reasonEid
            //effectiveDate: effectiveDate
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                if (errorMessage === 'NoError') {
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                    document.getElementById("Accspinner").style.display = "none";
                    component.destroy();
                } else {
                    component.set("v.message", errorMessage);
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
    deactivateBillingAccount: function(component, event, reasonEid) {
        var action = component.get("c.deactivateBillingAccount");
        action.setParams({
            accountString: JSON.stringify(component.get("v.billingAccount")),
            reasonEid: reasonEid
           // effectiveDate: effectiveDate
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                if (errorMessage === 'NoError') {
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                    document.getElementById("Accspinner").style.display = "none";
                    component.destroy();
                } else {
                    component.set("v.message", errorMessage);
                    document.getElementById("showErrorResource").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            } else {
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
    resumeBillingAccount: function(component, event) {

        var action = component.get("c.resumeBillingAccount");
        action.setParams({
            accountString: JSON.stringify(component.get("v.billingAccount"))
         //   effectiveDate: effectiveDate
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                if (errorMessage === 'NoError') {
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                    document.getElementById("Accspinner").style.display = "none";
                    component.destroy();
                } else {
                    component.set("v.message", errorMessage);
                    document.getElementById("showErrorResource").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            } else {
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