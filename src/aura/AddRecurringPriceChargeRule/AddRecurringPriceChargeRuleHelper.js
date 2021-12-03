({
	showChargeRuleModel : function(component, event, helper) {
        var action = component.get("c.showChargeRuleModel");        
        action.setCallback(this, function(response){
            var state = response.getState();
            var chargeRuleWrap = response.getReturnValue();
            console.log('chargeRuleWrap:::'+JSON.stringify(chargeRuleWrap));
            component.set("v.chargeRuleWrapper", chargeRuleWrap);
        });  
        $A.enqueueAction(action);
	},
    addChargeRulesHelper:function(component, event, helper) {
        var action = component.get("c.addChargerules");
        action.setParams({
            productEid: component.get("v.selectedPrice").productEid,    
            recurringPriceId : component.get("v.selectedPrice").eid,
            chargeRuleWrapper : JSON.stringify(component.get("v.chargeRuleWrapper"))
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state === 'SUCCESS'){
                var response = response.getReturnValue();
                console.log('response:::'+response);
                if(response !== 'NoError'){
               		 component.set('v.message',response);
                     document.getElementById("showErrorrAddActivity").style.display = "block";
                }
                else{
                    var appEvent = $A.get("e.c:HandleProductChargeRuleEvent");
                    
                    appEvent.fire();    
                    console.log('response:::'+response);
                    component.destroy();
                }
            }
            else{
                
            }
        });  
        $A.enqueueAction(action);
    }
})