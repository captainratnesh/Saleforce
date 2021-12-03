({
	doInit : function(component, event, helper) {
		var oppId=component.get("v.oppId");
        helper.idMethod(component, event, helper);
        
	},
	showTractOrder : function(component, event, helper) {
        var tractUrl = component.get("v.salesOrder").tractUrl;
        window.open(tractUrl); 
    }
})