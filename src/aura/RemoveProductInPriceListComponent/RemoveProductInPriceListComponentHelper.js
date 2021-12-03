({
    getAllProducts : function(component, event, helper) {
        console.log('v.priceListWrap.priceListId::::'+component.get("v.priceListWrap.priceListId"));
        var action = component.get("c.getProductsListToRemove"); 
        action.setParams({
            priceListEid: component.get("v.priceListWrap.priceListId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.AvailableAndSelectedProductsWrap",res);
                console.log('res::::'+res);
            }
        });
        $A.enqueueAction(action);
    },
    addSelectedProducts : function(component, event, helper) {
        var action = component.get("c.removeProductFromPriceList"); 
        console.log('selectedProducts::::'+JSON.stringify(component.get("v.AvailableAndSelectedProductsWrap")));
        action.setParams({
            priceListEid: component.get("v.priceListWrap.priceListId"),
            removeSelectedProducts: JSON.stringify(component.get("v.AvailableAndSelectedProductsWrap"))
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                if(res == 'NoError'){
                    console.log('res::::'+res);
                    var appEvent = $A.get("e.c:ReloadPriceListComponent");
                    appEvent.fire();
                    component.destroy(); 
                }
                else{
                    component.set("v.message",res);
                    document.getElementById("showErrorRemoveProductsFromPriceList").style.display = "block";
                } 
            }
            else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorRemoveProductsFromPriceList").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorRemoveProductsFromPriceList").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    }
})