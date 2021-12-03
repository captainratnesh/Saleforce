({
    setProductOverrideData : function(component, event, helper) {
        var length = component.get("v.wrappers.overridedTrialLength");
        component.set("v.priceOverride",length);
    },
    savePriceLength:function(component, priceOverrideValue) {
        console.log('priceOverrideValue::::::::;'+priceOverrideValue);

        component.set("v.wrappers.overridedTrialLength",priceOverrideValue);
        var appEvent = $A.get("e.c:ReturnOverrideTrailLength");
        appEvent.setParams({
            "productWrapper": component.get("v.wrappers")
        });
        appEvent.fire();
        document.getElementById("showErrorrUpdate").style.display = "none";
        component.destroy();
       /* document.getElementById("UpdateQtyModal").style.display = "table";
        document.getElementById("backGroundSectionUpdate").style.display = "none"; */
        
    }
 
})