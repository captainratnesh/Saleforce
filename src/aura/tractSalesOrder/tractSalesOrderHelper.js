({
	idMethod : function(component,event,helper) {
        var oppIDnew=component.get("v.oppId");
	    var action=component.get("c.salesOrderList");
        action.setParams({
            oppId:component.get("v.oppId")

        });
        action.setCallback(this, function(response){
                           var state = response.getState();
            			   var productList = response.getReturnValue();
            			   component.set("v.salesOrder", productList);
            			   component.set("v.HideSpinner", false);
            			   //component.set("v.HideSpinner", false);
            				//alert(JSON.stringify(response.getReturnValue()));
                           });                                      
        $A.enqueueAction(action);
        
	},
	
	getOpportunityProductCount : function(component, event){
		/*var action = component.get("c.getOpportunityProductCount");
		
		action.setParams({
							opptyId : component.get("v.oppId")
						});
		
		action.setCallback(this, function(response){
			var state = response.getState();
			if(state === 'SUCCESS'){
				var productCount = response.getReturnValue();
				alert('The number of products on this opportunity is : '+productCount);
			}
		});
		$A.enqueueAction(action);*/
	}
})