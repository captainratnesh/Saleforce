({
    doinit : function(component, event, helper) {		
	},
    closeModalBox : function(component, event, helper) {
        component.destroy();
    },
    handlerSuspendService : function(component, event, helper) {
        var serviceWrapper = event.getParam("ServiceWrapper");
        component.set("v.wrappers", serviceWrapper);
        var reasonWrapper = component.get("v.wrappers");         
    },
    saveSuspendService : function(component, event, helper) {  
        var reasonEid =  component.find("ReasonEid");
        var reasonEidValue =  reasonEid.get("v.value");         
        if (reasonEidValue == undefined || reasonEidValue == "undefined" || reasonEidValue == ""){
            reasonEid.set("v.errors", [{message:"Reason is required."}]);
        }else{
            reasonEid.set("v.errors", [{message:null}]);
            helper.saveSuspendServices(component, event, helper);
        }
    }
})