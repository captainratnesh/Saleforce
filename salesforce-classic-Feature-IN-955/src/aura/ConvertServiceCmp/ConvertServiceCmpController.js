({
    closeModalBox: function(component, event, helper) {

        document.getElementById("ConvertServiceModal").style.display = "none";
        document.getElementById("backGroundSectionConvert").style.display = "none";
        document.getElementById("showErrorrConvert").style.display = "none";

    },
    handlerConvertServiceEvent: function(component, event, helper) {
        var serviceEidValue = event.getParam("ServiceEid");
        var serviceNameValue = event.getParam("ServiceName");
        component.set("v.ServiceEid", serviceEidValue);
        component.set("v.ServiceName", serviceNameValue);

    },
    ConvertService: function(component, event, helper) {
        helper.saveConvertService(component, event, helper);
    }
})