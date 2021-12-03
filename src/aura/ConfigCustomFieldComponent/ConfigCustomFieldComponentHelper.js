({
    getCustomField : function(component, event, helper, proId, configuredValuesString) {
		component.set("v.customValueList", '');
		component.set("v.isShow",true);
		component.set("v.message",'');
        var action = component.get("c.getServiceCustomField");        
        action.setParams({
            selectedProductEid 				: proId,
            serviceCustomFieldValueString	: configuredValuesString
        });
        action.setCallback(this, function(response){
                           var state = response.getState();
                           if(state === 'SUCCESS'){
                        	   var custmFieldList = response.getReturnValue();
	                           if(custmFieldList!=null && custmFieldList!=''){
	                        	   component.set("v.customValueList", custmFieldList);
        	   	                   component.set("v.canEdit",true);
   	                       		   component.set("v.validationError",false);
	                           }
	                           else{
                   	               component.set("v.canEdit",false);
	                        	   component.set("v.isShow",false);
                	       		   component.set("v.validationError",false);
	                        	   component.set("v.message",'No service custom fields applicable on this product')
	                           }
                           }else if(state === 'ERROR'){
                        	    component.set("v.isShow",false);
                        	    var errors = response.getError();
				            	if(errors[0] && errors[0].message){
					                component.set("v.message", errors[0].message);
				                }else if(errors[0] && errors[0].pageErrors){
				                	component.set("v.message", errors[0].pageErrors[0].message);
				                }
			                }
                       });  
        $A.enqueueAction(action);
    }
})