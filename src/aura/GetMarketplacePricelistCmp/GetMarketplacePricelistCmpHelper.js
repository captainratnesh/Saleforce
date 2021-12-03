({
    getMarketPlacePriceList : function(component, event, helper) {
        var action = component.get("c.getMarketPlacePriceLists"); 
        action.setParams({
            marketPlaceWrapString: JSON.stringify(component.get("v.marketPlaceWrap")),
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.ListsofPriceLists",res);
            }
        });
        $A.enqueueAction(action);
    }
})