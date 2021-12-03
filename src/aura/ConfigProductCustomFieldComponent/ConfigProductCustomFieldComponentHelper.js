({
    getCustomField : function(component, event, helper) {
		var productCustFieldList = component.get("v.productCustomFieldList");
		var eidVsproductCustomFieldInstance = new Map();
		if(productCustFieldList.length != 0){
			for(var i in productCustFieldList){
				eidVsproductCustomFieldInstance.set(productCustFieldList[i].eid, productCustFieldList[i].value);
			}
		}
        component.set("v.productCustomFieldList", '');
        component.set("v.isShow",true);
        component.set("v.message",'');
        var action = component.get("c.getproductCustomFieldsList");
        action.setParams({
            productId : component.get("v.productEid")
        });        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var custmFieldList = response.getReturnValue();
                console.log('custmFieldList::::::'+JSON.stringify(custmFieldList));
	            if(custmFieldList!=null && custmFieldList!=''){
					for(var i in custmFieldList){
						if(eidVsproductCustomFieldInstance.has(custmFieldList[i].eid)){
							if(eidVsproductCustomFieldInstance.get(custmFieldList[i].eid) != undefined && eidVsproductCustomFieldInstance.get(custmFieldList[i].eid) != ''){
								custmFieldList[i].value = eidVsproductCustomFieldInstance.get(custmFieldList[i].eid)
							}
						}
					}
	                component.set("v.canEdit",true);
	                component.set("v.productCustomFieldList", custmFieldList);
	            }
	            else{
	                component.set("v.canEdit",false);
	                component.set("v.isShow",false);
	                component.set("v.message",'No more custom fields available for configuration.')
	            }
            }else{
            	component.set("v.isShow",false);
				var errors = response.getError();
				if(errors[0] && errors[0].pageErrors){
					component.set("v.message", errors[0].pageErrors[0].message);
				}
				else if(errors[0] && errors[0].message){
					component.set("v.message", errors[0].message);
				}
              
            }                      
        });  
        $A.enqueueAction(action);
    },
    saveCustomField : function(component, event, helper) {
		var action = component.get("c.saveProductCustomFieldValues");
        action.setParams({
            customFildWrapper :JSON.stringify(component.get("v.productCustomFieldList")),
            productEid : component.get("v.productEid")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
             var response = response.getReturnValue();
            if(state === 'SUCCESS'){
            	if(response === 'No error'){
					window.location.href='/'+  component.get("v.productId");
            	}
            	else{ 
					helper.getCustomField(component, event, helper);
            		component.set("v.validationError",true);
                	component.set("v.message", response);
            	}
	             
            }
            else if(state === 'ERROR'){
            	component.set("v.isShow",false);
        	    var errors = response.getError();
            	if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                component.set("v.validationError",true);
                }else if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].message);
                	component.set("v.validationError",true);
                }
            }
        });  
        $A.enqueueAction(action);
    }
    
    
})