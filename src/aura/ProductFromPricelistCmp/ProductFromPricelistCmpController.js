({
    doInit : function(component, event, helper) {
        console.log('priceListWrap::::::'+component.get("v.priceListWrap"));
        helper.getProduct(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    AddNewproduct:function(component, event, helper) {
        $A.createComponent(
            "c:EditProductInPriceListComponent",
            {
               "priceListWrap":component.get("v.priceListWrap"),
            },
            function(newCmp){
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
    );
    },
    RemoveExistingProduct:function(component, event, helper) {
        $A.createComponent(
            "c:RemoveProductInPriceListComponent",
            {
               "priceListWrap":component.get("v.priceListWrap")
            },
            function(newCmp){
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
    );
    },
    nextProduct : function(component, event, helper) {
        var totelPage =  component.get("v.totelPage");
        var currentPage = component.get("v.currentPage");
        var ProductList = component.get("v.listOfProducts");        
        var ProductListMap = component.get("v.ProductListMap");       
        ProductListMap[currentPage] = ProductList;
        currentPage++;
        component.set("v.listOfProducts", ProductListMap[currentPage]);
        component.set("v.currentPage", currentPage);
        if(currentPage == totelPage){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
        component.set("v.disablePrev", false); 
        component.set("v.disableFirst", false); 
        
    },  
	prevProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
        var ProductList = component.get("v.listOfProducts");
        var ProductListMap = component.get("v.ProductListMap");        
        ProductListMap[currentPage] = ProductList;
        currentPage--; 
        component.set("v.listOfProducts", ProductListMap[currentPage]);
        component.set("v.currentPage", currentPage);
	    if(currentPage == 1){
	        component.set("v.disablePrev", true); 
	        component.set("v.disableFirst", true); 
	    }
	    component.set("v.disableNext", false);
	    component.set("v.disableLast", false);
	},   
	lastProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var lastPage = component.get("v.totelPage");
	    var ProductList = component.get("v.listOfProducts");
	    var ProductListMap = component.get("v.ProductListMap");	    
	    ProductListMap[currentPage] = ProductList;
	    component.set("v.listOfProducts", ProductListMap[lastPage]);
	    component.set("v.currentPage", lastPage);
	    component.set("v.disablePrev", false); 
	    component.set("v.disableFirst", false); 
	    component.set("v.disableNext", true);
	    component.set("v.disableLast", true);
	},   
	firstProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var ProductList = component.get("v.listOfProducts");
	    var ProductListMap = component.get("v.ProductListMap");	    
	    ProductListMap[currentPage] = ProductList;
	    component.set("v.listOfProducts", ProductListMap[1]);
	    component.set("v.currentPage", 1);
	    component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        component.set("v.disableNext", false);
        component.set("v.disableLast", false);
    },
    ReloadComp : function(component, event, helper) {
        helper.getProduct(component, event, helper);
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    getProductPrices:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        $A.createComponent(
            "c:ProductPriceComponent",
            {
               "productDetails": component.get("v.listOfProducts[" + count + "]"),
               "priceListWrap":component.get("v.priceListWrap")
            },
            function(newCmp){
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
    );
    }
})