({
    checkExistingOrder: function(component, event, helper) {
       // var oppId = component.get("v.recordId");
       // console.log('oppId:::::;'+oppId);
        var action = component.get("c.checkExistingOrder");
        action.setParams({
            OpportunityId: component.get("v.recordId")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            var message = response.getReturnValue();
            if (message != '') {
                component.set("v.message", message);
                document.getElementById("showError").style.display = "block";
            } else {
                this.checkExistingCustomer(component, event, helper);
            }
        });
        $A.enqueueAction(action);
    },

    checkExistingCustomer: function(component, event, helper) {
        var oppId = component.get("v.recordId");
        var action = component.get("c.checkExistingCustomer");
        action.setParams({
            OpportunityId: oppId
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            var isExisting = response.getReturnValue();
            if (isExisting) {
                helper.createOpporunityProductCmpExisting(component, event, helper);
            } else {
                helper.createOpporunityProductCmp(component, event, helper);
            }

        });
        $A.enqueueAction(action);
    },
    createOpporunityProductCmp: function(component, event, helper) {
        var oppId = component.get("v.recordId");
        $A.createComponent(
            "c:SimpleAddProductComponent", {
                "oppId": oppId
            },
            function(newCmp) {
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
        );
    },
    createOpporunityProductCmpExisting: function(component, event, helper) {
        var oppId = component.get("v.recordId");
        $A.createComponent(
            "c:SimpleAddProductComponentExisting", {
                "oppId": oppId
            },
            function(newCmp) {
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
        );
    },
})