({
    doInit : function(component, event, helper) {
        helper.getMarketPlacePriceList(component, event, helper);
    },
    getPriceListProduct:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var getpricelist = selectedItem.dataset.getpricelist;
        var wrappers = component.get("v.ListsofPriceLists[" + getpricelist + "]");
        var updateEvent = $A.get("e.c:GetPricelistProductEvt");
        console.log('wrappers:::'+wrappers);
        console.log('updateEvent:::'+updateEvent);
        updateEvent.setParams({
            "thisWrapper": wrappers
        });
        updateEvent.fire();
        console.log('Event Fired');
        document.getElementById("PriceListModal").style.display = "none";
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})