({
    getRecurringChargePriceWrapper : function(component, event, helper) {
        var action = component.get("c.getCreateOneTimeChargePriceWrapper"); 
         action.setParams({
            productId : component.get("v.productId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                console.log('res::::::::::'+JSON.stringify(res));       
                component.set("v.CreateOneTimeChargePriceWrapper",res);
            }
        });
        $A.enqueueAction(action);
    },

    getPriceRangeWrapper : function(component, event, helper) {
        var action = component.get("c.getCreatePriceRangeWrapper"); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var createOneTimeChargePriceWrapper = component.get("v.CreateOneTimeChargePriceWrapper");
                var priceRangeWrapperLength = createOneTimeChargePriceWrapper.createPriceRangeWrapper.length+1;
                var lastPriceRangeWrapper = createOneTimeChargePriceWrapper.createPriceRangeWrapper[priceRangeWrapperLength-2];
                var startingQuantity = lastPriceRangeWrapper.startingQuantity+1;
                if(lastPriceRangeWrapper.endingQuantity == null || lastPriceRangeWrapper.endingQuantity == ''){
                    lastPriceRangeWrapper.endingQuantity = startingQuantity;
                }
                console.log('lastPriceRangeWrapper'+JSON.stringify(lastPriceRangeWrapper));       
                var res = response.getReturnValue();
                res.tier = 'Tier '+priceRangeWrapperLength;
                res.startingQuantity = parseInt(lastPriceRangeWrapper.endingQuantity);
                createOneTimeChargePriceWrapper.createPriceRangeWrapper.push(res);
                component.set("v.CreateOneTimeChargePriceWrapper",createOneTimeChargePriceWrapper );
            }
        });
        $A.enqueueAction(action);
    },
    createProductPriceInGTV : function(component, event, helper){
        var createOneTimeChargePriceWrapper = component.get("v.CreateOneTimeChargePriceWrapper");
        var pricelistEid = component.get("v.pricelist");
        var action = component.get("c.createOneTimeProductPrice"); 
        console.log('Wrapper::::::::::'+JSON.stringify(createOneTimeChargePriceWrapper));       
        action.setParams({
            createProductPriceWrapperString : JSON.stringify(createOneTimeChargePriceWrapper),
            priceListId : component.get("v.pricelist")
        });
        action.setCallback(this, function(response){     
            var state = response.getState();
            if(state === "SUCCESS"){
                var message = response.getReturnValue();
                console.log('message::::::::::'+message);
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
                    document.getElementById("showErrorOneTimePriceCreation").style.display = "block";
                }
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorOneTimePriceCreation").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorOneTimePriceCreation").style.display = "block";
                }
            }           
        });  
        $A.enqueueAction(action);
    }
})