({
    doInit : function(component, event, helper) {
    	var reasonWrapper = component.get("v.wrappers");
        
    },
    closeModalBox : function(component, event, helper) {
        component.destroy();
    } ,
    handleChanged : function(cmp,evt,helper){
        var checkbox = evt.getSource();
        if(checkbox.get("v.value")){
            cmp.set("v.showDate",true);
        }
        else{
            cmp.set("v.showDate",false);
        }
        
    },
 
    saveDeactivateAction : function(component, event, helper) {
        var reasonEid =  component.find("ReasonEid");
        var reasonEidValue =  reasonEid.get("v.value");
        if(component.get("v.showDate")){
        var deactivationDate =  component.find("deactivationDate").get("v.value");
        component.set("v.deactivationDate",deactivationDate);
        }        
        if (reasonEidValue == undefined || reasonEidValue == "undefined" || reasonEidValue == "" ){
            reasonEid.set("v.errors", [{message:"Reason is required."}]);
        }else{
            reasonEid.set("v.errors", [{message:null}]);
            helper.saveDeactivateServices(component, event, helper);
        }
    }
})