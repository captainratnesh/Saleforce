({
    getProductEid : function(component, event, helper) {
        var action = component.get("c.getProductId");        
        action.setParams({
            productId : component.get("v.productId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var thisProduct = response.getReturnValue();
            if(thisProduct.ProductCode == 'OneTime' || thisProduct.ProductCode == 'ONE-TIME'){
                component.set("v.isOneTimeProduct", true);
            }
            else{
                component.set("v.isOneTimeProduct", false);
            }
            if(thisProduct.TRACT3__eid__c != '' && thisProduct.TRACT3__eid__c != null){
                component.set("v.hasProductEid", true);
                component.set("v.productEid", thisProduct.TRACT3__eid__c);
                helper.ListOfDiscountCode(component, event, helper);
                helper.getListOfProductCustomFieldValues(component, event, helper);
                helper.getProductRelationWrapperList(component, event, helper);
            }
            else{
                component.set("v.hasProductEid", false);
            }
            console.log('hasProductEid:::::'+component.get("v.hasProductEid"));
        });  
        $A.enqueueAction(action);
    },
    getAPIVersion : function(component, event, helper) {
        var action = component.get("c.getAPIVersion");        
        action.setCallback(this, function(response){
            var state = response.getState();
            var getVersion = response.getReturnValue();
            component.set("v.versionAPI", getVersion);
        });  
        $A.enqueueAction(action);
    },
	ListOfOneTimeProductPrice : function(component, event, helper) {
        var action = component.get("c.getOneTimeProductPrices");        
        action.setParams({
            productId : component.get("v.productId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var oneTimeProductPriceList = response.getReturnValue();
            component.set("v.oneTimeProductPriceList", oneTimeProductPriceList);
        });  
        $A.enqueueAction(action);
    },
    
	ListOfRecurringProductPrice : function(component, event, helper) {
        var action = component.get("c.getRecurringProductPrices");        
        action.setParams({
            productId : component.get("v.productId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var recurringProductPriceList = response.getReturnValue();
            component.set("v.recurringProductPriceList", recurringProductPriceList);
        });  
        $A.enqueueAction(action);
    },
    
    ListOfAgreement : function(component, event, helper) {
        var action = component.get("c.getAgreements");        
        action.setParams({
            productId : component.get("v.productId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var agreementList = response.getReturnValue();
            component.set("v.agreementList", agreementList);
        });  
        
        
        $A.enqueueAction(action);
    },
    
    ListOfDiscountCode : function(component, event, helper) {
        var action = component.get("c.getDiscountCode");        
        action.setParams({
            productId : component.get("v.productId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var discountCodeList = response.getReturnValue();
            component.set("v.discountCodeList", discountCodeList);
        });  
        
        
        $A.enqueueAction(action);
    },
    removeAgreementRelation:function(component, event, helper,currentAgre) {
        var action = component.get("c.deleteProductAgreementRelation");        
        action.setParams({
            productId : component.get("v.productId"),
            currentAgreement: JSON.stringify(currentAgre)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
        });  
        $A.enqueueAction(action);
    },

    getListOfProductCustomFieldValues : function(component, event, helper) {
        var action = component.get("c.getproductCustomFieldValueList");        
        action.setParams({
            productEid : component.get("v.productEid")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var productCustomFieldValueList = response.getReturnValue();
            console.log('productCustomFieldValueList::'+JSON.stringify(productCustomFieldValueList));
            component.set("v.productCustomFieldValueWrapperList", productCustomFieldValueList);
        });  
        $A.enqueueAction(action);
    },

    getProductRelationWrapperList : function(component, event, helper) {
        var action = component.get("c.queryProductRelationList");        
        action.setParams({
            productId : component.get("v.productEid")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var productRelationWrapperList = response.getReturnValue();
            console.log('productRelationWrapperList::'+JSON.stringify(productRelationWrapperList));
            component.set("v.productRelationWrapperList", productRelationWrapperList);
        });  
        $A.enqueueAction(action);
    }
    
})