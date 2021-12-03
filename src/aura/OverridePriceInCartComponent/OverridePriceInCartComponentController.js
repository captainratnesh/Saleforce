({
    doinit : function(component, event, helper) {
        var addedProductWrapper = component.get("v.AddedProductWrapper");
        var mapOfProductPriceEidVsPriceRangeList = addedProductWrapper.priceVsPriceRanges;
        if(addedProductWrapper.recurringprice != null){
            var recurringPriceRanges = mapOfProductPriceEidVsPriceRangeList[addedProductWrapper.recurrencPerValue];
            component.set("v.RecurringPriceRanges", recurringPriceRanges);
        }
        if(addedProductWrapper.oneTimePrice != null){
            var oneTimePriceRanges = mapOfProductPriceEidVsPriceRangeList[addedProductWrapper.oneTimePerValue];
            component.set("v.OneTimePriceRanges", oneTimePriceRanges);
        }
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },

    overridePrices: function(component, event, helper) {
        var errorMessage = '';
        component.set("v.message",'');
        var recurringPriceRanges = component.get("v.RecurringPriceRanges");
        var recurringPriceRangeLength = recurringPriceRanges.length;
        if(recurringPriceRangeLength > 0){
            errorMessage = helper.updateTiering(recurringPriceRanges);
        }
        var oneTimePriceRanges = component.get("v.OneTimePriceRanges");
        if(oneTimePriceRanges.length > 0){
            if(errorMessage == ''){
                errorMessage = helper.updateTiering(oneTimePriceRanges);
            }
            else{
                errorMessage += helper.updateTiering(oneTimePriceRanges);
            }
        }
        if(errorMessage != ''){
            component.set("v.message",errorMessage);
            document.getElementById("showErrorrOverridePriceInCart").style.display = "block";
        }
        else{
            helper.returnOverridePrices(component, event, helper);
        }
        
    }
})