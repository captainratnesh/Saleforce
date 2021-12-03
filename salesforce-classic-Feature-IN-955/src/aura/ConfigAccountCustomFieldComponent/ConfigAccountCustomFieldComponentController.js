({
    closeModalBox : function(component, event, helper) {
			component.destroy(); 
    },
    doInit : function(component, event, helper) {
    	helper.getCustomField(component, event, helper);
    },
    saveCustomFields : function(component, event, helper) {
		component.set("v.validationError",false);
    	component.set("v.message","");
        var accountCustFieldList = component.get("v.customValueList");
        var errorOccured = false;
        for(var index in accountCustFieldList){
        	var fieldValue = accountCustFieldList[index].value;
        	var fieldValidationType = accountCustFieldList[index].fieldValidationType;
        	if(fieldValue != undefined && fieldValue.trim() != '' && fieldValidationType == 'INTEGER'  && isNaN(fieldValue)){
        		var fieldName = accountCustFieldList[index].name;
        		errorOccured = true;
        		component.set("v.validationError",true);
        		component.set("v.message","Invalid Input. The expected input type for field " + fieldName + " is :" +fieldValidationType);
        	}
        	else if(fieldValidationType == 'BOOLEAN' && fieldValue != undefined && fieldValue.trim() != 'true' && fieldValue.trim() != 'false' && fieldValue.trim()!= ''){
        		var fieldName = accountCustFieldList[index].name;
        		errorOccured = true;
        		component.set("v.validationError",true);
        		component.set("v.message","Invalid " + fieldName + " value. Valid values: true or false.");
        	}
        	else if((fieldValidationType == 'DECIMAL' && fieldValue != undefined && fieldValue.trim() != '') && (isNaN(fieldValue) || fieldValue.indexOf(".") == -1 || fieldValue.split(".")[1].length == 0)){
        		var fieldName = accountCustFieldList[index].name;
        		errorOccured = true;
        		component.set("v.validationError",true);
        		component.set("v.message","Invalid Input. The expected input type for field " + fieldName + " is :" +fieldValidationType);
        	}
        }
        if(!errorOccured){
        	helper.saveCustomField(component, event, helper);
        }
	},

	waiting : function(component, event, helper) {
		component.set("v.HideSpinner", true);
	},
	doneWaiting : function(component, event, helper) {
			component.set("v.HideSpinner", false);
	}
	
})