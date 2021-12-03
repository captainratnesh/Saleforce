({
    getDiscount : function(component, event, helper) {
        var action = component.get("c.getDisountCode");        
        action.setParams({
             productWrapperString : JSON.stringify(component.get("v.productWrapper")),
             discountName: component.get("v.discountCode")	
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var proWrap = response.getReturnValue();
                 if(proWrap.errorMessage == "NoError"){
                     var appEvent = $A.get("e.c:ProductDiscountCodeReturnEvent");
                     appEvent.setParams({"productWrapper": proWrap});
                     appEvent.fire();
                     component.destroy(); 
                 }else{
                     component.set("v.message", proWrap.errorMessage);
                     document.getElementById("showErrorDisountCode").style.display = "block";
                 }
             }else if(state === "ERROR" ){
                 var errors = response.getError();
                 if(errors[0] && errors[0].pageErrors)
                    component.set("v.message", errors[0].pageErrors[0].message);
              }
            
        });   
        $A.enqueueAction(action);
    }
})