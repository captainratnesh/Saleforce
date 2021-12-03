({
    closeModalBox : function(component, event, helper) {
        var array = component.get("v.customValueList");
        array = [];
        component.set("v.customValueList", array);
        document.getElementById("customField").style.display = "none";
        document.getElementById("customFieldBackground").style.display = "none"; 
    },
    handleConfigCustomFieldEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        component.set("v.productWrapper", productWrapper);
        helper.getCustomField(component, event, helper, productWrapper.productEid,JSON.stringify(productWrapper.serviceCustomFieldValueList));
        
    },
    saveCustomFields : function(component, event, helper) {
        var productWrapper = component.get("v.productWrapper");
        var serviceCustFieldList = component.get("v.customValueList");
        var errorOccured = false;
        var fieldArray = [];
        for(var index in serviceCustFieldList){
        	var fieldValue = serviceCustFieldList[index].value;
        	var pickListValue = serviceCustFieldList[index].serviceListTypeValue;
        	var fieldValidationType = serviceCustFieldList[index].fieldValidationType;
        	if((fieldValue != undefined && fieldValue.trim() != '') || (pickListValue != undefined && pickListValue.trim() != '')){
        		fieldArray.push(serviceCustFieldList[index]);
        	}
        	if(fieldValidationType == 'INTEGER' && isNaN(fieldValue) && fieldValue != undefined && fieldValue.trim()!= ''){
        		var fieldName = serviceCustFieldList[index].name;
        		errorOccured = true;
        		component.set("v.validationError",true);
        		component.set("v.message","Invalid Input. The expected input type for field " + fieldName + " is : Integer");
        	}
        	else if(fieldValidationType == 'BOOLEAN' && fieldValue != undefined && fieldValue.trim() != 'true' && fieldValue.trim() != 'false' && fieldValue.trim()!= ''){
        		var fieldName = serviceCustFieldList[index].name;
        		errorOccured = true;
        		component.set("v.validationError",true);
        		component.set("v.message","Invalid " + fieldName + " value. Valid values: true or false.");
        	}
        	else if((fieldValidationType == 'DECIMAL' && fieldValue != undefined && fieldValue.trim()!= '') && (isNaN(fieldValue) || fieldValue.indexOf(".") == -1 || fieldValue.split(".")[1].length == 0)){
        		var fieldName = serviceCustFieldList[index].name;
        		errorOccured = true;
        		component.set("v.validationError",true);
        		component.set("v.message","Invalid Input. The expected input type for field " + fieldName + " is :" +fieldValidationType);
        	}
        }
        
        if(!errorOccured){
        	//var customFieldList = component.get("v.customValueList");
            productWrapper.serviceCustomFieldValueList = fieldArray;
            var appEvent = $A.get("e.c:ConfigServiceCustomFieldReturnEvent");
            appEvent.setParams({"productWrapper": productWrapper});
            appEvent.fire();
            document.getElementById("customField").style.display = "none";
            document.getElementById("customFieldBackground").style.display = "none";        
            }
    }
})