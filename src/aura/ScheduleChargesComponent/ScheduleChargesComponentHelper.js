({
    saveScheduleCharge : function(component, event, helper) {
        var schdulerList = component.get("v.schdulerList");
        var productWrapper = component.get("v.productWrapper");
        var quantity = productWrapper.quantity;
        var totelPrice = (productWrapper.oneTimePrice)*quantity;
        var prodEid = productWrapper.prod.eid__c;
        var action = component.get("c.saveScheduleCharges");        
        action.setParams({
            listOfFilledScheduledCharges : JSON.stringify(schdulerList),
            oneTimevalue : totelPrice,
            productEid : prodEid,
            oppId : component.get("v.oppId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var errorMessage = response.getReturnValue();
                if(errorMessage == "NoError"){
                    productWrapper.scheduleChargeList = schdulerList;
                    var appEvent = $A.get("e.c:ScheduleChargeReturnEvent");
                    appEvent.setParams({"productWrapper": productWrapper});
                    appEvent.fire();
                    component.destroy(); 
                }else{
                    component.set("v.message", errorMessage);
                    document.getElementById("showErrorCharges").style.display = "block";
                }
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorCharges").style.display = "block";
                }else if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorCharges").style.display = "block";
                }
            }
        });  
        $A.enqueueAction(action);
    },
    ConfigureServiceCharge:function(component, event, helper, qty, amt, dateToday){
        var action = component.get("c.configureScheduleCharges");        
        action.setParams({
            amount : amt.toString(),
            dateToday: dateToday.toString()   
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var ScheduleWrapper = response.getReturnValue();
            }  
            component.set("v.totalPrice",amt);                
            var schdulerList = component.get("v.schdulerList");
            schdulerList = [];
            schdulerList.push(ScheduleWrapper);
            component.set("v.schdulerList",schdulerList ); 
        });
        $A.enqueueAction(action);
    },
    
    checkError:function(scheduleChargesList){
        var errorMessage = '';
        var scheduleChargesLength = scheduleChargesList.length;
        for(var i=0;i<scheduleChargesLength;i++){
            var index = eval(i)+1;
            var scheduleChargeWrapper = scheduleChargesList[i];
            if(scheduleChargeWrapper.schdeuleAmount == undefined || scheduleChargeWrapper.schdeuleAmount == null || scheduleChargeWrapper.schdeuleAmount == '' ){
                if(errorMessage == ''){
                    errorMessage = 'Error in Charge '+index+': Charge Amount is required.\n';
                }
                else{
                    errorMessage += 'Error in Charge '+index+': Charge Amount is required.\n';
                }
            }

            if(scheduleChargeWrapper.schdeuleDescription == undefined || scheduleChargeWrapper.schdeuleDescription == null || scheduleChargeWrapper.schdeuleDescription == '' ){
                if(errorMessage == ''){
                    errorMessage = 'Error in Charge '+index+': Charge Description is required.\n';
                }
                else{
                    errorMessage += 'Error in Charge '+index+': Charge Description is required.\n';
                }
            }

            if(scheduleChargeWrapper.schdeuleDate == undefined || scheduleChargeWrapper.schdeuleDate == null || scheduleChargeWrapper.schdeuleDate == '' ){
                if(errorMessage == ''){
                    errorMessage = 'Error in Charge '+index+': Charge Date is required.\n';
                }
                else{
                    errorMessage += 'Error in Charge '+index+': Charge Date is required.\n';
                }
            }
        }
        return errorMessage;
    }
   })