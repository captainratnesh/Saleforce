({
    closeModalBox: function(component, event, helper) {

        document.getElementById("ResumeServiceModal").style.display = "none";
        document.getElementById("backGroundSectionResume").style.display = "none";
        document.getElementById("showErrorrResume").style.display = "none";

    },
    handlerResumeServiceEvent: function(component, event, helper) {
        var serviceEidValue = event.getParam("ServiceEid");
        var serviceNameValue = event.getParam("ServiceName");
        component.set("v.ServiceEid", serviceEidValue);
        component.set("v.ServiceName", serviceNameValue);

    },
    ResumeService: function(component, event, helper) {
        helper.saveResumeService(component, event, helper);
    }
})