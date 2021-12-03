({
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },

    doInit: function(component, event, helper) {
        var statusAction = component.get("v.statusString");
        var reasonFor;
        switch (statusAction) {

            case 'suspendaccountservice':
                reasonFor = 'Suspend';
                break;
            case 'resumeaccountservice':
                reasonFor = 'Resume';
                break;
            case 'deactivateaccountservice':
                reasonFor = 'Deactivate';
                break;
        }
        component.set("v.status", reasonFor);
        if (reasonFor != 'Resume') {
            helper.getStatusChangeReason(component, event, reasonFor);
        }
    },
    afterRender: function(component, event, helper) {
        var actionName = component.get("v.status");
        if (actionName === 'Resume') {
            document.getElementById("Accspinner").style.display = "none";
        }
    },
    changeBillingAccountStatus: function(component, event, helper) {
        document.getElementById("Accspinner").style.display = "block";
        var statusToChange = component.get("v.status");
        if (statusToChange === 'Resume') {
            helper.resumeBillingAccount(component, event);
        } else if (statusToChange != 'Resume') {
            var reasonInput = component.find("reason");
            var reasonEid = reasonInput.get("v.value");
            if (reasonEid === undefined || reasonEid === null || reasonEid === '') {
                var reasonField = component.find("reason");
                reasonField.set("v.errors", [{
                    message: "Please select the reason."
                }]);
                document.getElementById("Accspinner").style.display = "none";
            } else {
                if (statusToChange === 'Suspend') {
                    helper.suspendBillingAccount(component, event, reasonEid);
                } else if (statusToChange === 'Deactivate') {
                    helper.deactivateBillingAccount(component, event, reasonEid);

                }
            }
        }
    }
})