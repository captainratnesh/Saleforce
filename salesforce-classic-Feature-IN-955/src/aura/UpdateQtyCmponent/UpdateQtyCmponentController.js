({
    doInit: function(component, event, helper) {
        helper.getDisplayEffectiveDate(component, event, helper);
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
        var displayEffectiveDate = component.get("v.displayEffectiveDate");
        var newQuantity = component.find("NewQuantity");
        var newQuantityValue = newQuantity.get("v.value");
        var effectiveDate = component.find("effectiveDate");
        var effectiveDateValue = effectiveDate.get("v.value");
        if (newQuantityValue == undefined || newQuantityValue == "undefined" || newQuantityValue == "") {
            newQuantity.set("v.errors", [{
                message: "New Quantity is Required."
            }]);
        } else {
            newQuantity.set("v.errors", [{
                message: null
            }]);
            if (displayEffectiveDate === true && (effectiveDateValue == undefined || effectiveDateValue == "undefined" || effectiveDateValue == "")) {
                effectiveDate.set("v.errors", [{
                    message: "Effective Date is required."
                }]);
            } else {
                effectiveDate.set("v.errors", [{
                    message: null
                }]);
                helper.saveUpdateQty(component, displayEffectiveDate, newQuantityValue, effectiveDateValue);
            }
        }
    },
    waiting: function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting: function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})