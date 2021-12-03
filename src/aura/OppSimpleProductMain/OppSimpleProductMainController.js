({
    doInit : function(component, event, helper) {
        helper.checkExistingOrder(component, event, helper);      
    },
    addProduct : function(component, event, helper) {
       component.set("v.addedProductWrapper", event.getParam("addedProductWrapper"));
       helper.createOpporunityProductCmp(component, event, helper); 
    },
    NavigateAddProduct : function(component, event, helper) {
        $A.createComponent(
                "c:AddSimpleProduct",
                {
                     "oppId" : component.get("v.recordId"),
                    "addedProduct" : event.getParam("productList")
                },
                function(newCmp){
                    if (component.isValid()) {
                        component.set("v.body", newCmp);
                    }
                }
        );
    } ,
     waiting : function(component, event, helper) {
    	 document.getElementById("showspinner").style.display = "block";
    },
    doneWaiting : function(component, event, helper) {
    	document.getElementById("showspinner").style.display = "none";
    }
})