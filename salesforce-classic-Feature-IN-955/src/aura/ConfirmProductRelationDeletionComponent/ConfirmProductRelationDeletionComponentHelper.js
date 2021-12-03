({
    removeproductRelation:function(component, event, helper) {
        var action = component.get("c.deleteProductRelations"); 
        console.log('xsas::::::::::'+JSON.stringify(component.get("v.productRelationWrap")));
        action.setParams({
            productRelation: JSON.stringify(component.get("v.productRelationWrap")),
            productId : component.get("v.productId")
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