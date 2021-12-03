({
    doInit : function(component, event, helper) {
        helper.showAccValue(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
        
    },
    waiting: function(component, event, helper) {
        //component.set("v.wait", "updating...");
        component.set("v.HideSpinner", true); 
    },
    doneWaiting: function(component, event, helper) {
        //component.set("v.wait", "");
        component.set("v.HideSpinner", false); 
    },
    onRecordSelect:function(component, event, helper) {
        console.log('selectdContactId:::'+event.getSource().get("v.value"));
    }
})