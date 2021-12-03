({
    
    checkTractAccount : function(component, event, helper) {
        var action = component.get("c.checkBilingAccount");
        action.setParams({
            accountId : component.get("v.AccountId")    
        });        
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var bilingAccount = response.getReturnValue();
            if(bilingAccount.TRACT3__Tract_Billing_Account__c != undefined && bilingAccount.TRACT3__Tract_Billing_Account__c != null){
                component.set("v.thisAccount", bilingAccount);
                document.getElementById("createdTractAccount").style.display = "block";
                component.set("v.HideSpinner", false);
            }else{
                helper.getBiilingAccount(component, event, helper);
            }
        });  
        
        
        $A.enqueueAction(action); 
    },
   getBiilingAccount : function(component, event, helper) {
        var action = component.get("c.saveAccount");
        action.setParams({
            accountId : component.get("v.AccountId")    
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
                         window.location.href='/'+ component.get("v.AccountId");
                     //}
                      
                 }else{
                    // component.set("v.HideSpinner", false);
                    //$('html, body').animate({'scrollTop' : $("#billingAccount").position().top});
                     document.getElementById("createdTractAccount1").style.display = "block";
                 }
             }else if(state === "ERROR" ){
                 component.set("v.HideSpinner", false);
                 var errors = response.getError();
             }   
        });  
                            
        
        $A.enqueueAction(action); 
    } 
})