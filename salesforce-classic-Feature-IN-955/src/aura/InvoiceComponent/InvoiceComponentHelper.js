({
    getInvoiceData : function(component, event, helper) {
        var inv = component.get("v.getInvoiceList");
        console.log('inv::::'+JSON.stringify(inv));
        var action = component.get("c.getInvoiceData"); 
        action.setParams({
            invoiceWrap : JSON.stringify(inv)
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var res = response.getReturnValue();
                component.set("v.invoiceData",res);
                component.set("v.invoiceItems",res.invoiceItems);
            }

        });
        $A.enqueueAction(action);
    }
})