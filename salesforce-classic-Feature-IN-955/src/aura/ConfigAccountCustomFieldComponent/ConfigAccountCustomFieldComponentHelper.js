({
    getCustomField : function(component, event, helper) {
		var tractAccount = component.get("v.tractAccount");
		var accountCustFieldList = component.get("v.customValueList");
		var eidVsAccountCustomFieldInstance = new Map();
		if(accountCustFieldList.length != 0){
			for(var i in accountCustFieldList){
				eidVsAccountCustomFieldInstance.set(accountCustFieldList[i].eid, accountCustFieldList[i].value);
			}
		}
        component.set("v.customValueList", '');
        component.set("v.isShow",true);
        component.set("v.message",'');
        var action = component.get("c.getAccountCustomFieldsList");
        action.setParams({
            accountString : JSON.stringify(tractAccount)
        });        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
            	var custmFieldList = response.getReturnValue();
	            if(custmFieldList!=null && custmFieldList!=''){
					for(var i in custmFieldList){
						if(eidVsAccountCustomFieldInstance.has(custmFieldList[i].eid)){
							if(eidVsAccountCustomFieldInstance.get(custmFieldList[i].eid) != undefined && eidVsAccountCustomFieldInstance.get(custmFieldList[i].eid) != ''){
								custmFieldList[i].value = eidVsAccountCustomFieldInstance.get(custmFieldList[i].eid)
							}
						}
					}
	                component.set("v.canEdit",true);
	                component.set("v.customValueList", custmFieldList);
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
    	var tractAccount = component.get("v.tractAccount");
		var action = component.get("c.saveAccountCustomField");
        action.setParams({
            customFildWrapper :JSON.stringify(component.get("v.customValueList")),
            accountString : JSON.stringify(tractAccount)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
             var response = response.getReturnValue();
            if(state === 'SUCCESS'){
            	if(response === 'No error'){
		            var appEvent = $A.get("e.c:ReloadAccountDetail");
					appEvent.fire();
					component.destroy();
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