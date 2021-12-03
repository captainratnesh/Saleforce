({
    getRecurringChargePriceWrapper : function(component, event, helper) {
        var selectedPrice = component.get("v.selectedPrice");
        console.log('selectedPrice:::::::::'+JSON.stringify(selectedPrice));
        var action = component.get("c.getCreateRecurringChargePriceWrapper"); 
        action.setParams({
            productId : component.get("v.productId"),
            selectedPrice : JSON.stringify(selectedPrice)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                if(res.eid != null){
                    component.set("v.isEdit",true);
                }
                component.set("v.recurringChargePriceWrapper",res);
            }
        });
        $A.enqueueAction(action);
    },
    
    getPriceRangeWrapper : function(component, event, helper) {
        var action = component.get("c.getCreatePriceRangeWrapper"); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var recurringChargePriceWrapper = component.get("v.recurringChargePriceWrapper");
                var priceRangeWrapperLength = recurringChargePriceWrapper.createPriceRangeWrapper.length+1;
                var lastPriceRangeWrapper = recurringChargePriceWrapper.createPriceRangeWrapper[priceRangeWrapperLength-2];
                var startingQuantity = lastPriceRangeWrapper.startingQuantity+1;
                if(lastPriceRangeWrapper.endingQuantity == null || lastPriceRangeWrapper.endingQuantity == ''){
                    lastPriceRangeWrapper.endingQuantity = startingQuantity;
                }
                console.log('lastPriceRangeWrapper'+JSON.stringify(lastPriceRangeWrapper));       
                var res = response.getReturnValue();
                res.tier = 'Tier '+priceRangeWrapperLength;
                res.startingQuantity = parseInt(lastPriceRangeWrapper.endingQuantity);
                recurringChargePriceWrapper.createPriceRangeWrapper.push(res);
                component.set("v.recurringChargePriceWrapper",recurringChargePriceWrapper );
            }
        });
        $A.enqueueAction(action);
    },
    createProductPriceInGTV : function(component, event, helper){
        var recurringChargePriceWrapper = component.get("v.recurringChargePriceWrapper");
        var pricelistEid = component.get("v.pricelist");
        var action = component.get("c.createProductPrice"); 
        console.log('Wrapper::::::::::'+JSON.stringify(recurringChargePriceWrapper));       
        action.setParams({
            createProductPriceWrapperString : JSON.stringify(recurringChargePriceWrapper),
            priceListId : component.get("v.pricelist")
        });
        action.setCallback(this, function(response){     
            var state = response.getState();
            if(state === "SUCCESS"){
                var message = response.getReturnValue();
                console.log('message::::::::::'+message);
                console.log('component.get("v.pricelist")::::::::::'+component.get("v.pricelist"));
                if(message == "NoError"){
                    console.log('Product Price is successfully get Added');
                    if(pricelistEid == undefined){
                        console.log('Normal');
                        window.location.href = '/' + component.get("v.productId");
                    }
                    else{
                        console.log('Evt fired');
                        var updateEvent = $A.get("e.c:ReturnRecurringPriceEvt");
                        updateEvent.fire();
                        if(document.getElementById('PriceListModal1')){
                            document.getElementById('PriceListModal1').style.display = 'block';
                            document.getElementById('PriceListBackground1').style.display = 'block';
                        }
                        component.destroy();
                    }
                }else{
                    component.set("v.message",message);
                    document.getElementById("showErrorRecurringPriceCreation").style.display = "block";
                }
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorRecurringPriceCreation").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorRecurringPriceCreation").style.display = "block";
                }
            }           
        });  
        $A.enqueueAction(action);
    }
})