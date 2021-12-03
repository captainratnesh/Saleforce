({
    updateTiering: function(priceRangeList) {
        var errorMessage = '';
        var priceRangeLength = priceRangeList.length;
        for(var i=0;i<priceRangeLength;i++){
            var priceRangeWrapper = priceRangeList[i];
            console.log('priceRangeWrapper.price:::::::::'+priceRangeWrapper.price);
            if(priceRangeWrapper.price === undefined || priceRangeWrapper.price == null || priceRangeWrapper.price === ''){
                if(errorMessage == ''){
                    console.log('priceRangeWrapper.price2222:::::::::'+priceRangeWrapper.price);
                    errorMessage = 'Error in Tier'+priceRangeWrapper.level+ ': price is required.\n';
                }
                else{
                    errorMessage += 'Error in Tier'+priceRangeWrapper.level+ ': price is required.\n';
                }
            }
            if(i==0){
                if(priceRangeWrapper.quantityBeginRange != 0){
                    if(errorMessage == ''){
                        errorMessage = 'Error in Tier'+priceRangeWrapper.level+ ': The first tier must have a Starting Qty of 0 but was '+priceRangeWrapper.quantityBeginRange+'.\n';
                    }
                    else{
                        errorMessage += 'Error in Tier'+priceRangeWrapper.level+ ': The first tier must have a Starting Qty of 0 but was '+priceRangeWrapper.quantityBeginRange+'.\n';
                    }
                }
                if(priceRangeLength >1 && i!= priceRangeLength -1){
                    if(priceRangeWrapper.quantityBeginRange >= priceRangeWrapper.quantityEndRange){
                        if(errorMessage == ''){
                            errorMessage = 'Error in Tier'+priceRangeWrapper.level+ ': Starting Qty cannot be greater than Ending Qty.\n';
                        }
                        else{
                            errorMessage += 'Error in Tier'+priceRangeWrapper.level+ ': Starting Qty cannot be greater than Ending Qty.\n';
                        }
                    }
                }
            }
            if(i== priceRangeLength -1){
                if(priceRangeWrapper.quantityEndRange == null || priceRangeWrapper.quantityEndRange == '' || priceRangeWrapper.quantityEndRange.length == 0){
                    priceRangeWrapper.quantityEndRange = undefined;
                }
                else{
                    if(errorMessage == ''){
                        errorMessage = 'Error in Tier'+priceRangeWrapper.level+ ': The last tier must have an empty Ending Qty but was '+priceRangeWrapper.quantityEndRange+'.\n';
                    }
                    else{
                        errorMessage += 'Error in Tier'+priceRangeWrapper.level+ ': The last tier must have an empty Ending Qty but was '+priceRangeWrapper.quantityEndRange+'.\n';
                    }
                }
            }
            if(i != 0){
                if(priceRangeWrapper.quantityBeginRange != priceRangeList[i-1].quantityEndRange){
                    if(errorMessage == ''){
                        errorMessage = 'Error in Tier'+priceRangeWrapper.level+ ': Tiers cannot have gaps, the tier with Starting Qty '+priceRangeWrapper.quantityBeginRange+' should start with'+priceRangeList[i-1].quantityEndRange+'.\n';
                    }
                    else{
                        errorMessage += 'Error in Tier'+priceRangeWrapper.level+ ': Tiers cannot have gaps, the tier with Starting Qty '+priceRangeWrapper.quantityBeginRange+' should start with'+priceRangeList[i-1].quantityEndRange+'.\n';
                    }
                }
                if(priceRangeWrapper.quantityBeginRange >= priceRangeWrapper.quantityEndRange && i != priceRangeLength -1){
                    if(errorMessage == ''){
                        errorMessage = 'Error in Tier'+priceRangeWrapper.level+ ': Starting Qty cannot be greater than Ending Qty.\n';
                    }
                    else{
                        errorMessage += 'Error in Tier'+priceRangeWrapper.level+ ': Starting Qty cannot be greater than Ending Qty.';
                    }
                }
            }
        }
        return errorMessage;
    },

    returnOverridePrices: function(component, event, helper) {
        var addedProductWrapper = component.get("v.AddedProductWrapper");
        if(addedProductWrapper.recurringprice != null){
            var oldRecurringPriceRanges = component.get("v.OldRecurringPriceRanges");
            var newRecurringPriceRanges = addedProductWrapper.priceVsPriceRanges[addedProductWrapper.recurrencPerValue];
            if(this.returnOverrideFlag(oldRecurringPriceRanges,newRecurringPriceRanges)){
                addedProductWrapper.priceOverridden = true;
                addedProductWrapper.recurringprice = this.returnPrices(newRecurringPriceRanges,addedProductWrapper.quantity);
            }
        }
        if(addedProductWrapper.oneTimePrice != null){
            var oldOneTimePriceRanges = component.get("v.OldOneTimePriceRanges");
            var newOneTimePriceRanges = addedProductWrapper.priceVsPriceRanges[addedProductWrapper.oneTimePerValue];
            if(!addedProductWrapper.priceOverridden){
                if(this.returnOverrideFlag(oldOneTimePriceRanges,newOneTimePriceRanges)){
                    addedProductWrapper.priceOverridden = true;
                }
            }
            if(addedProductWrapper.priceOverridden){
                addedProductWrapper.oneTimePrice = this.returnPrices(newOneTimePriceRanges,addedProductWrapper.quantity);
            }
        }
        if(addedProductWrapper.priceOverridden){
            addedProductWrapper.unitPrice = this.returnUnitPrice(addedProductWrapper.recurringprice,addedProductWrapper.oneTimePrice);
            addedProductWrapper.totelPrice = eval(addedProductWrapper.unitPrice*addedProductWrapper.quantity);
        }
        component.set("v.AddedProductWrapper",addedProductWrapper);
        var appEvent = $A.get("e.c:overridePriceInCartReturnEvent");
        appEvent.setParams({
            "addedProductWrapper": component.get("v.AddedProductWrapper")
        });
        appEvent.fire();    
        component.destroy();
    },

    returnOverrideFlag: function(newPriceRangeList, existingPriceRangeList) {
        for(var i in newPriceRangeList){
            if((newPriceRangeList[i].quantityBeginRange != existingPriceRangeList[i].quantityBeginRange) || (newPriceRangeList[i].quantityEndRange != existingPriceRangeList[i].quantityEndRange) || (newPriceRangeList[i].price != existingPriceRangeList[i].price)){
                return true;
            }
        }
        return false;
    },

    returnPrices: function(PriceRangeList,quantity) {
        for(var i in PriceRangeList){
            if(PriceRangeList[i].quantityEndRange != null){
                if(PriceRangeList[i].quantityBeginRange < quantity && PriceRangeList[i].quantityEndRange >= quantity){
                    return PriceRangeList[i].price;
                }
            }
            else{
                if(PriceRangeList[i].quantityBeginRange < quantity){
                    return PriceRangeList[i].price; 
                }
            }
        }
    },

    returnUnitPrice: function(recurringPrice,oneTimePrice) {
        if(recurringPrice!=null && oneTimePrice!=null){
            return (eval(recurringPrice)+eval(oneTimePrice));
        }
        else if(recurringPrice == null && oneTimePrice != null){
            return eval(oneTimePrice);
        }else if(recurringPrice != null && oneTimePrice == null){
            return eval(recurringPrice);
        }   
    }
})