({
    doInit: function(component, event, helper) {
        var oppId = component.get("v.oppId");
        
        if (oppId != null) {
            helper.getProductList(component, event, helper, oppId);
        }
       
    },

    addProduct: function(component, event, helper) {
        var productLists = [];
        var allProducts = component.get("v.oppProList");
        for (var i = 0; i < allProducts.length; i++) {
            if (allProducts[i].isSelected) {
                productLists.push(allProducts[i].prod);
            }
        }
        if (productLists.length == 0) {
            component.set("v.message", "Please select atleast one product.");
            document.getElementById("showErrorProductList").style.display = "block";
        } else if (productLists.length > 99) {
            component.set("v.message", "You can not add more than 99 products to the cart.");
            document.getElementById("showErrorProductList").style.display = "block";
        } else {
            var evt = $A.get("e.c:AddTractProductEvent");
            evt.setParams({
                "productList": productLists
            });
            evt.fire();
        }
    },
    getHomePage: function(component, event, helper) {
        var Get_getUITheme = component.get("v.getUITheme");
        if (Get_getUITheme === 'Theme4d' || Get_getUITheme === 'Theme4t') {
            sforce.one.navigateToSObject(component.get("v.oppId"));
        } else {
            window.location.href = '/' + component.get("v.oppId");
        }
    },
    searchKeyChange: function(component, event, helper) {
        var productidList = component.get("v.productidList");
        var searchKey = event.target.value;
        helper.searchKeyChangeHelper(component, event, helper, searchKey, productidList);
    },
    onProductSelect: function(component, event, helper) {
        var indexes = event.getSource().get("v.label");
        var productList = component.get("v.oppProLists");
        var selectedProductList = component.get("v.oppProList");
        selectedProductList.push(productList[indexes]);

    },

})