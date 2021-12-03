({
	doinit : function(component, event, helper) {
       // var recordId = component.get("v.oppId");
       // helper.getOppProductList(component, event, helper, recordId);
        //helper.getProductDetail(component, event, helper, addedProduct, oppId);
    },
	handleOpportunityProductEvents : function(component, event, helper) {
       /*var oppId = event.getParam("oppId");
        component.set("v.oppId", oppId);
        helper.getOppProductList(component, event, helper, oppId);*/
    },
    closeModalBox : function(component, event, helper) {
        document.getElementById("oppProductList").style.display = "none";
        document.getElementById("oppProductListBacground").style.display = "none";
    
    },
    createSalesOrder : function(component, event, helper) {
        var oppId = component.get("v.oppId");
        helper.getProductList(component, event, helper,oppId);
    },
     removeProduct : function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.count;
         var oppId = component.get("v.oppId");
        var oppProduct =  component.get("v.oppProLists["+count+"]");
        helper.removeOppProduct(component, event, helper,oppProduct, oppId);
    },
    cancelBillingAccount: function(component, event, helper) {
        var Get_getUITheme = component.get("v.getUITheme");
        //if (Get_getUITheme === 'Theme4d' || Get_getUITheme === 'Theme4t') {
        //    sforce.one.navigateToSObject(component.get("v.AccountId"));
        //} 
       // else {
            window.location.href = '/' + component.get("v.oppId");
       // }
    }
     
    
})