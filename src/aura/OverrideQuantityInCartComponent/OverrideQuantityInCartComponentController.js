({
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },

    overrideQty: function(component, event, helper) {
        var newQuantityValue = component.get("v.newQuantity");
        if (newQuantityValue == undefined || newQuantityValue == "undefined" || newQuantityValue === "") {
            component.set("v.message", "New Quantity is Required.");
            document.getElementById("showErrorrOverrideQtyInCart").style.display = "block";
        } else {
            var addedProductWrapper = component.get("v.AddedProductWrapper");
            addedProductWrapper.quantity = component.get("v.newQuantity");
            component.set("v.AddedProductWrapper", addedProductWrapper);
            var appEvent = $A.get("e.c:OverrirdeQtyInCartReturnEvent");
            appEvent.setParams({
                "addedProductWrapper": component.get("v.AddedProductWrapper")
            });
            appEvent.fire();    
            component.destroy(); 
        }
    }
    
})