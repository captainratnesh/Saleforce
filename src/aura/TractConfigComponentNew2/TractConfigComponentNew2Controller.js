({
    doInit : function(component, event, helper) { 
        helper.getBillingWrap(component, event, helper); 
        helper.getPermissionSetWrapList(component, event, helper);
        //helper.getopportunityFieldNameVSType(component, event, helper);
        
     },

     waiting : function(component, event, helper) {
        component.set("v.hideSpinner", true);
     },

     doneWaiting : function(component, event, helper) {
        component.set("v.hideSpinner", false);
     },
     apiVersionSelection : function(component, event, helper) {
        var apiVersionselected = event.getSource().get("v.value");
        component.set("v.billingWrapper.selectedAPIVersion", apiVersionselected);
    },
    orderState : function(component, event, helper) {
        var selectedOrderState = event.getSource().get("v.value");
        component.set("v.billingWrapper.orderStatusValue", selectedOrderState);        
    },

    accountCreationStateChange : function(component, event, helper) {
        var selectedAccountCreationState = event.getSource().get("v.value");
        component.set("v.billingWrapper.accountCreationStateValue", selectedAccountCreationState);        
    },
    nextTab : function(component, event, helper) {
        var button='NextTab';
    	component.set("v.message", '');           
    	var showApiVersion = component.get("v.showApiVersion");
    	var showOrderState = component.get("v.showOrderState");
        var showPermissionSet = component.get("v.showPermissionSet"); 
        if(showApiVersion == true){
            helper.testApiConnection(component, event, helper,button);
        }
        if(showOrderState == true){
            var currencySet = component.get("v.billingWrapper.currencySet");
            var regexExpression = /^[A-Z]+$/;
            if(!$A.util.isEmpty(currencySet)){
                var currency = currencySet.split(",");
                for(var x in currency){
                    if(currency[x].trim().length != 3 || !currency[x].trim().match(regexExpression)){
                        component.set("v.message", "GTV Currency field can only contain a CSV list of ISO-3166-1 Alpha 3 code values.");
                        document.getElementById("showErrorrTractConfig").style.display = "block";
                        return true;
                    }
                }
            }
            var gtvWrapper = component.get("v.billingWrapper");
            gtvWrapper.changeOrderIndicatorValue = undefined;
            if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorValue"))){
                gtvWrapper.changeOrderIndicatorValue = component.get("v.changeOrderIndicatorValue");
            }
            else if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorStringValue"))){
                gtvWrapper.changeOrderIndicatorValue = component.get("v.changeOrderIndicatorStringValue");
            }
            else if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorDateValue"))){
                gtvWrapper.changeOrderIndicatorValue = String(component.get("v.changeOrderIndicatorDateValue"));
            }
            else if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorCheckboxValue"))){
                gtvWrapper.changeOrderIndicatorValue = String(component.get("v.changeOrderIndicatorCheckboxValue"));
            }
            console.log('IndicatorValue:::::'+gtvWrapper.changeOrderIndicatorValue);
            if(gtvWrapper.enabledchangeOrderValue == 'Yes'){
                if($A.util.isEmpty(gtvWrapper.changeOrderIndicator) || $A.util.isEmpty(gtvWrapper.changeOrderIndicatorValue)){
                    component.set("v.message", "Please specify 'Change Order Indicator' and the 'Change Order Indicator Value'.");
                    document.getElementById("showErrorrTractConfig").style.display = "block";
                }
                else{
                    component.set("v.showApiVersion", false);
                    component.set("v.showOrderState", false);
                    component.set("v.showPermissionSet", true);
                }
            }
            else{
                component.set("v.showApiVersion", false);
                component.set("v.showOrderState", false);
                component.set("v.showPermissionSet", true);
            }
        }
    },
    prevTab : function(component, event, helper) {
    	component.set("v.message", '');            
    	var showApiVersion = component.get("v.showApiVersion");
    	var showOrderState = component.get("v.showOrderState");
    	var showPermissionSet = component.get("v.showPermissionSet");
        if(showOrderState == true){
            component.set("v.showApiVersion", true);
            component.set("v.showOrderState", false);
            component.set("v.showPermissionSet", false);
        }
        if(showPermissionSet == true){
            component.set("v.showApiVersion", false);
            component.set("v.showOrderState", true);
            component.set("v.showPermissionSet",false);
        }
    },

    onPermissionSetChange : function(component, event, helper) {
        var permissionName = event.getSource().get('v.value');
        helper.validatePermissionSet(component, event, helper,permissionName); 
    },

    syncGtvDetail : function(component, event, helper) {
        helper.syncGTVProducts(component, event, helper);  
    },
    saveGtvDetail : function(component, event, helper) {
        var currencySet = component.get("v.billingWrapper.currencySet");
        var regexExpression = /^[A-Z]+$/;
        if(!$A.util.isEmpty(currencySet)){
            var currency = currencySet.split(",");
            for(var x in currency){
                if(currency[x].trim().length != 3 || !currency[x].trim().match(regexExpression)){
                    component.set("v.message", "GTV Currency field can only contain a CSV list of ISO-3166-1 Alpha 3 code values.");
                    document.getElementById("showErrorrTractConfig").style.display = "block";
                    return true;
                }
            }
        }
        var gtvWrapper = component.get("v.billingWrapper");
        gtvWrapper.changeOrderIndicatorValue = undefined;
        if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorValue"))){
            gtvWrapper.changeOrderIndicatorValue = component.get("v.changeOrderIndicatorValue");
        }
        else if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorStringValue"))){
            gtvWrapper.changeOrderIndicatorValue = component.get("v.changeOrderIndicatorStringValue");
        }
        else if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorDateValue"))){
            gtvWrapper.changeOrderIndicatorValue = String(component.get("v.changeOrderIndicatorDateValue"));
        }
        else if(!$A.util.isEmpty(component.get("v.changeOrderIndicatorCheckboxValue"))){
            gtvWrapper.changeOrderIndicatorValue = String(component.get("v.changeOrderIndicatorCheckboxValue"));
        }
        console.log('indicatorValue:::::'+gtvWrapper.changeOrderIndicatorValue);
        if(gtvWrapper.enabledchangeOrderValue == 'Yes'){
            if($A.util.isEmpty(gtvWrapper.changeOrderIndicator) || $A.util.isEmpty(gtvWrapper.changeOrderIndicatorValue)){
                component.set("v.message", "Please specify 'Change Order Indicator' and the 'Change Order Indicator Value'.");
                document.getElementById("showErrorrTractConfig").style.display = "block";
            }
            else{
                helper.saveGtvBillingWrap(component, event, helper);  
                helper.updatePermissionSetList(component, event, helper);   
            }
        }
        else{
            helper.saveGtvBillingWrap(component, event, helper);  
            helper.updatePermissionSetList(component, event, helper);   
        }
        
    },
	callFieldName:function(component, event, helper) {
        
		var getMapStatus = component.get("v.accountStatusMap");
		var fieldValue = component.get("v.accountMappingWrapper");
		var getMapCondition = component.get("v.conditionValuesMap");
		var getMapField = component.get("v.accountValuesMap");
		//console.log('fieldValue:::::'+JSON.stringify(fieldValue));
		//let menu = document.querySelector('#test');

		/*let menu = event.getSource().get("v.class");
		console.log('menu:::::'+menu);*/
        let menu = event.getSource().get("v.class");
        console.log('menu:::::'+menu);
		component.set("v.currentField",menu);
		fieldValue.accountStatusValue = getMapStatus[menu];
		fieldValue.selectedConditionsValue = getMapCondition[menu];
		fieldValue.selectedFieldValue = getMapField[menu];
		/*if(document.getElementById("showErrorrAccountMap").style.display == "block" || document.getElementById("showMessageAccountMap").style.display == "block"){
			document.getElementById("showErrorrAccountMap").style.display = "none";
			document.getElementById("showMessageAccountMap").style.display = "none";
		}*/
		$A.createComponent(
			
            "c:FieldShowCmp",{
				"accountMapWrapper":fieldValue
				//"FieldValue":fieldValue
			},
            
            function(newComponent, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newComponent);
                    component.set("v.body", body);
                }
            }
		);
    },
    handleFieldShowReturn:function(component, event, helper) {
		var getCurrentField = component.get("v.currentField");
		var getMapStatus = component.get("v.accountStatusMap");
		var getMapField = component.get("v.accountValuesMap");
		var getMapCondition = component.get("v.conditionValuesMap");
		var getField = event.getParam("thisField");
		var getWrap = event.getParam("selectedConditionAndValue");
		var accWrap =  event.getParam("accWrapper");
		
		getMapStatus[getCurrentField]=accWrap.accountStatusValue;
		getMapField[getCurrentField]=getField;
		getMapCondition[getCurrentField] = getWrap;
		component.set("v.accountValuesMap",getMapField);
		component.set("v.conditionValuesMap",getMapCondition);
		component.set("v.accountStatusMap",getMapStatus);
		accWrap.mapOfNamesVsStatus = getMapStatus;
		accWrap.mapOfNamesVsFieldValues = getMapField;
		accWrap.mapOfConditionVsValues = getMapCondition;
		
        component.set("v.accountMappingWrapper", accWrap);
        component.set("v.billingWrapper.accountMappingWrapper",accWrap);
        console.log('v.billingWrapper:::'+JSON.stringify(component.get("v.billingWrapper")));

    },
    connectivity:function(component, event, helper) {
        component.set("v.showApiVersion", true);
        component.set("v.showOrderState", false);
        component.set("v.showPermissionSet", false);
    },
    gtvMapping:function(component, event, helper) {
        var button='DataMap';
        if(component.get("v.showApiVersion") == true){
            helper.testApiConnection(component, event, helper,button);
        }
        else{
            component.set("v.showOrderState", true);
            component.set("v.showApiVersion", false);
            component.set("v.showPermissionSet", false);
        }
       

    },
    accessibility:function(component, event, helper) {
        var button='Permissions';
        if(component.get("v.showApiVersion") == true){
            helper.testApiConnection(component, event, helper,button);
        }
        else{
            component.set("v.showPermissionSet", true);
            component.set("v.showApiVersion", false);
            component.set("v.showOrderState", false);
        }
        
    },
    handleChangeOrderIndicator:function(component, event, helper) {
       var billingWrapper = component.get("v.billingWrapper");
       var opportunityFieldNameVSTypeMap =  billingWrapper.opportunityFieldNameVSType;
       var changeOrderIndicator = billingWrapper.changeOrderIndicator;
       console.log('changeOrderIndicator::::::'+changeOrderIndicator);
       var changeOrderIndicatorType = opportunityFieldNameVSTypeMap[changeOrderIndicator];
       console.log('changeOrderIndicatorType::::::'+changeOrderIndicatorType);
       //billingWrapper.changeOrderIndicatorValue = undefined;
       component.set("v.changeOrderIndicatorStringValue",undefined);
       component.set("v.changeOrderIndicatorDateValue",undefined);
       component.set("v.changeOrderIndicatorCheckboxValue", undefined);
       component.set("v.billingWrapper.changeOrderIndicatorValue", undefined);
       component.set("v.changeOrderIndicatorValue",undefined);
       console.log( component.get("v.changeOrderIndicatorStringValue"));
        if(changeOrderIndicator == 'RecordTypeId'){
            component.set("v.displayInputText", false);
            component.set("v.displayInputpicklist", true);
            component.set("v.displayInputCheckBox", false);
            component.set("v.displayDate", false);
            helper.getRecordType(component, event, helper);
        }
       else if(changeOrderIndicatorType == 'TEXTAREA' || changeOrderIndicatorType == 'CURRENCY' || changeOrderIndicatorType == 'STRING'|| changeOrderIndicatorType == 'ID' || changeOrderIndicatorType == 'DOUBLE' ||  changeOrderIndicatorType == 'INTEGER' ||  changeOrderIndicatorType == 'REFERENCE' || changeOrderIndicatorType == 'PERCENT'){
            component.set("v.displayInputText", true);
            component.set("v.displayInputpicklist", false);
            component.set("v.displayInputCheckBox", false);
            component.set("v.displayDate", false);
       }
       else if(changeOrderIndicatorType == 'PICKLIST'){
            component.set("v.displayInputText", false);
            component.set("v.displayInputpicklist", true);
            component.set("v.displayInputCheckBox", false);
            component.set("v.displayDate", false);
            helper.getPicklistValues(component, event, helper,changeOrderIndicator);
       }
       else if(changeOrderIndicatorType == 'DATE' || changeOrderIndicatorType =='DATETIME'){
            component.set("v.displayInputText", false);
            component.set("v.displayInputpicklist", false);
            component.set("v.displayInputCheckBox", false);
            component.set("v.displayDate", true);
       }
       else if(changeOrderIndicatorType == 'BOOLEAN'){
            component.set("v.displayInputText", false);
            component.set("v.displayInputpicklist", false);
            component.set("v.displayInputCheckBox", true);
            component.set("v.displayDate", false);
            component.set("v.changeOrderIndicatorCheckboxValue", false);
        }  
       
    },

    /*onCheck:function(component, event, helper){
        console.log('checkBox::::'+component.find('checkboxChangeOrder').get("v.checked"));
        component.set("v.changeOrderIndicatorCheckboxValue",component.find('checkboxChangeOrder').get("v.checked"));

    },

    handleDateChange:function(component, event, helper){
        var selectedDate = event.getSource().get("v.value");
        console.log('checkBox::::'+component.find('DateChangeOrder').get("v.value"));
        console.log('selectedDate:::::::'+selectedDate);
        component.set("v.changeOrderIndicatorValue",selectedDate);
    },

    handleTextChange:function(component, event, helper){
        var inputText = event.getSource().get("v.value");
        console.log('inputText:::::'+inputText);
        console.log('inputText::::'+component.find('inputChangeOrder').get("v.value"));
        component.set("v.changeOrderIndicatorStringValue",inputText);
    }*/
    
})