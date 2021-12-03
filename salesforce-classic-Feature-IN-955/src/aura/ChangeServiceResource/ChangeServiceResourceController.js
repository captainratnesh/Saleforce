({
    closeModalBox: function(component, event, helper) {

        component.destroy();
    },

    selectedNewResource: function(component, event, helper) {
        document.getElementById("newServiceResource").style.display = "table-row";
        document.getElementById("existingServiceResource").style.display = "none";
        document.getElementById("override").style.display = "table-row";
        component.find("EffectiveDateValue").set("v.errors", [{
            message: null
        }]);
        component.find("existingServiceResourceInput").set("v.errors", [{
            message: null
        }]);
        component.find("existingServiceResource").set("v.value", false);
        component.set("v.message", 'NoError');
        document.getElementById("showErrorResource").style.display = "none";
    },

    selectedExistingResource: function(component, event, helper) {
        document.getElementById("existingServiceResource").style.display = "table-row";
        document.getElementById("newServiceResource").style.display = "none";
        document.getElementById("override").style.display = "table-row";
        component.find("EffectiveDateValue").set("v.errors", [{
            message: null
        }]);
        component.find("newServiceResourceInput").set("v.errors", [{
            message: null
        }]);
        component.find("newServiceResource").set("v.value", false);
        component.set("v.message", 'NoError');
        document.getElementById("showErrorResource").style.display = "none";
    },

    doinit: function(component, event, helper) {},
    
    showOverrideDateSelector: function(component, event, helper){
    	component.set("v.message", 'NoError');
    	document.getElementById("showErrorResource").style.display = "none";
    	var checked = component.find("allowOverrideDate").get("v.checked");
    	if(checked){
    		document.getElementById("effectiveDateSelector").style.display = "table-row";
    	} else {
    		document.getElementById("effectiveDateSelector").style.display = "none";
    		component.set("v.effectiveDate",null);
    	}
    },
      
    saveServiceResource: function(component, event, helper) {
        document.getElementById("Accspinner").style.display = "block";
        var effectiveDateField = component.find("EffectiveDateValue");
        var serviceResourceIdentifier = component.get("v.serviceResource");
        var existingServiceResource = component.find("existingServiceResourceInput");
        var newServiceResource = component.find("newServiceResourceInput");
        if (serviceResourceIdentifier === undefined || serviceResourceIdentifier === null || serviceResourceIdentifier.trim() === '') {
            if (component.find("newServiceResource").get("v.value") == false && component.find("existingServiceResource").get("v.value") == false) {
                component.set("v.message", 'No Service Resource added.');
                document.getElementById("showErrorResource").style.display = "block";
            } else {
                if (component.find("existingServiceResource").get("v.value")) {
                    existingServiceResource.set("v.errors", [{
                        message: "Please enter the service resource."
                    }]);
                } else {
                    newServiceResource.set("v.errors", [{
                        message: "Please enter the service resource."
                    }]);
                }
            }
            document.getElementById("Accspinner").style.display = "none";
        } else {
            existingServiceResource.set("v.errors", [{
                message: null
            }]);
            newServiceResource.set("v.errors", [{
                message: null
            }]);
            if (component.find("allowOverrideDate").get("v.checked") && (component.get("v.effectiveDate") === undefined || component.get("v.effectiveDate") === null)) {
                effectiveDateField.set("v.errors", [{
                    message: "Please select the effective date."
                }]);
                document.getElementById("Accspinner").style.display = "none";
            } else {
                effectiveDateField.set("v.errors", [{
                    message: null
                }]);
                if (component.find("existingServiceResource").get("v.value")) {
                    helper.validateServiceResource(component, event, serviceResourceIdentifier);
                } else if (component.find("newServiceResource").get("v.value")) {
                    helper.applyChangedServiceResource(component, event, true, serviceResourceIdentifier);
                }
            }
        }
    }
})