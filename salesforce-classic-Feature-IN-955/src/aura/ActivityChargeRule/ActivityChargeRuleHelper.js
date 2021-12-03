({
    showActivityCharge: function(component) {

        var action = component.get("c.showActivityChargeRule");

        action.setParams({
            activityProductEid: component.get("v.wrappers").serviceEid
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var ActivtyChargeWrapper = response.getReturnValue();
                component.set("v.activityChargeWrapper", ActivtyChargeWrapper);
            } else if (state === "ERROR") {

                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorAddAddress").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorAddAddress").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    deleteActivityCharge: function(component, activityWrapper) {

        var action = component.get("c.deleteActivityChargeRule");
        action.setParams({
            tract: component.get("v.wrappers").thistract,
            activityProductEid: component.get("v.wrappers").serviceEid,
            deletedUsageEid: activityWrapper.usageRuleEid,
            activityRuleName: activityWrapper.chargeType
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    document.getElementById("activityChargeModal").style.display = "none";
                    document.getElementById("backGroundActivityCharge").style.display = "none";
                } else {
                    document.getElementById("showErrorAddAddress").style.display = "block";
                }
            } else if (state === "ERROR") {

                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorAddAddress").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorAddAddress").style.display = "block";
                }
            }

        });
        $A.enqueueAction(action);
    }
})