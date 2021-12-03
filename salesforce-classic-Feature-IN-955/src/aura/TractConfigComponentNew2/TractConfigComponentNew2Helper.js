({
    getBillingWrap : function(component, event, helper) {
        var action = component.get("c.getGTVBillingWrap");
        action.setCallback(this, function(response){
            var state = response.getState();
            var gtvBillingWrap = response.getReturnValue();
            if(gtvBillingWrap.batchTriggered == true){
                component.set("v.likedisable",true);
                 document.getElementById("showMessageTractConfig").style.display = "block";
                component.set("v.message", 'A sync is already in progress, please wait until it completes.');
            }
            component.set("v.billingWrapper", gtvBillingWrap);
            component.set("v.accountMappingWrapper",gtvBillingWrap.accountMappingWrapper);
            component.set("v.accountValuesMap",gtvBillingWrap.accountMappingWrapper.mapOfNamesVsFieldValues);
            component.set("v.accountStatusMap",gtvBillingWrap.accountMappingWrapper.mapOfNamesVsStatus);
            component.set("v.conditionValuesMap",gtvBillingWrap.accountMappingWrapper.mapOfConditionVsValues);
            if(gtvBillingWrap.changeOrderIndicator != undefined){
                this.handleChangeOrderIndicatorHelper(component, event, helper);
            }
        });  
        $A.enqueueAction(action); 
    },

    getPermissionSetWrapList : function(component, event, helper) {
        var action = component.get("c.getPermissionSetList");
        action.setCallback(this, function(response){
            var state = response.getState();
            var permissionSetList = response.getReturnValue();
            component.set("v.permissionSetWrapperList", permissionSetList);
        });          
        $A.enqueueAction(action); 
    },


    validatePermissionSet : function(component, event, helper,permissionName) {
        var action = component.get("c.validatelist");   
        action.setParams({ permissionSetName : permissionName });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('statePermission::::::::'+state);
            var res=response.getReturnValue();
            console.log('res::::::::'+res);
            if(res== 'No permission set with the given name!')
            {
                console.log('In Console');
                //var toastEvent = $A.get("e.force:showToast");
                //toastEvent.setParams
                sforce.one.showToast({
                    title: "Error!",
                    message: "No Permission Set with the name '"+permissionName+"' exists!", 
                    type: "error"
                });
                //toastEvent.fire();
                console.log('In Console End');   
                //component.set("v.setmessage",'error');
            }
            if(res== 'NA' || res=='No error')
            { 
            	//component.set("v.setmessage",''); 
            }
        });          
        $A.enqueueAction(action); 
    },

    syncGTVProducts : function(component, event, helper) {
        var action = component.get("c.syncTRACTInformation");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set("v.likedisable",true);
            	var errorMessage = response.getReturnValue();
	            component.set("v.message", errorMessage);
              if(errorMessage == 'A sync is in progress, please wait for 5 minutes.'){
                component.set("v.likedisable",true);
              }
	            document.getElementById("showErrorrTractConfig").style.display = "none";
	            document.getElementById("showMessageTractConfig").style.display = "block";
            }else if(state === "ERROR" ){
                var errors = response.getError();
                if(errors[0] && errors[0].message){
                    component.set("v.message", errors[0].message);
                    document.getElementById("showErrorrTractConfig").style.display = "block";
                }else if(errors[0] && errors[0].pageErrors){
                    component.set("v.message", errors[0].pageErrors[0].message);
                    document.getElementById("showErrorrTractConfig").style.display = "block";
                }
            }
        });  
        $A.enqueueAction(action); 
    },

    saveGtvBillingWrap : function(component, event, helper) {
        var gtvWrapper = component.get("v.billingWrapper");
        var action = component.get("c.submit");
        action.setParams({
            gtvBillingWrap : JSON.stringify(gtvWrapper) 
        });
        action.setCallback(this, function(response){
            var errorMessage = response.getReturnValue();
            component.set("v.message", errorMessage);
            if(errorMessage == 'GTV Billing Configuration saved successfully!' || errorMessage == '' || errorMessage == 'A Batch is already in progress, please wait.' ){
                component.set("v.likedisable",true);
                gtvWrapper.existingTract = false;
                component.set("v.billingWrapper", gtvWrapper);
                component.set("v.likedisable",true);
                document.getElementById("showErrorrTractConfig").style.display = "none";
                document.getElementById("showMessageTractConfig").style.display = "block"; 
            }
            else if(errorMessage == 'A Batch is already in progress, please wait.'){
                gtvWrapper.existingTract = false;
                component.set("v.billingWrapper", gtvWrapper);
                document.getElementById("showErrorrTractConfig").style.display = "none";
                document.getElementById("showMessageTractConfig").style.display = "block"; 
            }else{
                document.getElementById("showMessageTractConfig").style.display = "none";
                document.getElementById("showErrorrTractConfig").style.display = "block";
            }        
        });  
        $A.enqueueAction(action); 
    },

    updatePermissionSetList : function(component, event, helper) {
        var action = component.get("c.getupdatedPermissionSetlist");   
        var permissionSetWrapperString=JSON.stringify(component.get("v.permissionSetWrapperList"));
        console.log('permissionSetWrapperString:::::::'+permissionSetWrapperString);
        action.setParams({ permissionSetWrapperString : permissionSetWrapperString });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('State:::::'+state);
            console.log('Response:::::::'+response.getReturnValue());
        });          
        $A.enqueueAction(action); 
    },

    getRequiredEntities : function(component, event, helper) {
        var gtvWrapper = component.get("v.billingWrapper");
        var action = component.get("c.getGTVEntities");   
        action.setParams({ billingWrapperString :  JSON.stringify(gtvWrapper) });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var billingWrapper = response.getReturnValue();                
                component.set("v.billingWrapper", billingWrapper);
            }
        });          
        $A.enqueueAction(action); 
    },
    testApiConnection : function(component, event, helper,hitWhere) {
        var gtvWrapper = component.get("v.billingWrapper");
        var action = component.get("c.apiConnectionTest");   
        action.setParams({ billingWrapperString :  JSON.stringify(gtvWrapper) });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var errorMessage = response.getReturnValue();
                component.set("v.message", errorMessage);
                if(errorMessage != ''){
                    document.getElementById("showMessageTractConfig").style.display = "none";
                    document.getElementById("showErrorrTractConfig").style.display = "block";
                }
                else{
                    component.set("v.showApiVersion", false);
                    if(hitWhere !='Permissions'){
                        component.set("v.showOrderState", true);
                    }
                    else{
                        component.set("v.showPermissionSet", true); 
                    }
                    this.getRequiredEntities(component, event, helper);
                }
            }
        });          
        $A.enqueueAction(action); 
    },

    getPicklistValues:function(component, event, helper, fieldName) {
        var action = component.get("c.getPicklistValues");
        action.setParams({
            objectName: 'Opportunity',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state::::::'+state);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();   
                component.set("v.pickListValues", result);
            }
        });
        $A.enqueueAction(action);
    },

    getRecordType:function(component, event, helper){
        var action = component.get("c.getRecordType");
        action.setParams({
            objectName: 'Opportunity'
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();  
                console.log('result:::'+JSON.stringify(result));
                component.set("v.pickListValues", result);
            }
        });
        $A.enqueueAction(action);

    },
    handleChangeOrderIndicatorHelper:function(component, event, helper) {
        var billingWrapper = component.get("v.billingWrapper");
        var opportunityFieldNameVSTypeMap =  billingWrapper.opportunityFieldNameVSType;
        var changeOrderIndicator = billingWrapper.changeOrderIndicator;
        console.log('changeOrderIndicator::::::'+changeOrderIndicator);
        var changeOrderIndicatorType = opportunityFieldNameVSTypeMap[changeOrderIndicator];
        console.log('changeOrderIndicatorType::::::'+changeOrderIndicatorType);
        //component.set("v.changeOrderIndicatorValue",billingWrapper.changeOrderIndicatorValue);
        //billingWrapper.changeOrderIndicatorValue = '';
        if(changeOrderIndicator == 'RecordTypeId'){
            component.set("v.displayInputText", false);
            component.set("v.displayInputpicklist", true);
            component.set("v.displayInputCheckBox", false);
            component.set("v.displayDate", false);
            component.set("v.changeOrderIndicatorStringValue",billingWrapper.changeOrderIndicatorValue);
            helper.getRecordType(component, event, helper);
        }
        else if(changeOrderIndicatorType == 'TEXTAREA' || changeOrderIndicatorType == 'CURRENCY' || changeOrderIndicatorType == 'STRING'|| changeOrderIndicatorType == 'ID' || changeOrderIndicatorType == 'DOUBLE' ||  changeOrderIndicatorType == 'INTEGER' ||  changeOrderIndicatorType == 'REFERENCE'){
             component.set("v.displayInputText", true);
             component.set("v.displayInputpicklist", false);
             component.set("v.displayInputCheckBox", false);
             component.set("v.displayDate", false);
             component.set("v.changeOrderIndicatorValue",billingWrapper.changeOrderIndicatorValue);
        }
        else if(changeOrderIndicatorType == 'PICKLIST'){
             component.set("v.displayInputText", false);
             component.set("v.displayInputpicklist", true);
             component.set("v.displayInputCheckBox", false);
             component.set("v.displayDate", false);
             component.set("v.changeOrderIndicatorStringValue",billingWrapper.changeOrderIndicatorValue);
             helper.getPicklistValues(component, event, helper,changeOrderIndicator);
        }
        else if(changeOrderIndicatorType == 'DATE' || changeOrderIndicatorType =='DATETIME'){
             component.set("v.displayInputText", false);
             component.set("v.displayInputpicklist", false);
             component.set("v.displayInputCheckBox", false);
             component.set("v.displayDate", true); 
             var dateValue =  Date(billingWrapper.changeOrderIndicatorValue);
             component.set("v.changeOrderIndicatorDateValue",dateValue);
        }
        else if(changeOrderIndicatorType == 'BOOLEAN'){
             component.set("v.displayInputText", false);
             component.set("v.displayInputpicklist", false);
             component.set("v.displayInputCheckBox", true);
             component.set("v.displayDate", false);
             var booleanValue = Boolean(billingWrapper.changeOrderIndicatorValue);
             component.set("v.changeOrderIndicatorCheckboxValue", booleanValue);
         }   
                 
     }

    /*getopportunityFieldNameVSType: function(component, event, helper) {
        var billingWrapp = component.get("v.billingWrapper");
        var action = component.get("c.getOpportunityField");
        action.setParams({
            billingWrapper: JSON.stringify(billingWrapp)
        });
        alert('3');
        action.setCallback(this, function(response){
            alert('4')
            var state = response.getState();
            alert('5');
            if(state === 'SUCCESS'){
                console.log('Response:::::'+JSON.stringyfy(response.getReturnValue()));
                var getresponse = response.getReturnValue();
                component.set("v.opportunityFieldNameVSTypeMap",getresponse.opportunityFieldNameVSType);
            }
        });


    }*/
})