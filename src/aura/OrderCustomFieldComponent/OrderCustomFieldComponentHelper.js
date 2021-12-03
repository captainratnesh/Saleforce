({
	 getCustomField : function(component, event, helper) {
        var action = component.get("c.getOrderCustomField");        
        action.setParams({
            oppId : component.get("v.oppId")
        });
        action.setCallback(this, function(response){
                           var state = response.getState();
                           if(state === 'SUCCESS'){
                               var custmFieldList = response.getReturnValue();
                               if(custmFieldList!=null && custmFieldList!=''){
                                component.set("v.customValueList", custmFieldList);
                               }
                               else{
                                component.set("v.isShow",false);
                                component.set("v.message",'No order Custom field available for Configuration.');
                                document.getElementById("showErrorOrderCustomField").style.display = "block";
                               }
                           }else if(state === 'ERROR'){
                        	    var errors = response.getError();
                            	if(errors[0] && errors[0].message){
					                component.set("v.message", errors[0].message);
					                document.getElementById("showErrorOrderCustomField").style.display = "block";
				                }else if(errors[0] && errors[0].pageErrors){
				                	component.set("v.message", errors[0].pageErrors[0].message);
					                document.getElementById("showErrorOrderCustomField").style.display = "block";
				                }
                           }
                       });  
                            
        
        $A.enqueueAction(action); 
    },
    saveCustomField : function(component, event, helper) { 
        var action = component.get("c.saveOrderCustomField");        
        action.setParams({
            customFildWrapper :JSON.stringify(component.get("v.customValueList")),
            oppId : component.get("v.oppId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.destroy();
                /*
            	document.getElementById("orderCustomField").style.display = "none";
            	document.getElementById("orderCustomFieldBackground").style.display = "none";*/
            }else if(state === 'ERROR'){
        	    var errors = response.getError();
            	if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorOrderCustomField").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
	                document.getElementById("showErrorOrderCustomField").style.display = "block";
                }
           }
        });  
        
        
        $A.enqueueAction(action);
    }
})