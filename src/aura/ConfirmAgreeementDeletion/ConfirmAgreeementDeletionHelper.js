({
    removeAgreementRelation:function(component, event, helper) {
        var action = component.get("c.deleteProductAgreementRelation");        
        action.setParams({
            productId : component.get("v.productId"),
            currentAgreement: JSON.stringify(component.get("v.currentAgre"))
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var appEvent = $A.get("e.c:ReloadProductDetail");
                appEvent.fire();
                component.destroy();

            }
        });  
        $A.enqueueAction(action);
    }
})