({
    doinit: function(component, event, helper) {
        helper.getSubscriptions(component, event, helper, false);
        //hide price configuration components
        var hidePriceConfigComponents = document.getElementsByClassName("price_config");
        for (var i = 0; i < hidePriceConfigComponents.length; i++) {
            hidePriceConfigComponents[i].style.display = "none";
        }
        //hide agreement configuration components
        var hideAgreementConfigComponents = document.getElementsByClassName("agreement_configuration");
        for (var i = 0; i < hideAgreementConfigComponents.length; i++) {
            hideAgreementConfigComponents[i].style.display = "none";
        }
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    handleChangeInAgreement: function(cmp, evt, helper) {
        var selectedAgreement = cmp.find("agreement").get("v.value");
        if(selectedAgreement === '' || selectedAgreement === null || selectedAgreement === undefined){
        	document.getElementById("renew_action").style.display = "none";
        }else{
        	document.getElementById("renew_action").style.display = "table-row";
        }
    },
    saveChangeServices: function(component, event, helper) {
        document.getElementById("Accspinner").style.display = "block";
        var payOnPurchase = component.find("checkbox");
        var payOnPurchaseValue = payOnPurchase.get("v.value");
        var subscriptionField = component.find("subscriptionValue");
        var subscriptionValue = component.get("v.newSubscriptionEid");
        if (subscriptionValue === undefined || subscriptionValue.trim() === "") {
            subscriptionField.set("v.errors", [{
                message: "Please select a subscription."
            }]);
            document.getElementById("Accspinner").style.display = "none";
        } else {
            subscriptionField.set("v.errors", [{
                message: null
            }]);
            var effectiveDateField = component.find("EffectiveDateValue");
	        var effectiveDateValue = effectiveDateField.get("v.value");

	        var wrapperObj = component.get("v.changeSubscriptionInfo");
	        var recurringPrice;
	        var changedServiceSupportsPriceOverride = wrapperObj.supportsPriceOverride;
	
	        if (changedServiceSupportsPriceOverride) {
	            recurringPrice = wrapperObj.recurringPrice;
	        } else {
	            recurringPrice = null;
	        }
	        
            if (effectiveDateValue == undefined || effectiveDateValue == "undefined" || effectiveDateValue == "") {
                effectiveDateField.set("v.errors", [{
                    message: "Please select the effectiveDate."
                }]);
                document.getElementById("Accspinner").style.display = "none";
            } else {
                effectiveDateField.set("v.errors", [{
                    message: null
                }]);

                helper.saveChangeSubscription(component, payOnPurchaseValue, subscriptionValue, effectiveDateValue, recurringPrice);
            }
        }
    },
    getSelectedServiceDetails: function(component, event, helper) {
        document.getElementById("Accspinner").style.display = "block";
        var subscriptionField = component.find("subscriptionValue");
        var subscriptionValue = component.get("v.newSubscriptionEid");
        if (subscriptionValue == undefined || subscriptionValue == "undefined" || subscriptionValue == "") {
            var hidePriceConfigComponents = document.getElementsByClassName("price_config");
            for (var i = 0; i < hidePriceConfigComponents.length; i++) {
                hidePriceConfigComponents[i].style.display = "none";
            }
            //hide agreement configuration components
            document.getElementById("agreement_config").style.display = "none";
            document.getElementById("renew_action").style.display = "none";
            document.getElementById("payOnPurchaseCheckBox").style.display = "none";
            document.getElementById("effectiveDateSelector").style.display = "none";
            document.getElementById("Accspinner").style.display = "none";
        } else {
            subscriptionField.set("v.errors", [{
                message: null
            }]);
            document.getElementById("payOnPurchaseCheckBox").style.display = "table-row";
            document.getElementById("effectiveDateSelector").style.display = "table-row";
            helper.getDetailsForChangedService(component, event, subscriptionValue)
        }
    },
    handleChangeInPreserveAgreement: function(component, event, helper) {
        document.getElementById("Accspinner").style.display = "block";
        document.getElementById("payOnPurchaseCheckBox").style.display = "none";
        document.getElementById("effectiveDateSelector").style.display = "none";
        var hidePriceConfigComponents = document.getElementsByClassName("price_config");
        for (var i = 0; i < hidePriceConfigComponents.length; i++) {
            hidePriceConfigComponents[i].style.display = "none";
        }
        //hide agreement configuration components
        document.getElementById("agreement_config").style.display = "none";
        document.getElementById("renew_action").style.display = "none";
        if(document.getElementById("qtyConfig")){
    		document.getElementById("qtyConfig").style.display = "none";
        }
        var preserveAgreementCheckBox = component.find("PreserveAgreementCheckbox");
        var preserveAgreement = preserveAgreementCheckBox.get("v.value");
        helper.getSubscriptions(component, event, helper, preserveAgreement);
    },
    handleChangeInRecurrence: function(component, event, helper) {
        document.getElementById("Accspinner").style.display = "block";
        helper.getPriceForRecurrence(component, event);
    }
})