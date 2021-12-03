({
    doinit : function(component, event, helper) {
        helper.getAllProducts(component, event, helper);
    },
    saveSelectedProduct : function(component, event, helper) {
        var listOfSelectedProducts = component.get("v.AvailableAndSelectedProductsWrap.listOfSelectedProducts");
        console.log('listOfSelectedProducts:::::'+listOfSelectedProducts);
        if(listOfSelectedProducts != undefined && listOfSelectedProducts.length > 0){
            helper.addSelectedProducts(component, event, helper);
        }
        else{
            component.set("v.message",'Please select atleast one product to add to the pricelist.');
            document.getElementById("showErrorEditProductsToPriceList").style.display = "block";
        }
    },
    closeModalBox : function(component, event, helper) {
        component.destroy();
     },
     waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
    


})