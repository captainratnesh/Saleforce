({
   getProductList : function(component, event, helper, product, productWrapperList,productWrapper) {
        var action = component.get("c.getParentServices");        
        action.setParams({
            oppId : component.get("v.oppId"),
            productEid : productWrapper.productEid,
            productWrapperList : JSON.stringify(productWrapperList)
        });
         
        action.setCallback(this, function(response){
                           var state = response.getState();
                           if(state === 'SUCCESS'){
                        	   var productList = response.getReturnValue();
	                           if(productList.length > 0){
	                               component.set("v.parentProductWrapper", productList);
	                           }else{
	                               this.getRelatedProductList(component, event, helper, productWrapper.productEid);
	                               component.set("v.showapplicableServices",false);
	                              /* component.set("v.message", "No related subscription product found on the order. Please add one of the following related products:");
	                               document.getElementById("showErrorService").style.display = "block";*/
	                           }
                           }else if(state === 'ERROR'){
                               var errors = response.getError();
                               if(errors[0] && errors[0].pageErrors){
				                    component.set("v.message", errors[0].pageErrors[0].message);
				                    document.getElementById("showErrorService").style.display = "block";
				          		 }else if(errors[0] && errors[0].message){
					                component.set("v.message", errors[0].message);
					                document.getElementById("showErrorService").style.display = "block";
				                }
                           }
                       });  
        $A.enqueueAction(action);
    },
    
    getRelatedProductList : function(component, event, helper, productEid) {
        var action = component.get("c.getRelatedProductNameList");        
        action.setParams({
            productEid : productEid
        });
         
        action.setCallback(this, function(response){
                           var state = response.getState();
                           if(state === 'SUCCESS'){
                        	   var relatedProductList = response.getReturnValue();
                               component.set("v.relatedProductList", relatedProductList);
                           }
                       });  
        $A.enqueueAction(action);
    }
})