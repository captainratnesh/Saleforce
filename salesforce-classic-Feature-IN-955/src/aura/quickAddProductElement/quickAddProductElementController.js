({
    onPriceListChange: function (component, event, helper) {
        var priceListValue = event.getSource().get("v.value");
        var proWrapper = component.get("v.pro");
        proWrapper.priceListValue = priceListValue;
        component.set("v.prodPriceListValue",priceListValue);
        helper.getProductPrices(component, event, proWrapper);
    },

    onRecurPerChange : function(component, event, helper) {
        var perValue = event.getSource().get("v.value");
        component.set("v.prodRecurrencePeriod",perValue);
        var proWrapper = component.get("v.pro");     
        var IdAndPriceValueMap = proWrapper.idAndPriceValueMap;
        var recPrice = IdAndPriceValueMap[perValue];
        proWrapper.recurringprice = recPrice;
        proWrapper.recurrencPerValue = perValue;
        if(proWrapper.oneTimePrice){
            proWrapper.totelPriceValue = ((recPrice + proWrapper.oneTimePrice) * proWrapper.quantity).toString() + '.00';
        }else{
            proWrapper.totelPriceValue = (recPrice * proWrapper.quantity).toString() + '.00';
        }
        helper.setPriceCurrency(component, event, proWrapper);
    },

    onQuantityChange : function(component, event, helper) {
        var quantity = event.getSource().get("v.value");
        var proWrapper = component.get("v.pro");
        proWrapper.quantity = quantity;
        if(!isNaN(quantity) && quantity!='' && quantity!= null){
            helper.getpriceRangeValue(component, event, proWrapper);
        }
    },
    
    onDiscountChange : function(component, event, helper) {
        var discountName = event.getSource().get("v.value");
        var proWrapper = component.get("v.pro");
        proWrapper.discountName = discountName;
        component.set("v.pro",proWrapper);
    }
})