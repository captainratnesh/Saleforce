({
    doInit : function(component, event, helper) {
        helper.queryProductChargeRule(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    waiting: function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting: function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    editRecurringPrice:function(component, event, helper) {
     	$A.createComponent(
            "c:CreateRecurringChargePriceComponent", 
            {
                "productId":component.get("v.productId"),
                "selectedPrice": component.get("v.selectedPrice")
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );   
    },
    addActivityChargeRule:function(component, event, helper) {
        
        $A.createComponent(
            "c:AddRecurringPriceChargeRule", 
            {
                "productId":component.get("v.productId"),
                "selectedPrice": component.get("v.selectedPrice")
            },   
            function(newComponent, status, errorMessage){
                console.log('errorMessage::::::'+errorMessage);
                console.log('status::::::'+status);
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );  
    },
    handleActivityChargeEvent:function(component, event, helper) {
        console.log('response:::I am Here ');
        helper.queryProductChargeRule(component, event, helper);
    }
    
})