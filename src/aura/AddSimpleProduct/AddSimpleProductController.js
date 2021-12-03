({
    doinit : function(component, event, helper) {
        var getUITheme = component.get("v.getUITheme");
        
        var addedProduct = component.get("v.addedProduct");
        var oppId = component.get("v.oppId");
        helper.getProductDetail(component, event, addedProduct, oppId);
    },
    createOrder : function(component, event, helper) {
        var addedProduct = component.get("v.addedProductWrapper");
        var childProdList = component.get("v.childProductWrapperList");
        var oppId = component.get("v.oppId");
        helper.createSalesOrder(component, event, helper, addedProduct, oppId,childProdList);
    },
    getHomePage : function(component, event, helper) {
        var Get_getUITheme = component.get("v.getUITheme");
        if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
            sforce.one.navigateToSObject(component.get("v.oppId"));  
        }else{
            window.location.href='/'+ component.get("v.oppId");
        }
    },
    cancelBtn : function(component, event, helper) {
        var Get_getUITheme = component.get("v.getUITheme");
        if (Get_getUITheme === 'Theme4d' || Get_getUITheme === 'Theme4t') {
            sforce.one.navigateToSObject(component.get("v.oppId"));
        } else {
            window.location.href = '/' + component.get("v.oppId");
        }
    },
    handleAddChildProductEvent : function(component, event, helper){
        var prodEidList = component.get("v.childProductEidList");
        var prodWrapList = component.get("v.childProductWrapperList");
        var childProdWrap = event.getParam("childProductWrapperObj");
        var index = prodEidList.indexOf(childProdWrap.productEid);
        if(index != -1){
            prodWrapList[index] = childProdWrap;
            component.set("v.childProductWrapperList",prodWrapList);
        }else{
            prodWrapList.push(childProdWrap);
            prodEidList.push(childProdWrap.productEid);
            component.set("v.childProductWrapperList",prodWrapList);
            component.set("v.childProductEidList",prodEidList);
        }
    },
    
    showError : function(component, event, helper){
        var errorMsg = event.getParam("errorMessage");
        component.set("v.message",errorMsg);
    }
})