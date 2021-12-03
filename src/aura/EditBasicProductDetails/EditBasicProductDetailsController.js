({
    onPriceListChange : function(component, event, helper) {
        var priceListValue = event.getSource().get("v.value");
        var proWrapper = component.get("v.productWrapper");
        proWrapper.priceListValue = priceListValue;
        helper.getProductPrices(component, proWrapper);
        
    },
    closeModalBox : function(component, event, helper) {
        component.destroy();
    },

    doinit : function(component, event, helper) {
        //component.destroy();
    },
    editProduct : function(component, event, helper) {
        var appEvent = $A.get("e.c:EditBasicProductDetailsReturnEvent");
        appEvent.setParams({"productWrapper": component.get("v.productWrapper")});
        appEvent.fire();
        component.destroy();
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})