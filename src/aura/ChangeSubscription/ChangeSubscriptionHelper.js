({
    getSubscriptions : function(component, event, helper, preserveAgreement) {
        var serviceEid =  component.get("v.wrappers").serviceEid;
        //var Account = component.get("v.wrappers").thisAccount;
        var accountCurrency = component.get("v.accountCurrency");
        var action = component.get("c.showPopupChangeService");        
        action.setParams({
            currentProductEid : serviceEid,
            currencyType : accountCurrency,
            preserveAgreement : preserveAgreement
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var subscriptionInfo = response.getReturnValue();
                console.log('subscriptionInfo:::::::'+JSON.stringify(subscriptionInfo));
                if(subscriptionInfo.errorMessage === 'NoError'){
                	component.set("v.subscriptionInfo", subscriptionInfo);
                	document.getElementById("Accspinner").style.display = "none";
                }else{
                	component.set("v.message", subscriptionInfo.errorMessage);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                    document.getElementById("finish").style.display = "none";
                    document.getElementById("new-subscription").style.display = "none";
                }
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            }
        });  
        
        $A.enqueueAction(action);
    },
    saveChangeSubscription : function(component, payOnPurchaseValue, subscriptionValue, effectiveDate, recurringPriceForChangedService) {
        var wrapperObj = component.get("v.changeSubscriptionInfo");
        var recurrenceField = component.find("recurrencePeriod");
        var recurrenceValue =  component.get("v.recurrence");
        var priceOverrided = false;
        if(recurringPriceForChangedService != wrapperObj.productPriceIdToPriceValueMap[recurrenceValue]){
        	priceOverrided = true;
        }
        var renewActionField = component.find("renew_action");
        var renewAction =  renewActionField.get("v.value");
        var agreementField = component.find("agreement");
        var agreementEid =  agreementField.get("v.value");
        var action = component.get("c.saveChangeServicesOnApex");        
        action.setParams({
            newSubscriptionId     					: subscriptionValue,
            effectiveDateValue     					: effectiveDate,
            currentServiceEid      					: component.get("v.wrappers").serviceEid,
            account                					: component.get("v.wrappers").thisAccount,
            payonPurchaseValue     					: payOnPurchaseValue,
            mapOfAgreementPeriod   					: wrapperObj.mapOfAgreementPeriod,
            productPriceIdToEidMap 					: wrapperObj.productPriceIdToEidMap,
            qtyOfChangedService    					: wrapperObj.quantity,
            agreementRenewActionForChangedService   : renewAction,
            agreementEidForChangedService			: agreementEid,
            recurringPrice							: recurringPriceForChangedService,
            recurringPriceId						: recurrenceValue,
            priceOverridden							: JSON.stringify(priceOverrided)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if(errors == "NoError"){
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                    document.getElementById("Accspinner").style.display = "none";
                    component.destroy();
                }else{
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            }
        });  
        $A.enqueueAction(action);
    }, 
    getDetailsForChangedService : function(component, event, ServiceId){
        var subscriptionWrapper = component.get("v.subscriptionInfo");
        subscriptionWrapper.subscriptionId = ServiceId;
        var action = component.get("c.getAgreementAndPriceConfigurationForChangedService");
        action.setParams({
            changeServiceinfoString : JSON.stringify(subscriptionWrapper),
            currencyType			: component.get("v.accountCurrency")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var subscriptionWrapper = response.getReturnValue();
                component.set("v.changeSubscriptionInfo", subscriptionWrapper);
                component.set("v.recurrence",subscriptionWrapper.recurringPriceList[0].value);
                if(subscriptionWrapper.canUpdateQty){
                    if(document.getElementById("qtyConfig")){
                     	document.getElementById("qtyConfig").style.display = "table-row";   
                    }
                }
                if(subscriptionWrapper.serviceHasAgreement){
                    component.set("v.agreement", subscriptionWrapper.agreementList[0].value);
                }
                var hidePriceConfigComponents = document.getElementsByClassName("price_config");
                for(var i = 0; i < hidePriceConfigComponents.length; i++){
                    hidePriceConfigComponents[i].style.display = "table-row";
                }
                if(!subscriptionWrapper.serviceHasAgreement){
                	document.getElementById("agreement_config").style.display = "none";
            		document.getElementById("renew_action").style.display = "none";
                }else{
                	document.getElementById("agreement_config").style.display = "table-row";
                	if(subscriptionWrapper.agreementList[0].value === '' || subscriptionWrapper.agreementList[0].value === null || subscriptionWrapper.agreementList[0].value === undefined){
                		document.getElementById("renew_action").style.display = "none";
                	}else{
                		document.getElementById("renew_action").style.display = "table-row";
                	}
                }
                document.getElementById("Accspinner").style.display = "none";
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrChange").style.display = "block";
                    document.getElementById("Accspinner").style.display = "none";
                }
            }
        });
        $A.enqueueAction(action); 
    },
    getPriceForRecurrence : function(component, event){
        var wrapperObj = component.get("v.changeSubscriptionInfo");
        var newRecurrencePrice = wrapperObj.productPriceIdToPriceValueMap[component.get("v.recurrence")];
        wrapperObj.recurringPrice = newRecurrencePrice;
        component.set("v.changeSubscriptionInfo", wrapperObj);
        document.getElementById("Accspinner").style.display = "none";
    }
})