({
    saveResumeService: function(component, event, helper) {

        var action = component.get("c.resumeServiceTract");
        action.setParams({
            serviceEidValue: component.get("v.ServiceEid")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                if (errors == "NoError") {
                    document.getElementById("ResumeServiceModal").style.display = "none";
                    document.getElementById("backGroundSectionResume").style.display = "none";
                    var appEvent = $A.get("e.c:ReloadAccountDetail");
                    appEvent.fire();
                } else {
                    document.getElementById("showErrorrResume").style.display = "block";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrResume").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrResume").style.display = "block";
                }
            }

        });
        $A.enqueueAction(action);
    }
})