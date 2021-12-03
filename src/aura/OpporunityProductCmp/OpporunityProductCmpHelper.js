({
	getProductList : function(component, event, helper,  oppId) {
        var action = component.get("c.getProductLists");        
        action.setParams({
            opportunityId : oppId
        });
        
        action.setCallback(this, function(response){
                            var state = response.getState();
                            if(state === 'SUCCESS'){
                            	var productList = response.getReturnValue();
	                            if(productList.errorMessage == "NoBillingAccount"){
	                               component.set("v.disableProduct", true);
	                               component.set("v.disablePrev", true); 
	                               component.set("v.disableFirst", true); 
	                               component.set("v.disableNext", true);
	                               component.set("v.disableLast", true);
	                               component.set("v.message", "No BillingAccount is  selected for this Opportunity. Please select a BillingAccount first.");
	                               document.getElementById("showErrorProductList").style.display = "block";
	                           }else if(productList.errorMessage == "NoCurrencyType"){
	                               component.set("v.disableProduct", true);
	                               component.set("v.disablePrev", true); 
	                               component.set("v.disableFirst", true); 
	                               component.set("v.disableNext", true);
	                               component.set("v.disableLast", true);
	                               component.set("v.message", "The Billing Account associated with this Opportunity is not available in TRACT.");
	                               document.getElementById("showErrorProductList").style.display = "block";
	                           }else if(productList.errorMessage == "NoPriceBook"){
	                               component.set("v.disableProduct", true);
	                               component.set("v.disablePrev", true); 
	                               component.set("v.disableFirst", true); 
	                               component.set("v.disableNext", true);
	                               component.set("v.disableLast", true);
	                               component.set("v.message", "No Price book is selected for this Opportunity. Please select a Price book first.");
	                               document.getElementById("showErrorProductList").style.display = "block";
	                           }else if(productList.errorMessage == "OrderCreated"){
	                               component.set("v.disableProduct", true);
	                               component.set("v.disablePrev", true); 
	                               component.set("v.disableFirst", true); 
	                               component.set("v.disableNext", true);
	                               component.set("v.disableLast", true);
	                               component.set("v.message", "This opportunity has already been moved in Tract");
	                               document.getElementById("showErrorProductList").style.display = "block";
	                           }else{
	                               component.set("v.oppProLists", productList.product2WrapperList);
	                               this.startProducts(component, event, helper); 
	                           }
                            }else if(state === 'ERROR'){
                            	var errors = response.getError();
                            	if(errors[0] && errors[0].message){
					                component.set("v.message", errors[0].message);
					                document.getElementById("showErrorProductList").style.display = "block";
				                }else if(errors[0] && errors[0].pageErrors){
				                	component.set("v.message", errors[0].pageErrors[0].message);
					                document.getElementById("showErrorProductList").style.display = "block";
				                }
                            }
	                            
                       });  
        $A.enqueueAction(action);
    },
    startProducts : function(component, event, helper) {
        var oppProLists = component.get("v.oppProLists");
        var totelProduct = oppProLists.length;
        var totelPage = Math.ceil(totelProduct / 10);
        var productListMap = component.get("v.productListMap");
        var currentLocation = 0;
        for(var i=1; i<=totelPage; i++){
        var proList = [];
        var count = 0;
        var displayLocation = (currentLocation + 10) >= totelProduct ?  totelProduct :  (currentLocation + 10) ;
        for(var j=currentLocation ; j<displayLocation; j++ ){
            proList[count++] = oppProLists[j];
        }
        currentLocation =  displayLocation;
        productListMap[i] = proList;
        }
        component.set("v.productListMap", productListMap);
        component.set("v.totelPage", totelPage);
        var currentPage = component.get("v.currentPage");
        component.set("v.oppProList", productListMap[currentPage]);
        if(totelPage == 1){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
    }
})