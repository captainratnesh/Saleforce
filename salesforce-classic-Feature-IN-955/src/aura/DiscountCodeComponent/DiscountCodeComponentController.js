({
    closeModalBox : function(component, event, helper) {
        
        component.destroy();
    },
    doinit : function(component, event, helper) {
        var productWrapper = component.get("v.productWrapper");
        component.set("v.productWrapper", productWrapper);
        component.set("v.discountCode",productWrapper.discountName);
        //document.getElementById("showErrorDisountCode").style.display = "none";
    },
    saveDiscountCode : function(component, event, helper) {
         var productWrapper = component.get("v.productWrapper");
         var discountName = component.get("v.discountCode");
         if(discountName == undefined || discountName.trim() == ''){
             component.set("v.message", 'Please enter Discount code');
             document.getElementById("showErrorDisountCode").style.display = "block";
         }else{
             helper.getDiscount(component, event, helper);
         }
    }
})