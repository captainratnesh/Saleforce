({
    getProductDetail: function(component, event, helper, productList, oppId) {
        var action = component.get("c.getProductDetailListsExisting");
        action.setParams({
            opportunityId: oppId
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            var productList = response.getReturnValue();
            var addedProductWrapper = component.get("v.addedProductWrapper");
            addedProductWrapper.push.apply(addedProductWrapper, productList);
            component.set("v.addedProductWrapper", addedProductWrapper);
        });
        $A.enqueueAction(action);
    },
    createSalesOrder: function(component, event, helper, productList, oppId) {
        var action = component.get("c.createSalesOrderApexExisting");
        action.setParams({
            productWrapperString: JSON.stringify(productList),
            OpportunityId: oppId
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var proList = response.getReturnValue();

                if (proList.errorMessage == "NoError") {
                    var Get_getUITheme = component.get("v.getUITheme");
                    if (Get_getUITheme === 'Theme4d' || Get_getUITheme === 'Theme4t') {
                        sforce.one.navigateToSObject(oppId);
                    } else {
                        window.location.href = '/' + oppId;
                    }

                } else {
                    component.set("v.message", proList.errorMessage);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                } else if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    getProductPrices: function(component, oppProWrapper, indexParent, indexChild, proWrapper, priceList) {
        var action = component.get("c.getProductPricesApex");
        action.setParams({
            productWrapperString: JSON.stringify(oppProWrapper)
        })

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var childWrapper = response.getReturnValue();
                proWrapper.childProducts[indexChild] = childWrapper;
                component.set("v.addedProductWrapper[" + indexParent + "]", proWrapper);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                } else if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    getpriceRangeValue: function(component, oppProWrapper, indexParent, indexChild, proWrapper) {
        var action = component.get("c.getpriceRangeValue");
        action.setParams({
            productWrapperString: JSON.stringify(oppProWrapper)
        })

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var childWrapper = response.getReturnValue();
                proWrapper.childProducts[indexChild] = childWrapper;
                component.set("v.addedProductWrapper[" + indexParent + "]", proWrapper);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                } else if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    },
    setPriceCurrency: function(component, event, isParent, parentWrapper, childWrapper, parentIndex, childIndex) {
        var action = component.get("c.setOrderCurrencyType");
        action.setParams({
            proShowString: JSON.stringify(childWrapper)
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var responseWrapper = response.getReturnValue();
                if (isParent) {
                    parentWrapper = responseWrapper;
                } else {
                    parentWrapper.childProducts[childIndex] = responseWrapper;
                }
                component.set("v.addedProductWrapper[" + parentIndex + "]", parentWrapper);
            } else {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                } else if (errors[0] && errors[0].pageErrors) {
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorProductCart").style.display = "block";
                }
            }
        });
        $A.enqueueAction(action);
    }
})