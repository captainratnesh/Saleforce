({
	doInit : function(component, event, helper) {
    	var oppId = component.get("v.oppId");
    	if(oppId != null){
    	    helper.getProductList(component, event, helper, oppId);
    	}
	}, 
    nextProduct : function(component, event, helper) {
        var totelPage =  component.get("v.totelPage");
        var currentPage = component.get("v.currentPage");
        var oppProList = component.get("v.oppProList");        
        var productListMap = component.get("v.productListMap");       
        productListMap[currentPage] = oppProList;
        currentPage++;
        component.set("v.oppProList", productListMap[currentPage]);
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
        var oppProList = component.get("v.oppProList");
        var productListMap = component.get("v.productListMap");        
        productListMap[currentPage] = oppProList;
        currentPage--; 
        component.set("v.oppProList", productListMap[currentPage]);
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
	    var oppProList = component.get("v.oppProList");
	    var productListMap = component.get("v.productListMap");	    
	    productListMap[currentPage] = oppProList;
	    component.set("v.oppProList", productListMap[lastPage]);
	    component.set("v.currentPage", lastPage);
	    component.set("v.disablePrev", false); 
	    component.set("v.disableFirst", false); 
	    component.set("v.disableNext", true);
	    component.set("v.disableLast", true);
	},   
	firstProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var oppProList = component.get("v.oppProList");
	    var productListMap = component.get("v.productListMap");	    
	    productListMap[currentPage] = oppProList;
	    component.set("v.oppProList", productListMap[1]);
	    component.set("v.currentPage", 1);
	    component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        component.set("v.disableNext", false);
        component.set("v.disableLast", false);
	},   
    addProduct : function(component, event, helper) {
        var currentPage = component.get("v.currentPage");
        var oppProList = component.get("v.oppProList");
        var productListMap = component.get("v.productListMap");
        productListMap[currentPage] = oppProList;
        var productLists = [];
        for (var key in productListMap){
            var productList =  productListMap[key]; 
            for (var i in productList) {
              if(productList[i].isSelected){
                  productLists.push(productList[i].prod);
              }
            }
        }
        if(productLists.length == 0){
            component.set("v.message", "Please select atleast one product.");
            document.getElementById("showErrorProductList").style.display = "block";
        }else{
            var evt = $A.get("e.c:AddTractProductEvent");
            evt.setParams({ "productList": productLists});
            evt.fire();
        }
        
    }, 
    getHomePage : function(component, event, helper) {
         var Get_getUITheme = component.get("v.getUITheme");
         if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
                sforce.one.navigateToSObject(component.get("v.oppId"));  
         }else{
             window.location.href='/'+ component.get("v.oppId");
         }
         
    }  
	
})