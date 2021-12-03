({
    doInit : function(component, event, helper) {
        helper.getMarketPlaces(component, event, helper);
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    getPriceList: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var getmarket = selectedItem.dataset.getmarket;
        var wrappers = component.get("v.marketPlaceList[" + getmarket + "]");
        var updateEvent = $A.get("e.c:getPriceListEvt");
        updateEvent.setParams({
            "thisWrapper": component.get("v.marketPlaceList[" + getmarket + "]")
        });
        updateEvent.fire();
        document.getElementById("marketpPlaceModal").style.display = "none";
    },
    RemoveMarketPlace:function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var getmarket = selectedItem.dataset.getmarket;
        var wrappers = component.get("v.marketPlaceList[" + getmarket + "]");
        $A.createComponent(
            "c:RemoveMarketPlaceComponent",
            {
               "thisWrapper":wrappers
            },
            function(newCmp){
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            }
    );

    },
    loadJs   : function(component, event, helper) {
        helper.getMarketPlaces(component, event, helper);
    },

    nextProduct : function(component, event, helper) {
        var totelPage =  component.get("v.totelPage");
        var currentPage = component.get("v.currentPage");
        var marketPlaceList = component.get("v.marketPlaceList");        
        var marketPlaceListMap = component.get("v.marketPlaceListMap");       
        marketPlaceListMap[currentPage] = marketPlaceList;
        currentPage++;
        component.set("v.marketPlaceList", marketPlaceListMap[currentPage]);
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
        var marketPlaceList = component.get("v.marketPlaceList");
        var marketPlaceListMap = component.get("v.marketPlaceListMap");        
        marketPlaceListMap[currentPage] = marketPlaceList;
        currentPage--; 
        component.set("v.marketPlaceList", marketPlaceListMap[currentPage]);
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
	    var marketPlaceList = component.get("v.marketPlaceList");
	    var marketPlaceListMap = component.get("v.marketPlaceListMap");	    
	    marketPlaceListMap[currentPage] = marketPlaceList;
	    component.set("v.marketPlaceList", marketPlaceListMap[lastPage]);
	    component.set("v.currentPage", lastPage);
	    component.set("v.disablePrev", false); 
	    component.set("v.disableFirst", false); 
	    component.set("v.disableNext", true);
	    component.set("v.disableLast", true);
	},   
	firstProduct : function(component, event, helper) {
	    var currentPage = component.get("v.currentPage");
	    var marketPlaceList = component.get("v.marketPlaceList");
	    var marketPlaceListMap = component.get("v.marketPlaceListMap");	    
	    marketPlaceListMap[currentPage] = marketPlaceList;
	    component.set("v.marketPlaceList", marketPlaceListMap[1]);
	    component.set("v.currentPage", 1);
	    component.set("v.disablePrev", true); 
        component.set("v.disableFirst", true); 
        component.set("v.disableNext", false);
        component.set("v.disableLast", false);
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})