({
    getAPiVersion : function(component, event, helper) {
        var action = component.get("c.getApiVersion"); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.ApiVersion",res);
            }
        });
        $A.enqueueAction(action);
    },
    ListOfOneTimeProductPrice : function(component, event, helper) {
        var action = component.get("c.getOneTimeProductPrice");        
        action.setParams({
            productId : component.get("v.productDetails").productEid,
            priceListEid: component.get("v.priceListWrap").priceListId
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var oneTimeProductPriceList = response.getReturnValue();
            component.set("v.oneTimeProductPriceList", oneTimeProductPriceList);
        });  
        $A.enqueueAction(action);
    },
    
	ListOfRecurringProductPrice : function(component, event, helper) {
        var action = component.get("c.getRecurringProductPrice");        
        action.setParams({
            productId : component.get("v.productDetails").productEid,
            priceListEid: component.get("v.priceListWrap").priceListId
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var recurringProductPriceList = response.getReturnValue();
            component.set("v.recurringProductPriceList", recurringProductPriceList);
        });  
        $A.enqueueAction(action);
    }
})