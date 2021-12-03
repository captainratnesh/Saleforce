({
    getMarketPlaces : function(component, event, helper) {
        var action = component.get("c.getAvailableMarketPlaces"); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.marketPlaceList",res);
                this.startProducts(component, event, helper); 
            }
        });
        $A.enqueueAction(action);
    },
    startProducts : function(component, event, helper) {
        var oppProLists = component.get("v.marketPlaceList");
        var totelProduct = oppProLists.length;
        var totelPage = Math.ceil(totelProduct / 10);
        var marketPlaceListMap = component.get("v.marketPlaceListMap");
        var currentLocation = 0;
        for(var i=1; i<=totelPage; i++){
        var proList = [];
        var count = 0;
        var displayLocation = (currentLocation + 10) >= totelProduct ?  totelProduct :  (currentLocation + 10) ;
        for(var j=currentLocation ; j<displayLocation; j++ ){
            proList[count++] = oppProLists[j];
        }
        currentLocation =  displayLocation;
        marketPlaceListMap[i] = proList;
        }
        component.set("v.marketPlaceListMap", marketPlaceListMap);
        component.set("v.totelPage", totelPage);
        var currentPage = component.get("v.currentPage");
        component.set("v.marketPlaceList", marketPlaceListMap[currentPage]);
        if(totelPage == 1){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
    }
})