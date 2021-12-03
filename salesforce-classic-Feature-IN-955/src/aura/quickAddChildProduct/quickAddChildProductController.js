({
    onPriceListChange: function (component, event, helper) {
        var priceListValue = event.getSource().get("v.value");
        var proWrapper = component.get("v.childProd");
        proWrapper.priceListValue = priceListValue;
        component.set("v.childProdPriceListValue",priceListValue);
        helper.getProductPrices(component, event, proWrapper);
    },

    onRecurPerChange : function(component, event, helper) {
        var perValue = event.getSource().get("v.value");
        component.set("v.childProdRecurrencePeriod",perValue);
        var proWrapper = component.get("v.childProd");     
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
        document.getElementById("showErrorProductCart").style.display = "none";
        var quantity = event.getSource().get("v.value");
        var proWrapper = component.get("v.childProd");
        var recPerValue = component.get("v.childProdRecurrencePeriod");
        var priceList = component.get("v.childProdPriceListValue");
        proWrapper.priceListValue = priceList;
        proWrapper.recurrencPerValue = recPerValue;
        proWrapper.recurringprice = proWrapper.idAndPriceValueMap[recPerValue];
        proWrapper.quantity = quantity;
        if(!isNaN(quantity) && quantity !='' && quantity != null){
            helper.getpriceRangeValue(component, event, proWrapper);
        }else if(isNaN(quantity)){
            helper.sendErrorMessageToParent(component, event, 'Please enter a valid quantity for products \''+proWrapper.prod.Name+'\'');
            document.getElementById("showErrorProductCart").style.display = "block";
        }
    },
    
    onChildDiscountChange : function(component, event, helper) {
        var dis = component.get("v.prodDiscountName");
        var proWrapper = component.get("v.childProd");
        proWrapper.discountName = dis;
        component.set("v.childProd",proWrapper);

        if(proWrapper.quantity > 0){
            helper.sendUpdatedChildProductToParent(component, event);
        }
    },
    
    onAgreementChange : function(component, event, helper){
        var agreement = event.getSource().get("v.value");
        var wrapObj = component.get("v.childProd");
        wrapObj.agreementId = agreement;
        component.set("v.childProd",wrapObj);
        helper.sendUpdatedChildProductToParent(component, event);
    }
})