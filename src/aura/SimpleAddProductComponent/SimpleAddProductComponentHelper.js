({
    getProductList: function(component, event, helper, oppId) {
        var action = component.get("c.getProductLists");
        action.setParams({
            OpportunityId: oppId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var productList = response.getReturnValue();
            if (productList.errorMessage == "NoBillingAccount") {
                component.set("v.message", "No BillingAccount is  selected for this Opportunity. Please select a BillingAccount first.");
                document.getElementById("showErrorProductList").style.display = "block";
            }else if (productList.errorMessage == "NoCurrencyType") {
                component.set("v.message", "The Billing Account associated with this Opportunity is not available in TRACT.");
                document.getElementById("showErrorProductList").style.display = "block";
            }else if (productList.errorMessage == "NoPriceBook") {
                component.set("v.message", "No Price book is selected for this Opportunity. Please select a Price book first.");
                document.getElementById("showErrorProductList").style.display = "block";
            } else if (productList.errorMessage == "OrderCreated") {
                component.set("v.message", "This opportunity has already been moved in Tract");
                document.getElementById("showErrorProductList").style.display = "block";
            } else {
                component.set("v.oppProLists", productList.product2WrapperList);
                component.set("v.pricebookName", productList.pricebook);
                component.set("v.productidList", productList.productIdList);
            }
        });
        $A.enqueueAction(action);
    },

    searchKeyChangeHelper: function(component, event, helper, searchKey, productIdList) {

        var action = component.get("c.getProductListsByName");
        action.setParams({
            productIDSet: productIdList,
            searchKey: searchKey
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var productList = response.getReturnValue();
            var totelProdList = productList.product2WrapperList;
            var selectedProd = component.get("v.oppProList");
            for (var i = 0; i < selectedProd.length; i++) {
                for (var j = 0; j < totelProdList.length; j++) {
                    if (selectedProd[i].prod.Id == totelProdList[j].prod.Id) {
                        totelProdList[j] = selectedProd[i];
                    }
                }
            }
            component.set("v.oppProLists", totelProdList);
        });
        $A.enqueueAction(action);
    }
})