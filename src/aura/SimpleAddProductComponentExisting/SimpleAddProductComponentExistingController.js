({
    doinit: function(component, event, helper) {
        var addedProduct = component.get("v.addedProduct");
        var oppId = component.get("v.oppId");
        helper.getProductDetail(component, event, helper, addedProduct, oppId);
    },
    createOrder: function(component, event, helper) {
        var addedProduct = component.get("v.addedProductWrapper");
        var oppId = component.get("v.oppId");
        helper.createSalesOrder(component, event, helper, addedProduct, oppId);
    },
    onPriceListChange: function(component, event, helper) {
        var priceListValue = event.getSource().get("v.value");;
        var indaxValue = priceListValue.split(':');
        var priceList = indaxValue[0];
        var indexChild = indaxValue[1];
        var indexParent = indaxValue[2];
        var proWrapper = component.get("v.addedProductWrapper[" + indexParent + "]");
        var childServiceWrapper = proWrapper.childProducts[indexChild];
        childServiceWrapper.priceListValue = priceList;
        helper.getProductPrices(component, childServiceWrapper, indexParent, indexChild, proWrapper, priceList);

    },
    onParentPriceListChange: function(component, event, helper) {
        var priceListValue = event.getSource().get("v.value");;
        var indaxValue = priceListValue.split(':');
        var priceList = indaxValue[0];
        var indexParent = indaxValue[1];
        var proWrapper = component.get("v.addedProductWrapper[" + indexParent + "]");

        proWrapper.priceListValue = priceList;
        helper.getProductPrices(component, proWrapper, indexParent, indexChild, proWrapper, priceList);

    },
    onParentRecurPerChange: function(component, event, helper) {
        var priceListValue = event.getSource().get("v.value");
        var indaxValue = priceListValue.split(':');
        var perValue = indaxValue[0];
        var indexParent = indaxValue[1];
        var proWrapper = component.get("v.addedProductWrapper[" + indexParent + "]");
        var IdAndPriceValueMap = proWrapper.idAndPriceValueMap;
        var recPrice = IdAndPriceValueMap[perValue];
        proWrapper.recurringprice = recPrice;
        proWrapper.recurrencPerValue = perValue;
        proWrapper.totelPriceValue = (recPrice * proWrapper.quantity).toString() + '.00';
        helper.setPriceCurrency(component, event, true, proWrapper, proWrapper, indexParent, indexParent);
    },
    onRecurPerChange: function(component, event, helper) {
        var priceListValue = event.getSource().get("v.value");;
        var indaxValue = priceListValue.split(':');
        var perValue = indaxValue[0];
        var indexChild = indaxValue[1];
        var indexParent = indaxValue[2];
        var proWrapper = component.get("v.addedProductWrapper[" + indexParent + "]");
        var childServiceWrapper = proWrapper.childProducts[indexChild];
        var IdAndPriceValueMap = childServiceWrapper.idAndPriceValueMap;
        var recPrice = IdAndPriceValueMap[perValue];
        childServiceWrapper.recurringprice = recPrice;
        childServiceWrapper.recurrencPerValue = perValue;
        childServiceWrapper.totelPriceValue = (recPrice * childServiceWrapper.quantity).toString() + '.00';
        helper.setPriceCurrency(component, event, false, proWrapper, childServiceWrapper, indexParent, indexChild);
    },
    onQuantityChange: function(component, event, helper) {
        var quantityValue = event.getSource().get("v.value");
        var indexes = event.getSource().get("v.label");
        var indaxValue = indexes.split(':');
        var indexChild = indaxValue[0];
        var indexParent = indaxValue[1];
        var proWrapper = component.get("v.addedProductWrapper[" + indexParent + "]");
        var childServiceWrapper = proWrapper.childProducts[indexChild];
        if (!isNaN(quantityValue) && quantityValue != '' && quantityValue != null) {
            helper.getpriceRangeValue(component, childServiceWrapper, indexParent, indexChild, proWrapper);
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
    cancelBtn: function(component, event, helper) {
        // Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }
})