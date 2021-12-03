({
    addAgreement: function(component, event, helper, proId, currency) {
        var action = component.get("c.getProductAgreement");
        action.setParams({
            productId: proId,
            currencyType: currency
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var agreementWrap = response.getReturnValue();
                if (agreementWrap.agreementList.length > 0) {
                    component.set("v.agreement", true);
                    component.set("v.agreementWrapper", agreementWrap);
                    this.afterRender(component, event);
                } else {
                    component.set("v.agreement", false);
                    var divsToHide = document.getElementsByClassName("showAgreement"); //divsToHide is an array
                    for (var i = 0; i < divsToHide.length; i++) {
                        divsToHide[i].style.display = "none"; // depending on what you're doing
                    }
                }
            } else if (state === 'ERROR') {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorAddAgreement").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorAddAgreement").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    afterRender: function(component, event) {
        var productWrapper = component.get("v.productWrapper");
        if (productWrapper.agreementId == undefined || productWrapper.agreementId.trim() == '') {
            var agreementWrap = component.get("v.agreementWrapper");
            if (agreementWrap != null) {
                var agreementList = agreementWrap.agreementList;
                if (agreementList[0].value != ' ') {
                    var agreementValue = agreementList[0].value;
                    productWrapper.agreementId = agreementValue;
                    var recPer = agreementWrap.mapOfAgreementPeriod[agreementValue];
                    productWrapper.agreementPeriod = recPer;
                    var periodType = agreementWrap.mapOfAgreementPeriodType[agreementValue];
                    component.set("v.productWrapper",productWrapper);
                    component.set("v.selectedAgreementId", agreementValue); 
                    component.set("v.agrementPer", periodType);
                    var divsToHide = document.getElementsByClassName("showAgreement"); //divsToHide is an array
                    for (var i = 0; i < divsToHide.length; i++) {
                        divsToHide[i].style.display = "table-row"; // depending on what you're doing
                    }
                } else {
                    var divsToHide = document.getElementsByClassName("showAgreement"); //divsToHide is an array
                    for (var i = 0; i < divsToHide.length; i++) {
                        divsToHide[i].style.display = "none"; // depending on what you're doing
                    }
                }
            }
        } else {
            var deactivationDateChecked = component.get("v.deactivationDateChecked");
            if (deactivationDateChecked) {
                document.getElementById("DeactivationDateId").style.display = "table-row"
            }
            var agreementWrap = component.get("v.agreementWrapper");
            if (agreementWrap != null) {
                var periodType = agreementWrap.mapOfAgreementPeriodType[productWrapper.agreementId];
                component.set("v.agrementPer", periodType);
            }
        }
    }
})