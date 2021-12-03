({
    activateProduct : function(component, event, helper) {
        var action = component.get("c.checkProduct");
        action.setParams({
            productId : component.get("v.productId")    
        });        
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var productCheck = response.getReturnValue();
            console.log('productCheck:::'+productCheck);
            if(productCheck != 'No Error'){
                component.set("v.message",productCheck);
                document.getElementById("activateProduct").style.display = "block";
                component.set("v.HideSpinner", false);
            }    
            else{
                helper.activateThisProduct(component, event, helper);
            }       
        });  
        
        
        $A.enqueueAction(action); 
    },
    activateThisProduct : function(component, event, helper) {
        var action = component.get("c.activateProduct");
        action.setParams({
            productId : component.get("v.productId")    
        });        
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                 if(errorMessage == "NoError"){
                     var Get_getUITheme = component.get("v.getUITheme");
                     //if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
                      //      sforce.one.navigateToSObject(component.get("v.AccountId"), "related"); 
                     //}else{
                         window.location.href='/'+ component.get("v.productId");
                     //}
                      
                 }else{
                    // component.set("v.HideSpinner", false);
                    //$('html, body').animate({'scrollTop' : $("#billingAccount").position().top});
                     document.getElementById("activateProduct").style.display = "block";
                 }
             }else if(state === "ERROR" ){
                 component.set("v.HideSpinner", false);
                 var errors = response.getError();
             }   
        });  
                            
        
        $A.enqueueAction(action); 
    } 
})