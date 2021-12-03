({
    renewServiceMethod: function(component, event, helper) {
        var action = component.get("c.showServices");
        action.setParams({
            thisAccount				: component.get("v.wrappers").thisAccount,
            serviceRenewEid			: component.get("v.wrappers").serviceEid
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var serviceWrapper = response.getReturnValue();
                component.set("v.agreementWrappers", serviceWrapper);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrChangeServices").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrChangeServices").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    saveRenewServices: function(component, event, helper, agreementEidValue, recurringPrice, oneTimePrice, dateOverrided, deactivateDate) {
        var action = component.get("c.savePopupRenew");
        action.setParams({
            renewAgreementEid		: agreementEidValue,
            tract					: component.get("v.wrappers").thistract,
            thisAccount				: component.get("v.wrappers").thisAccount,
            serviceRenewEid			: component.get("v.wrappers").serviceEid,
            recurringPriceString	: recurringPrice,
            oneTimePriceString		: oneTimePrice,
            dateOverridden			: dateOverrided,
            deactivateDateString	: JSON.stringify(deactivateDate)
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    document.getElementById("renewServicesModal").style.display = "none";
                    document.getElementById("backGroundSectionRenew").style.display = "none";
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                } else {
                    document.getElementById("showErrorrChangeServices").style.display = "block";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrChangeServices").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrChangeServices").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    }
})