({
	getAccEntityList : function(component, event, helper) {
        var action = component.get("c.getAccountEntityData");  
         action.setParams({
          accountId: component.get("v.accountId")
        }); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') { 
               var accountWrap = response.getReturnValue();
               console.log('accountWrap'+JSON.stringify(accountWrap));  
               component.set("v.accountWrapper",accountWrap);
               console.log('accountWrap.billCycleList::::'+JSON.stringify(accountWrap.billCycleList));
               console.log('accountWrap.paymentTermList::::'+JSON.stringify(accountWrap.paymentTermList));
               if(accountWrap.accountCategory != ' '){
                this.getBillCycle(component, event,accountWrap.selectedCurrency,accountWrap.accountCategory)
              }
            }
        });    
        $A.enqueueAction(action);
        
  },
  getBillCycle : function(component, event, currency, accountCategory){
    var action = component.get("c.getBillCycleData");
    action.setParams({
      currencyType : currency,
      accountCategoryEid:accountCategory
     });  
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === 'SUCCESS') { 
           var accountWrap = response.getReturnValue();  
           component.set("v.billCycleList",accountWrap);
          // helper.getOliData(component, event, helper);
        }
    });    
    $A.enqueueAction(action);

  },
  saveAccountDetails : function(component, event, helper) {
    var action = component.get("c.saveAccountDetails");
    action.setParams({
       accountId: component.get("v.accountId"),
      accountEditWrap:JSON.stringify(component.get("v.accountWrapper"))
     });  
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === 'SUCCESS') {   
          var appEvent = $A.get("e.c:ReloadAccountDetail");
          appEvent.fire();
          component.destroy();
        }
    });    
    $A.enqueueAction(action);
  }
})