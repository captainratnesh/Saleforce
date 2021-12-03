({
	closeModalBox : function(component, event, helper) {
        
        document.getElementById("activityChargeModal").style.display = "none";
        document.getElementById("backGroundActivityCharge").style.display = "none";
        document.getElementById("showErrorAddAddress").style.display = "none";
        document.documentElement.classList.remove('body-hidden');
    
    },
	handleActivityChargeEvent : function(component, event, helper) {
        var serviceWrapper = event.getParam("ServiceWrapper");
        component.set("v.wrappers", serviceWrapper);
        helper.showActivityCharge(component);
    },
    AddActivityCharge : function(component, event, helper) {
        var serviceWrapper = component.get("v.wrappers");
        $A.createComponent(
            "c:AddActivityCharge", {
                "wrapperString": JSON.stringify(serviceWrapper)
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    },
    deleteChargeRule : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var countdelete = selectedItem.dataset.countdelete;
        var activityWrapper = component.get("v.activityChargeWrapper["+countdelete+"]");
        helper.deleteActivityCharge(component, activityWrapper);
    }
})