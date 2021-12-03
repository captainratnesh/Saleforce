({
    doInit : function(component, event, helper) {
        console.log('productDetails::::::'+JSON.stringify(component.get("v.productDetails")));
        console.log('priceListWrap::::::'+JSON.stringify(component.get("v.priceListWrap")));
        helper.getAPiVersion(component, event, helper);
        helper.ListOfOneTimeProductPrice(component, event, helper);
        helper.ListOfRecurringProductPrice(component, event, helper); 
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    createRecurringPriceModal : function(component, event, helper) {
        document.getElementById('PriceListModal1').style.display = 'none';
        document.getElementById('PriceListBackground1').style.display = 'none';
        $A.createComponent(
            "c:CreateRecurringChargePriceComponent", 
            {
                "productId":component.get("v.productDetails").sfdcProductId,
                "pricelist":component.get("v.priceListWrap").priceListId
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },
    createOneTimePriceModel : function(component, event, helper) {
        document.getElementById('PriceListModal1').style.display = 'none';
        document.getElementById('PriceListBackground1').style.display = 'none';
        $A.createComponent(
            "c:CreateOneTimeChargePriceComponent", 
            {
                "productId":component.get("v.productDetails").sfdcProductId,
                "pricelist":component.get("v.priceListWrap").priceListId
            }, 
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
        );
    },
    loadJs : function(component, event, helper) {
        console.log('productDetails::::::'+JSON.stringify(component.get("v.productDetails")));
        console.log('priceListWrap::::::'+JSON.stringify(component.get("v.priceListWrap")));
        console.log('priceListWrap::::::Evt handled');
        helper.ListOfOneTimeProductPrice(component, event, helper);
        helper.ListOfRecurringProductPrice(component, event, helper); 
    }
})