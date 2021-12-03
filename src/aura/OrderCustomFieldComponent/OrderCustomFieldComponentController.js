({
    closeModalBox : function(component, event, helper) {
        component.destroy();       
        /*
        document.getElementById("orderCustomField").style.display = "none";
        document.getElementById("orderCustomFieldBackground").style.display = "none"; */
    },
    doinit : function(component, event, helper) {
        //var oppId = event.getParam("oppId");
        // component.set("v.oppId");
        helper.getCustomField(component, event, helper);
        
    },
    saveCustomFields : function(component, event, helper) {
        var orderCustomFields = component.get("v.customValueList");    
        for(var i in orderCustomFields){
            var validationType = orderCustomFields[i].fieldValidationType;
            var fieldValue = orderCustomFields[i].value;
            if(validationType === "DATE" && orderCustomFields[i].dateField != null){
                orderCustomFields[i].value = $A.localizationService.formatDate(orderCustomFields[i].dateField.toString(), "dd/MM/yyyy")                
                //orderCustomFields[i].Value = orderCustomFields[i].dateField.toString();
            }
            if(validationType == "CUSTOM" && orderCustomFields[i].serviceListTypeValue != null){
                orderCustomFields[i].value = orderCustomFields[i].serviceListTypeValue.toString();
            }
            if(validationType == "INTEGER" && isNaN(fieldValue) && fieldValue != undefined && fieldValue.trim() != ""){
                var fieldName = orderCustomFields[i].name;
                component.set("v.validationError",true);
                component.set("v.message","Invalid Input. The expected input type for field " + fieldName + " is : Integer");
            }
            else if(validationType == "BOOLEAN" && fieldValue != undefined && fieldValue.trim() != "true" && fieldValue.trim() != "false" && fieldValue.trim() != ""){
                var fieldName = orderCustomFields[i].name;
                component.set("v.validationError",true);
                component.set("v.message","Invalid " + fieldName + " value. Valid values: true or false.");
            }
        }
        helper.saveCustomField(component, event, helper);
    }
})