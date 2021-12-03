({
    ListOfAgreement : function(component, event, helper,mmap) {
        var action = component.get("c.getAllProductAgreements");        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var agreementList = response.getReturnValue();
                var arr = [];
                console.log('agreementList::::'+JSON.stringify(agreementList));
                for(var i in agreementList){
                    if(!mmap.has(agreementList[i].eid)){
                        arr.push(agreementList[i]);
                    }
                }
                component.set("v.agreementList", arr);
                this.startProducts(component, event, helper); 
            }
        });  
        
        
        $A.enqueueAction(action);
    },
    addSelectedAgreements : function(component, event, helper,agreementList) {
        var action = component.get("c.setAgreements");
        action.setParams({
            agreementWrapper: JSON.stringify(agreementList),
            productId:component.get("v.productId")
        });        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var appEvent = $A.get("e.c:ReloadProductDetail");
                appEvent.fire();
                component.destroy();

            }
        });  
        
        
        $A.enqueueAction(action);
    },
    startProducts : function(component, event, helper) {
        var oppProLists = component.get("v.agreementList");
        var totelProduct = oppProLists.length;
        var totelPage = Math.ceil(totelProduct / 10);
        var agreementListMap = component.get("v.agreementListMap");
        var currentLocation = 0;
        for(var i=1; i<=totelPage; i++){
        var proList = [];
        var count = 0;
        var displayLocation = (currentLocation + 10) >= totelProduct ?  totelProduct :  (currentLocation + 10) ;
        for(var j=currentLocation ; j<displayLocation; j++ ){
            proList[count++] = oppProLists[j];
        }
        currentLocation =  displayLocation;
        agreementListMap[i] = proList;
        }
        component.set("v.agreementListMap", agreementListMap);
        component.set("v.totelPage", totelPage);
        var currentPage = component.get("v.currentPage");
        component.set("v.agreementList", agreementListMap[currentPage]);
        if(totelPage == 1){
           component.set("v.disableNext", true); 
           component.set("v.disableLast", true); 
        }
    }

})