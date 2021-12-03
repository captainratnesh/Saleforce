({
    getProductDetail : function(component, event, productList, oppId){
        var action = component.get("c.getProductDetailLists");        
        action.setParams({
            productList : productList,
            OpportunityId : oppId
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var listOfProducts = response.getReturnValue();
                var addedProductWrapper = component.get("v.addedProductWrapper");
                var productWrapper = component.get("v.productWrapper");
                addedProductWrapper.push.apply(addedProductWrapper, listOfProducts);
                component.set("v.addedProductWrapper", addedProductWrapper);
            }
            else{
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
    createSalesOrder : function(component, event, helper, productList, oppId,childProdList){
        for(var i in childProdList){
                    var quantity;
                    if(childProdList[i].quantity != undefined){
                        quantity = JSON.stringify(childProdList[i].quantity);
                    }
                    var name;
                    if(childProdList[i].prod != undefined && childProdList[i].prod.Name != undefined){
                        name = JSON.stringify(childProdList[i].prod.Name);
                    }
                    if(isNaN(childProdList[i].quantity) && quantity != null && quantity != ""){
                        component.set("v.message",'Please provide a valid quantity for product '+name);
                        document.getElementById("showErrorProductCart").style.display = "block";
                        return;
                    }
                    else if(quantity == null || quantity == ""){
                        component.set("v.message",'Quantity cannot be null for product '+name);
                        document.getElementById("showErrorProductCart").style.display = "block";
                        return;
                    }
                //}
            //}
        }
        var action = component.get("c.createSalesOrderApex");        
        action.setParams({
            productWrapperString        : JSON.stringify(productList),
            OpportunityId               : oppId,
            childProductWrapperString   : JSON.stringify(childProdList)
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var proList = response.getReturnValue();
                if(proList.errorMessage == "NoError"){
                    var Get_getUITheme = component.get("v.getUITheme");
                    if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
                        sforce.one.navigateToSObject(oppId); 
                    }else{
                        window.location.href='/'+ oppId;
                    }
                }else{
                    component.set("v.message",proList.errorMessage);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }else if(state === "ERROR" ){
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