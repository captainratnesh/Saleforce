({
    getProductPrices : function(component, oppProWrapper){
        var action = component.get("c.getProductPricesApex");        
        action.setParams({
            productWrapperString : JSON.stringify(oppProWrapper)
        })
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                console.log('state::::;'+state);
                var prodwrapper = response.getReturnValue();
                console.log('prodwrapper::::;'+prodwrapper);
                component.set("v.productWrapper", prodwrapper);
            }else if(state === 'ERROR'){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    }
})