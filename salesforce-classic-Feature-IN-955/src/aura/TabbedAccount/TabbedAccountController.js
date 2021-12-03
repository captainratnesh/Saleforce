({
   doInit: function(component, event, helper) {
        helper.checkTractAccount(component, event, helper);
    },
    waiting: function(component, event, helper) {
        //component.set("v.wait", "updating...");
        document.getElementById("showspinner").style.display = "block";
    },
    doneWaiting: function(component, event, helper) {
        //component.set("v.wait", "");
        document.getElementById("showspinner").style.display = "none";
    },
    cancelBillingAccount: function(component, event, helper) {
        var Get_getUITheme = component.get("v.getUITheme");
        //if (Get_getUITheme === 'Theme4d' || Get_getUITheme === 'Theme4t') {
        //    sforce.one.navigateToSObject(component.get("v.AccountId"));
        //} 
       // else {
            window.location.href = '/' + component.get("v.AccountId");
       // }
    }
})