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
                this.setPriceCurrency(component, event,responseWrapper);
            } else {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    this.sendErrorMessageToParent(component, event, errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    this.sendErrorMessageToParent(component, event, errors[0].pageErrors[0].message);
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
                component.set("v.childProd", responseWrapper);
                this.sendUpdatedChildProductToParent(component,event);
            }else{
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    this.sendErrorMessageToParent(component, event, errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    this.sendErrorMessageToParent(component, event, errors[0].pageErrors[0].message);
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
                component.set("v.childProd", responseWrapper);
                this.sendUpdatedChildProductToParent(component,event);
            }else{
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    this.sendErrorMessageToParent(component, event, errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    this.sendErrorMessageToParent(component, event, errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });  
        $A.enqueueAction(action);
    },

    sendUpdatedChildProductToParent : function(component, event){
        var evt =  component.getEvent("AddChildProductEvent");
        evt.setParams({ "childProductWrapperObj": component.get("v.childProd")});
        evt.fire();
    },

    sendErrorMessageToParent : function(component, event, message){
        var evt =  component.getEvent("ShowErrorEvent");
        evt.setParams({ "errorMessage": message});
        evt.fire();
    }
})