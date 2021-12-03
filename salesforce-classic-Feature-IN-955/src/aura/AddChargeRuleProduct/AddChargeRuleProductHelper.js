({
    getChargeRules : function(component, event, helper) {
        var action = component.get("c.getChargeRulesWrapper");        
        action.setCallback(this, function(response){
            var state = response.getState();           
            if(state === "SUCCESS"){
                var chargeRuleWrapper = response.getReturnValue();
                component.set("v.chargeRuleWrapper", chargeRuleWrapper); 
             } 
        });  
        $A.enqueueAction(action);
    },
    saveAddChargeRules : function(component, event, helper) {
        var action = component.get("c.createNewActivityChargeRule");        
        action.setParams({
            serviceWrapperString :JSON.stringify(component.get("v.chargeRuleWrapper")),
            activityProductEid :component.get("v.ProductEid"),
            checkRuleTypeValue :component.get("v.RuleType"),
            oppId : component.get("v.oppId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();           
            if(state === "SUCCESS"){
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                var errors = component.get("v.message");
                 if(errors == "NoError"){
                    var wrapperObj = component.get("v.productWrapper");
                     var appEvent = $A.get("e.c:ConfigureChargeRuleAction");                       
                    appEvent.setParams({
			            "productWrapper": wrapperObj,
			                 "oppId"	: component.get("v.oppId")
			            
			        });
			        appEvent.fire();
                    component.destroy();
                    /*document.getElementById("prodAddActivityChargeModal").style.display = "none";
                    document.getElementById("prodBackGroundAddActivityCharge").style.display = "none";*/
                 }else{
                     document.getElementById("showErrorrAddActivityProduct").style.display = "block";
                 }
             }else if(state === "ERROR" ){
                 var errors = response.getError();
                 if(errors[0] && errors[0].pageErrors)
                    component.set("v.message", errors[0].pageErrors[0].message);
              }
        });  
        $A.enqueueAction(action);
    }
})