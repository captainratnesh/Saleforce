({
    closeModalBox: function(component, event, helper) {
        if(document.getElementById('PriceListModal1')){
            document.getElementById('PriceListModal1').style.display = 'block';
            document.getElementById('PriceListBackground1').style.display = 'block';
        }
        component.destroy();
    },
    doinit: function(component, event, helper) {
        console.log('I am here::::'+component.get("v.productId"));
        console.log('I am here::::'+component.get("v.pricelist"));
        helper.getRecurringChargePriceWrapper(component, event, helper);
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    addTier : function(component, event, helper) {
        component.set("v.message",'');
        var recurringChargePriceWrapper = component.get("v.recurringChargePriceWrapper");
        if(recurringChargePriceWrapper.priceCategory == null || recurringChargePriceWrapper.priceCategory ==''){
            component.set("v.message",'Please select a Price Category.');
            document.getElementById("showErrorRecurringPriceCreation").style.display = "block";
        }
        else{
            helper.getPriceRangeWrapper(component, event, helper);
        }
    },
    deleteTier : function(component, event, helper) {
        var recurringChargePriceWrapper = component.get("v.recurringChargePriceWrapper");
        recurringChargePriceWrapper.createPriceRangeWrapper.splice(-1,1);
        component.set("v.recurringChargePriceWrapper",recurringChargePriceWrapper);
    },
    saveProductPrice: function(component, event, helper) {
        var recurringChargePriceWrapper = component.get("v.recurringChargePriceWrapper");
        var priceRangeWrapperLength = recurringChargePriceWrapper.createPriceRangeWrapper.length;
        var lastPriceRangeWrapper = recurringChargePriceWrapper.createPriceRangeWrapper[priceRangeWrapperLength-1];
        console.log('lastPriceRangeWrapper.endingQuantity::::'+lastPriceRangeWrapper.endingQuantity);
        if(lastPriceRangeWrapper.endingQuantity == null || lastPriceRangeWrapper.endingQuantity == '' || lastPriceRangeWrapper.endingQuantity.length == 0){
            lastPriceRangeWrapper.endingQuantity = undefined;
            helper.createProductPriceInGTV(component, event, helper);
        }
        else{
            component.set("v.message",'Error in '+lastPriceRangeWrapper.tier+ ': The last tier must have an empty Ending Qty but was '+lastPriceRangeWrapper.endingQuantity+'.');
            document.getElementById("showErrorRecurringPriceCreation").style.display = "block";
        }
    }
})