({
    doInit: function(component, event, helper) {
        console.log('wrappers:::::::;'+JSON.stringify(component.get("v.wrappers")));
        helper.setProductOverrideData(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
        /* 
         document.getElementById("UpdateQtyModal").style.display = "none";
         document.getElementById("backGroundSectionUpdate").style.display = "none"; 
         document.getElementById("showErrorrUpdate").style.display = "none"; */
    },
    /*handlerUpdateQtyEvent : function(component, event, helper) {
        
        var serviceWrapper = event.getParam("ServiceWrapper");
        component.set("v.wrappers", serviceWrapper);
        
    },*/
    UpdateQty: function(component, event, helper) {
        var priceOverrideValue = component.get("v.wrappers.overridedTrialLength");
        if (priceOverrideValue == undefined || priceOverrideValue == "undefined" || priceOverrideValue == "") {
            component.set("v.message","Field 'Override Length of Trial' is required.");
            document.getElementById("showErrorrUpdate").style.display = "block";
        } else {
            helper.savePriceLength(component, priceOverrideValue);
        }
    },
    waiting: function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting: function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})