({
	createOpporunityProductCmp : function(component, event, helper) {
		$A.createComponent(
        "c:OpporunityProductCmp",
        {
         "oppId" : component.get("v.oppId")
        },
        function(newCmp){
	        if (component.isValid()) {
	            component.set("v.body", newCmp);
	        }
        });
	}
})