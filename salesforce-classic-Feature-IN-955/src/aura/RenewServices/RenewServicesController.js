({
    OverrideAgreement: function(cmp, evt, helper) {
        var checkbox = evt.getSource();
        cmp.set("v.overrideDate", checkbox.get("v.value"));
        if (checkbox.get("v.value")) {
            document.getElementById("DeactivationDate").style.display = "table-row";
        } else {
            document.getElementById("DeactivationDate").style.display = "none";
        }
    },
    
    closeModalBox: function(component, event, helper) {
        document.getElementById("renewServicesModal").style.display = "none";
        document.getElementById("backGroundSectionRenew").style.display = "none";
    },
    
    handleServicesActionEvent: function(component, event, helper) {
        var serviceWrapper = event.getParam("ServiceWrapper");
        component.set("v.wrappers", serviceWrapper);
        helper.renewServiceMethod(component, event, helper);
    },

    saverenewServices: function(component, event, helper) {
        var agreementEid = component.find("agreementValue");
        var agreementEidValue = agreementEid.get("v.value");
        var recurringPrice = component.get("v.recurringPrice");
        var oneTimePrice = component.get("v.oneTimePrice");
        var dateOverrided = component.get("v.overrideDate");
        var deactivateDate = component.get("deactivateDate");
        var isError = false;
        if (agreementEidValue == undefined || agreementEidValue == "undefined" || agreementEidValue == "") {
            agreementEid.set("v.errors", [{
                message: "Please select the agreement."
            }]);
            isError = true;
        } 
        if (recurringPrice != undefined && recurringPrice.trim() != '' &&  isNaN(recurringPrice)) {
        	component.find("recurringPrice").set("v.errors", [{
                message: 'Please enter a valid integer price.'
            }]);
            isError = true;
        }
        if (oneTimePrice != undefined && oneTimePrice.trim() != '' &&  isNaN(oneTimePrice)) {
        	component.find("oneTimePrice").set("v.errors", [{
                message: 'Please enter a valid integer price.'
            }]);
            isError = true;
        }
        if (dateOverrided == true && deactivateDate != undefined && deactivateDate.trim() != '' ) {
        	component.find("deactivateDate").set("v.errors", [{
                message: 'Please enter a valid deactivation date.'
            }]);
            isError = true;
        }
        if (!isError) {
            helper.saveRenewServices(component, event, helper, agreementEidValue,recurringPrice, oneTimePrice, dateOverrided, deactivateDate);
        }
    }
})