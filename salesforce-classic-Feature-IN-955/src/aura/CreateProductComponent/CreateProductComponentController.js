({
    doinit: function(component, event, helper) {
        helper.getProductWrapper(component, event, helper);
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    onProductTypeSelect: function(component, event, helper) {
        var createProductWrapper = component.get("v.CreateProductWrapper");
        if (createProductWrapper.productType == 'add-on' || createProductWrapper.productType == 'customer-subscription' || createProductWrapper.productType == 'ADDON' || createProductWrapper.productType == 'SUBSCRIPTION') {
            createProductWrapper.fundPrepaidBalance = false;
            component.set("v.CreateProductWrapper",createProductWrapper);            
        } else if(createProductWrapper.productType == 'general' || createProductWrapper.productType == 'GENERAL_PRODUCT'){
            createProductWrapper.consumePrepaidBalance = false;
            createProductWrapper.agreementMandatory = false;
            createProductWrapper.ruleOverride = false;
            createProductWrapper.ruleMode = 'APPEND';
            createProductWrapper.ruleType = 'TAPERED';
            createProductWrapper.ruleOverride = false;
            createProductWrapper.identifierCategory = '';
            createProductWrapper.minimumIdentifiers = 0;
            createProductWrapper.maximumIdentifiers = 0;
            component.set("v.CreateProductWrapper",createProductWrapper);            
        }
    },

    saveProduct: function(component, event, helper) {
        helper.createProductInGTV(component, event, helper);
    },
    closeComponent: function(component, event, helper) {
        window.location.href='/'+  component.get("v.productId");
    }
})