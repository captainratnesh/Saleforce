({
    closeModalBox: function(component, event, helper) {

        document.getElementById("prodActivityChargeModal").style.display = "none";
        document.getElementById("prodBackGroundActivityCharge").style.display = "none";
        document.getElementById("showErrorChargeRule").style.display = "none";

    },
    handleConfigureChargeRuleAction: function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var oppId = event.getParam("oppId");
        component.set("v.oppId", oppId);
        component.set("v.productWrapper", productWrapper);
        document.getElementById("showErrorChargeRule").style.display = "none";
        helper.showActivityCharge(component);
    },
    AddActivityCharge: function(component, event, helper) {
        /*document.getElementById("prodActivityChargeModal").style.display = "none";
        document.getElementById("prodBackGroundActivityCharge").style.display = "none";*/ 
         $A.createComponent(
            "c:AddChargeRuleProduct", 
            {
                "productWrapper": component.get("v.productWrapper"),  
                 "oppId": component.get("v.oppId")
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
        /*var appEvent = $A.get("e.c:AddChargeRuleProductEvent");
        appEvent.setParams({
            "productWrapper": component.get("v.productWrapper"),
            "oppId": component.get("v.oppId")
        });
        appEvent.fire();

        document.getElementById("prodAddActivityChargeModal").style.display = "block";
        document.getElementById("prodBackGroundAddActivityCharge").style.display = "block";*/

    },
    removeChargeRule: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countdelete;
        helper.deleteAndRemoveChargeRule(component, event, count);
    }
})