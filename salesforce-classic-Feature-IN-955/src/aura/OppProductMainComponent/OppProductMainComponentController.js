({
    doInit : function(component, event, helper) {
        helper.createOpporunityProductCmp(component, event, helper);
    },
    addProduct : function(component, event, helper) {
       component.set("v.addedProductWrapper", event.getParam("addedProductWrapper"));
       helper.createOpporunityProductCmp(component, event, helper); 
    },
    NavigateAddProduct : function(component, event, helper) {
        $A.createComponent(
                "c:AddProductComponent",
                {
                    "oppId" : component.get("v.oppId"),
                    "addedProduct" : event.getParam("productList"),
                    "addedProductWrapper" : component.get("v.addedProductWrapper"),
                    "getUITheme" : component.get("v.getUITheme")
                },
                function(newCmp){
                    if (component.isValid()) {
                        component.set("v.body", newCmp);
                    }
                }
        );
    },
    waiting : function(component, event, helper) {
    	 document.getElementById("showspinner").style.display = "block";
    },
    doneWaiting : function(component, event, helper) {
    	document.getElementById("showspinner").style.display = "none";
    }
})