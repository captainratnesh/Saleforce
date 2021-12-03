({
    getOliId : function(component, event, helper) {
        var action = component.get("c.getOliId");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') { 
               var OliId = response.getReturnValue();  
                console.log('OliId::::::'+OliId);
               component.set("v.OLIId",OliId);
               helper.getOliData(component, event, helper);
            }
        });    
        $A.enqueueAction(action);
        
    },
    
    getOliData : function(component, event, helper) {
        var action = component.get("c.getOliDetails");
        action.setParams({
            oliId: component.get("v.OLIId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state::::'+state);
            if (state === 'SUCCESS') {
                var productWrap = response.getReturnValue();
                component.set("v.productWrapper",productWrap);
                component.set("v.oppId",productWrap.oppId);
                component.set("v.usageWrapList",productWrap.usageWrapList);
                console.log('productWrapper::::'+JSON.stringify(component.get("v.productWrapper")));
                console.log('usageList:::::::::;'+JSON.stringify(component.get("v.usageWrapList")));
                
            } else if (state === 'ERROR') {
            }
        });    
        $A.enqueueAction(action);
    },
    saveOLiData : function(component, event, helper) {
        var action = component.get("c.saveOLiDetails");
        action.setParams({
            productWrapString: JSON.stringify(component.get("v.productWrapper")),
            oliId : component.get("v.OLIId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state::::'+state);
            if (state === 'SUCCESS') { 
                    var Get_getUITheme = component.get("v.getUITheme");
                    window.location.href='/'+ component.get("v.OLIId");
                
            }
        else if (state === 'ERROR') {
        }
        });    
        $A.enqueueAction(action);
    },
    deleteAndRemoveChargeRule : function(component, event, index){
	    var chargeRuleIdtoDelete = component.get("v.usageWrapList["+index+"]").recordId;
	    var action = component.get("c.deleteChargeRule");
	    action.setParams({
            chargeId   : chargeRuleIdtoDelete
        });
        action.setCallback(this, function(response){
             var state = response.getState();
             if(state == 'SUCCESS'){
                 var chargeRules = component.get("v.usageWrapList");
            	 chargeRules.splice(index, 1);
        	 	 component.set("v.usageWrapList", chargeRules);
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