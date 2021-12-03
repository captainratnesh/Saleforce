({
    getProductWrapper : function(component, event, helper){
        var action = component.get("c.getProductDetails");        
        action.setParams({
            selectedProduct : component.get("v.selectedProduct"),
            opportunityId : component.get("v.opportunityId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var selectedProductWrapper = response.getReturnValue();
                component.set("v.productWrapper", selectedProductWrapper);
            }else if(state === "ERROR" ){
                var errors = response.getError();
                console.log('errors::::::'+JSON.stringify(errors));
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorconfigureProduct").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorconfigureProduct").style.display = "block";
                }
            }
        });  
        $A.enqueueAction(action);
    },

    getProductPrices : function(component,event, helper){
        var productWrapper = component.get("v.productWrapper");
        var action = component.get("c.getProductPricesInformation");        
        action.setParams({
            productWrapperString : JSON.stringify(productWrapper)
        })
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var selectedProductWrapper = response.getReturnValue();
                component.set("v.productWrapper", selectedProductWrapper);
            }else if(state === 'ERROR'){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorconfigureProduct").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorconfigureProduct").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    returnUnitPrice: function(recurringPrice,oneTimePrice) {
            if(recurringPrice!=null && oneTimePrice!=null){
                return (eval(recurringPrice)+eval(oneTimePrice));
            }
            else if(recurringPrice == null && oneTimePrice != null){
                return eval(oneTimePrice);
            }else if(recurringPrice != null && oneTimePrice == null){
                return eval(recurringPrice);
            }   
    }
})