({
    doInit : function(component, event, helper) {
        console.log('errors::::::'+component.get("v.opportunityId"));
        helper.getProductWrapper(component, event, helper);
    },
    closeModalBox:function(component, event, helper) {
        component.destroy();
    },
    onPriceListChange : function(component, event, helper) {
        helper.getProductPrices(component, event, helper);
    },
    onRecurPerChange : function(component, event, helper) {
        var productWrapper = component.get("v.productWrapper");
        var MapofProductPriceEidVsPriceOverrideFlag = productWrapper.mapofProductPriceEidVsPriceOverrideFlag;
        productWrapper.disableRecurring = MapofProductPriceEidVsPriceOverrideFlag[productWrapper.recurrencPerValue];
        var mapOfProductPriceEidVsPriceRangeList = productWrapper.priceVsPriceRanges;
        var ProductPriceRangeWrapperList = mapOfProductPriceEidVsPriceRangeList[productWrapper.recurrencPerValue];
        for(var i in ProductPriceRangeWrapperList){
            if(ProductPriceRangeWrapperList[i].quantityEndRange != null){
                if(ProductPriceRangeWrapperList[i].quantityBeginRange < productWrapper.quantity && ProductPriceRangeWrapperList[i].quantityEndRange >= productWrapper.quantity){
                    productWrapper.recurringprice = ProductPriceRangeWrapperList[i].price;
                    productWrapper.unitPrice =  helper.returnUnitPrice(productWrapper.recurringprice,productWrapper.oneTimePrice);
                    productWrapper.totelPrice = eval(productWrapper.unitPrice*productWrapper.quantity);
                    break;
                }
            }
            else{
                if(ProductPriceRangeWrapperList[i].quantityBeginRange < productWrapper.quantity){
                    productWrapper.recurringprice = ProductPriceRangeWrapperList[i].price;
                    productWrapper.unitPrice =  helper.returnUnitPrice(productWrapper.recurringprice,productWrapper.oneTimePrice);
                    productWrapper.totelPrice = eval(productWrapper.unitPrice*productWrapper.quantity);
                    break;
                }
            }
        }
        component.set("v.productWrapper", productWrapper);
    },
    saveProductPrice: function(component, event, helper) {
        var appEvent = $A.get("e.c:AddToCartConfigurationModalReturnEvt");
        appEvent.setParams({
            "addedProductWrapper": component.get("v.productWrapper")
        });
        appEvent.fire();
        
        component.destroy();
    }
    
    
})