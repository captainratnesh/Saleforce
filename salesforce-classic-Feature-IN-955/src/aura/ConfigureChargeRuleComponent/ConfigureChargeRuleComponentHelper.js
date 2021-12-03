({
    showActivityCharge : function(component){
        var proEid = component.get("v.productWrapper").productEid;
        var action = component.get("c.showActivityChargeRule");        
        action.setParams({
            activityProductEid   : proEid,
            oppId				 : component.get("v.oppId")
        });
        action.setCallback(this, function(response){
             var state = response.getState();
             if(state === 'SUCCESS'){
        	 	var ActivtyChargeWrapper = response.getReturnValue();
        	 	component.set("v.activityChargeWrapper", ActivtyChargeWrapper);
             }else if(state === 'ERROR'){
            	var errors = response.getError();;
                if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
                	document.getElementById("showErrorChargeRule").style.display = "block";
                }else if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorChargeRule").style.display = "block";
                }
             }
        });  
        $A.enqueueAction(action);
    },
    deleteAndRemoveChargeRule : function(component, event, index){
	    var chargeRuleIdtoDelete = component.get("v.activityChargeWrapper["+index+"]").recordId;
	    var action = component.get("c.deleteChargeRule");
	    action.setParams({
            chargeId   : chargeRuleIdtoDelete
        });
        action.setCallback(this, function(response){
             var state = response.getState();
             if(state == 'SUCCESS'){
                 var chargeRules = component.get("v.activityChargeWrapper");
            	 chargeRules.splice(index, 1);
        	 	 component.set("v.activityChargeWrapper", chargeRules);
             }else if(state === 'ERROR'){
            	 var errors = response.getError();;
                if(errors[0] && errors[0].pageErrors){
                	component.set("v.message", errors[0].pageErrors[0].message);
                	document.getElementById("showErrorChargeRule").style.display = "block";
                }else if(errors[0] && errors[0].message){
	                component.set("v.message", errors[0].message);
	                document.getElementById("showErrorChargeRule").style.display = "block";
                }
             }
        });  
        $A.enqueueAction(action);
    }
})