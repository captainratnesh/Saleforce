({
    doinit: function(component, event, helper) {
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    onCountryChange: function(component, event, helper) {
        var country = component.find("countryName").get("v.value");
        var serviceWrapper = component.get("v.wrappers");
        if (country == "USA" || country == "CAN" || country == "MEX") {
            document.getElementById("multipleState").style.display = "block";
            document.getElementById("singleState").style.display = "none";
        }
        if (country == "USA") {
            component.set("v.stateValue", "State:");
            component.set("v.countryState", serviceWrapper.stateUsaTract);
        } else if (country == "CAN") {
            component.set("v.stateValue", "Province/Territory:");
            component.set("v.countryState", serviceWrapper.stateCanTract);
        } else if (country == "MEX") {
            component.set("v.stateValue", "State:");
            component.set("v.countryState", serviceWrapper.stateMexTract);
        } else if (country== "undefined"){
            component.set("v.stateValue", "State:");
        	var a;
            component.set("v.countryState", a);
        }
        else {
            document.getElementById("multipleState").style.display = "none";
            document.getElementById("singleState").style.display = "block";
        }


    },
    handleAddAddressEvent: function(component, event, helper) {
        /*var serviceWrapper = event.getParam("ServiceWrapper");
        component.set("v.wrappers", serviceWrapper);*/
        //component.set("v.countryState", serviceWrapper.stateUsaTract);

    },

    saveAddAddress: function(component, event, helper) {
        var countryName = component.find("countryName");
        var countryNameValue = countryName.get("v.value");
        var addressLine = component.find("AddressLine1");
        var addressLineValue = addressLine.get("v.value");
        var addressLine2 = component.find("AddressLine2");
        var addressLineValue2 = addressLine2.get("v.value");
        var city = component.find("city");
        var cityvalue = city.get("v.value");
        var state = "";
        var stateName = "";
        if (countryNameValue == "USA" || countryNameValue == "MEX" || countryNameValue == "CAN") {
            state = component.find("stateName");
            stateName = state.get("v.value");
        } else {
            state = component.find("singleStateName");
            stateName = state.get("v.value");
        }
        var postalCode = component.find("postalCode");
        var postalCodeValue = postalCode.get("v.value");
        if (countryNameValue === undefined||countryNameValue === ''||countryNameValue === "undefined") {
            countryName.set("v.errors", [{
                message: "Field Country is required."
            }]);
        } else {
            countryName.set("v.errors", [{
                message: null
            }]);
            if (addressLineValue === undefined || addressLineValue === "") {
                addressLine.set("v.errors", [{
                    message: "Field Address Line 1 is required."
                }]);
            } else {
                addressLine.set("v.errors", [{
                    message: null
                }]);
                if (cityvalue === undefined || cityvalue === "") {
                    city.set("v.errors", [{
                        message: "Field City is required."
                    }]);
                } else {
                    city.set("v.errors", [{
                        message: null
                    }]);
                    if (stateName === undefined || stateName == "undefined" || stateName === "") {
                        state.set("v.errors", [{
                            message: "Field state is required."
                        }]);
                    } else {
                        state.set("v.errors", [{
                            message: null
                        }]);
                        if (postalCodeValue === undefined || postalCodeValue === "") {
                            postalCode.set("v.errors", [{
                                message: "Field Postal Code is required."
                            }]);
                        } else {
                            postalCode.set("v.errors", [{
                                message: null
                            }]);
                            helper.saveAddAddress(component, countryNameValue, addressLineValue, addressLineValue2, cityvalue, stateName, postalCodeValue);
                        }
                    }

                }
            }
        }

    }
})