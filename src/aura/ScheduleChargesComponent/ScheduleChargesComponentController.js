({
    closeModalBox : function(component, event, helper) {
        component.destroy(); 
    },
    handleScheduleChargeEvent : function(component, event, helper) {
        var productWrapper =  component.get("v.productWrapper");
        var schedulerList = productWrapper.scheduleChargeList;
        if(productWrapper.scheduleChargeList.length != 0){
            var schdList = component.get("v.schdulerList");
            for(var i in schedulerList){
                schdList.push(schedulerList[i]);
            }
            component.set("v.schdulerList",schdList);
            var quantity = productWrapper.quantity;
            var totalprice = (productWrapper.oneTimePrice)*quantity;
            component.set("v.totalPrice",totalprice);
        }else{
            var quantity = productWrapper.quantity;
            var amount = (productWrapper.oneTimePrice)*quantity;              
            var today = new Date(); 
            var todayDate = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
            helper.ConfigureServiceCharge(component, event, helper, quantity, amount,todayDate);
            
        }     
    },  
    addCharge : function(component, event, helper) {
        var schdulerList = component.get("v.schdulerList");
        schdulerList.push({});
        component.set("v.schdulerList",schdulerList );
    },
    removeCharge : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
        var schdulerList =  component.get("v.schdulerList");
        schdulerList.splice(count, 1);
        component.set("v.schdulerList",schdulerList );
    },
    
    scheduleCharge : function(component, event, helper) {
        var errorMessage = '';
        component.set("v.message",'');
        var scheduleChargesList = component.get("v.schdulerList");
        errorMessage = helper.checkError(scheduleChargesList);
        if(errorMessage != ''){
            component.set("v.message",errorMessage);
            document.getElementById("showErrorCharges").style.display = "block";
        }
        else{
            helper.saveScheduleCharge(component, event, helper);
        }
    }  
})