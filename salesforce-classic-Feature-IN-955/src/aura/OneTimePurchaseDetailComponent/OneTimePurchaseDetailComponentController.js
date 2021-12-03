({
    doinit: function(component, event, helper) {
        var creditAdjustmentList = component.get("v.creditAdjustmentList");
        console.log('Adjustment1::::'+JSON.stringify(component.get("v.creditAdjustmentList")));
        var orderItemWrap = component.get("v.OrderItemWrapper");
        var adjustmentList = [];
        for(var i in creditAdjustmentList){
            if(creditAdjustmentList[i].orderItemId == orderItemWrap.id){
                adjustmentList.push(creditAdjustmentList[i]);
            }
        }
        component.set("v.creditAdjustmentList",adjustmentList);
        console.log('Adjustment::::'+JSON.stringify(component.get("v.creditAdjustmentList")));
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})