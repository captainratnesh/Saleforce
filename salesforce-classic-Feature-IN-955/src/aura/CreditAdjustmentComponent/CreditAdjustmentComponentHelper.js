({
    getCreditAdjustmentReson: function(component, event, helper) {
        var action = component.get("c.showCreditAdjustment");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var reasonList = response.getReturnValue();
                component.set("v.reasonList", reasonList);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorCredit").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorCredit").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    saveCreditAdjustment: function(component, reasonEidValue, ammountValue, descriptionValue, effectiveDateValue, manuallyApplyValue) {
        var accountIdValue = component.get("v.accountId");
        var action = component.get("c.saveCreditAdjustmentTract");
        action.setParams({
            accountId: accountIdValue,
            adjustmentReasonEid: reasonEidValue,
            ammount: ammountValue,
            description: descriptionValue,
            effectiveDate: effectiveDateValue,
            manualInvoice: manuallyApplyValue
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    var reasonEid = component.find("creditReasonEid");
                    reasonEid.set("v.value", "choose one");
                    var ammount = component.find("CreditAmmount");
                    ammount.set("v.value", null);
                    var description = component.find("CreditDescription");
                    description.set("v.value", null);
                    var effectiveDate = component.find("CrediteffectiveDate");
                    effectiveDate.set("v.value", null);
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                	component.destroy();
                    
                } else {
                    document.getElementById("showErrorCredit").style.display = "block";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorCredit").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorCredit").style.display = "block";
                }
            }

        });
        $A.enqueueAction(action);
    }
})