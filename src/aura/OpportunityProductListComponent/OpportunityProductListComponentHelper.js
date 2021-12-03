({
	getProductList : function(component, event, helper,  oppId) {
        var action = component.get("c.getAllProductList");        
        action.setParams({
            opportunityId : oppId
        });
        action.setCallback(this, function(response){
                           var state = response.getState();
                           var productList = response.getReturnValue();
                            if(productList.errorMessage == "NoBillingAccount"){
                               component.set("v.message", "No BillingAccount is selected for this Opportunity. Please select a BillingAccount first.");
                               document.getElementById("showError").style.display = "block";
                               var spinner = component.find("mySpinner");
                               $A.util.toggleClass(spinner, "slds-hide");
                           } else
                               if(productList.errorMessage == "OrderCreated"){
                               component.set("v.message", "This opportunity has already been moved in Tract");
                               document.getElementById("showError").style.display = "block";
                               var spinner = component.find("mySpinner");
                               $A.util.toggleClass(spinner, "slds-hide");
                           }
                           else{
                                
                               this.createSalesOrder(component, event, helper, oppId); 
                           }
                            
                           });  
        $A.enqueueAction(action);
    },
     createSalesOrder : function(component, event, helper,  oppId){
        var action = component.get("c.createOrderApex");        
        action.setParams({
            opportunityId : oppId
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var error = response.getReturnValue();
                 if(error == "NoError"){
                     var Get_getUITheme = component.get("v.getUITheme");
                     if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
                            sforce.one.navigateToSObject(oppId, 'detail'); 
                     }else{
                         window.location.href='/'+ oppId;
                     }
                 }else{
                        component.set("v.message", error);
                        document.getElementById("showError").style.display = "block";
                        var spinner = component.find("mySpinner");
                        $A.util.toggleClass(spinner, "slds-hide");
                 }
             }else if(state === "ERROR" ){
                 var errors = response.getError();
                 if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showError").style.display = "block";
                    var spinner = component.find("mySpinner");
                    $A.util.toggleClass(spinner, "slds-hide");
                 }else if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showError").style.display = "block";
	                var spinner = component.find("mySpinner");
                    $A.util.toggleClass(spinner, "slds-hide");
                }
              }            
        });  
        $A.enqueueAction(action);
    },
    removeOppProduct : function(component, event, helper,  oppProduct, oppId) {
        var action = component.get("c.removeOppProductApex");        
        action.setParams({
            oppProduct : oppProduct,
            opportunityId : oppId
        });
        
        action.setCallback(this, function(response){
                           var state = response.getState();
                           if(state === 'SUCCESS'){
	                           var productList = response.getReturnValue();
	                           component.set("v.oppProLists", productList);
                           }else if(state === "ERROR" ){
			                 var errors = response.getError();
			                 if(errors[0] && errors[0].pageErrors){
			                    component.set("v.message", errors[0].pageErrors[0].message);
			                    document.getElementById("showError").style.display = "block";
			                 }else if(errors[0] && errors[0].message){
				                component.set("v.message", errors[0].message);
				                document.getElementById("showError").style.display = "block";
			                }
			              }
                       });  
        $A.enqueueAction(action);
    }
})