({
    getProduct : function(component, event, helper) {
        var action = component.get("c.getProductByPriceListEid"); 
        action.setParams({
            priceListEid: (component.get("v.priceListWrap.priceListId")),
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.listOfProducts",res);
                this.startProducts(component, event, helper);
            }
        });
        $A.enqueueAction(action);
    },
    startProducts : function(component, event, helper) {
        var oppProLists = component.get("v.listOfProducts");
        var totelProduct = oppProLists.length;
        var totelPage = Math.ceil(totelProduct / 10);
        var ProductListMap = component.get("v.ProductListMap");
        var currentLocation = 0;
        for(var i=1; i<=totelPage; i++){
        var proList = [];
        var count = 0;
        var displayLocation = (currentLocation + 10) >= totelProduct ?  totelProduct :  (currentLocation + 10) ;
        for(var j=currentLocation ; j<displayLocation; j++ ){
            proList[count++] = oppProLists[j];
        }
        currentLocation =  displayLocation;
        ProductListMap[i] = proList;
        }
        component.set("v.ProductListMap", ProductListMap);
        component.set("v.totelPage", totelPage);
        var currentPage = component.get("v.currentPage");
        component.set("v.listOfProducts", ProductListMap[currentPage]);
        if(totelPage == 1){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
    }
})