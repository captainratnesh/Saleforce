({
	doinit : function(component, event, helper) {
        helper.getAccEntityList(component, event, helper);		
    },
    onCurrenChange : function(component, event, helper) {
        var currencyValue =  component.get("v.accountWrapper.selectedCurrency");
        var accountCategoryValue =  component.get("v.accountWrapper.accountCategory");
        helper.getBillCycle(component, event, currencyValue,accountCategoryValue);
    },
    jsLoaded : function(component, event, helper) {

        var Get_getUITheme = component.get("v.getUITheme");
        console.log('Get_getUITheme:::'+component.get("v.getUITheme"));
        if(Get_getUITheme ==='Theme4d' || Get_getUITheme ==='Theme4t'){
            
            sforce.one.navigateToSObject(component.get("v.accountId"));
        }else{
            var updateEvent = $A.get("e.c:handleAccountReload");
            console.log('updateEvent:::'+updateEvent);
            updateEvent.setParams({
                "accountId": component.get("v.accountId")
            });
            updateEvent.fire();
        }
    },
    saveDetails : function(component, event, helper) {
        helper.saveAccountDetails(component, event, helper);

    },
     waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    },
    closeModalBox : function(component, event, helper) {
        component.destroy(); 
    }
})