({
	 
	closeModalBox : function(component, event, helper) {
        
        document.getElementById("RemoveProduct").style.display = "none";
        document.getElementById("RemoveProductBackground").style.display = "none"; 
    },
    removeProduct : function(component, event, helper) {
         var count =  component.get("v.count");
         var addedProduct =  component.get("v.addedProductWrapper");
         addedProduct.splice(count, 1);
         component.set("v.addedProductWrapper", []);
         component.set("v.addedProductWrapper", addedProduct);
         document.getElementById("RemoveProduct").style.display = "none";
         document.getElementById("RemoveProductBackground").style.display = "none";
    }
})