({
    getProductPrices: function (component, event, prodWrapper) {
        var action = component.get("c.getProductPricesApex");
        action.setParams({
            productWrapperString: JSON.stringify(prodWrapper)
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var responseWrapper = response.getReturnValue();
                //component.set("v.pro", responseWrapper);
                this.setPriceCurrency(component, event,responseWrapper);
            } else {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action); 
    },

    setPriceCurrency : function(component, event, prodWrapper){
        var action = component.get("c.setOrderCurrencyType");
        action.setParams({
            proShowString : JSON.stringify(prodWrapper),
            tract		  : undefined
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var responseWrapper = response.getReturnValue();
                component.set("v.pro", responseWrapper);
            }else{
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
    },

    getpriceRangeValue : function(component, event, prodWrapper){
        var action = component.get("c.getpriceRangeValue");
        action.setParams({
            productWrapperString : JSON.stringify(prodWrapper)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var responseWrapper = response.getReturnValue();
                //proWrapper.childProducts[indexChild] = childWrapper;
                component.set("v.pro", responseWrapper);
            }else{
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