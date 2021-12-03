({
	 doInit : function(component, event, helper) {
        helper.getAPIVersion(component, event, helper); 
        helper.getProductEid(component, event, helper);
        helper.ListOfOneTimeProductPrice(component, event, helper);
        helper.ListOfRecurringProductPrice(component, event, helper); 
        helper.ListOfAgreement(component, event, helper);
    },
    clickCreateAgreement : function(component, event, helper) {
        $A.createComponent(
            "c:AddAssociatedAgreementCmp", 
            {
                "currentAgreementList" : component.get("v.agreementList"),
                "productId":component.get("v.productId")
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
    jsLoaded:function(component, event, helper) {
        var Get_getUITheme = component.get("v.getUITheme");
        console.log('Get_getUITheme:::'+component.get("v.getUITheme"));
        if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
            
            sforce.one.navigateToSObject(component.get("v.productId"));
        }else{
            window.location.href='/'+ component.get("v.productId");
        }
    },
    deleteAgre:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:ConfirmAgreeementDeletion", 
            {
                "currentAgre" : component.get("v.agreementList[" + count + "]"),
                "productId":component.get("v.productId")
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
        /*console.log('count:::::;'+count);
        var currentAgre = component.get("v.agreementList[" + count + "]");
        console.log('currentAgre:::::;'+JSON.stringify(currentAgre));
        helper.removeAgreementRelation(component, event, helper,currentAgre);*/
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    createRecurringPriceModal : function(component, event, helper) {
        $A.createComponent(
            "c:CreateRecurringChargePriceComponent", 
            {
                "productId":component.get("v.productId")
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
    createOneTimePriceModel : function(component, event, helper) {
        $A.createComponent(
            "c:CreateOneTimeChargePriceComponent", 
            {
                "productId":component.get("v.productId")
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
    showProductCustomFieldConfigurationModal: function(component, event, helper) {
        $A.createComponent(
            "c:ConfigProductCustomFieldComponent", {
                "productId": component.get("v.productId"),
                "productEid": component.get("v.productEid")
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },

    deleteProductRelation:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:ConfirmProductRelationDeletionComponent", 
            {
                "productRelationWrap" : component.get("v.productRelationWrapperList[" + count + "]"),
                "productId":component.get("v.productEid")
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
    showRecurringPriceDetails:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        component.set("v.HideSpinner", false);
        $A.createComponent(
            "c:RecurringPriceDetailComponent", {
                "selectedPrice": component.get("v.recurringProductPriceList[" + count + "]"),
                "productId":component.get("v.productId")
            },
            function(newComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                } else if (status === "INCOMPLETE") {
                    // Show offline error
                } else if (status === "ERROR") {
                    // Show error message
                }
            }
        );
    }
})