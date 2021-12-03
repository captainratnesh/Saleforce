({
    doinit: function(component, event, helper) {
        console.log('I am here');
        helper.getChildAccount(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {

        component.destroy();
    },
    waiting: function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting: function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})