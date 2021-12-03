({
    saveAddAddress: function(component, countryNameValue, addressLineValue, addressLine2, city, stateName, postalCodeValue) {
        var action = component.get("c.saveAddAddressTract");
        action.setParams({
            currentServiceEid: component.get("v.wrappers").serviceEid,
            countryListValue: countryNameValue,
            billingCity: addressLineValue,
            shippingCountry: addressLine2,
            shippingCity: city,
            stateValue: stateName,
            postalCode: postalCodeValue
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    component.destroy();
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
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