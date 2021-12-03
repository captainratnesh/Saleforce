({
    fetchFields : function(component, event, helper) {
        console.log('I am here agian');
        var action = component.get("c.showFieldList");   
            action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {     
                var conts = response.getReturnValue();
                /*component.set("v.accountMapWrapper", conts);
                component.set("v.fieldMap", conts.mapOfNamesVsVales);
                component.set("v.lstKey", this.processListing(component, event, conts.mapOfNamesVsVales));
                component.set("v.ObjectFieldMap", conts.mapOfFieldNameOfObject);
                component.set("v.ObjectList", this.processListing(component, event, conts.mapOfFieldNameOfObject));
            */
            } 
        });           
        $A.enqueueAction(action);
    },
    getFieldFromObject:function(component, event, field,ObjectName) {
        var action = component.get("c.getObjectFieldValue"); 
        action.setParams({
            "ObjectName": ObjectName,
            "fieldName": field
        });
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {     
            console.log('CurrentNumber::::'+component.get("v.currentNumber"));
           if(component.get("v.currentNumber") === '1'){
            var conts = response.getReturnValue();
            component.set("v.fieldMap2", conts);
            component.set("v.lstKey2", this.processListing(component, event, conts));
            }
            else if(component.get("v.currentNumber") === '2'){
                var conts = response.getReturnValue();
                component.set("v.fieldMap3", conts);
                component.set("v.lstKey3", this.processListing(component, event, conts));
            }
            else if(component.get("v.currentNumber") === '3'){
                var conts = response.getReturnValue();
                component.set("v.fieldMap4", conts);
                component.set("v.lstKey4", this.processListing(component, event, conts));
            }
        } 
    });           
    $A.enqueueAction(action);
    },
    getThisObjectFields:function(component, event, thidObject){
        var action = component.get("c.getfieldsByObjectName");   
        action.setParams({
            "ObjectName": thidObject
        });
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {     
            var conts = response.getReturnValue();
            component.set("v.ObjectFieldMap",conts);
            component.set("v.ObjectList", this.processListing(component, event, conts));
        } 
    });           
    $A.enqueueAction(action);

    },
    processListing:function(component, event, contstant) {
        var arrayOfMapKeys = [];
        for (var singlekey in contstant) {
            arrayOfMapKeys.push(singlekey);
        }
        return arrayOfMapKeys;
    },
    getFieldFromObjectInit:function(component, event, field,ObjectName,thisField) {
        var getFieldMap;
        var action = component.get("c.getObjectFieldValue"); 
        action.setParams({
            "ObjectName": ObjectName,
            "fieldName": field
        });
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {     
            console.log('CurrentNumber::::'+component.get("v.currentNumber"));
           if(component.get("v.currentNumber") === '1'){
                var conts = response.getReturnValue();
                component.set("v.fieldMap2", conts);
                component.set("v.lstKey2", this.processListing(component, event, conts));
                component.set("v.selectedValue2", thisField[1]);  
                component.set("v.showSecondList",true);
                component.set("v.currentNumber",'2');
                getFieldMap = component.get("v.fieldMap2");
                this.getFieldFromObjectInit(component, event,thisField[1], getFieldMap[thisField[1]],thisField);
            }
            else if(component.get("v.currentNumber") === '2'){
                var conts = response.getReturnValue();
                component.set("v.fieldMap3", conts);
                component.set("v.lstKey3", this.processListing(component, event, conts));
                component.set("v.selectedValue3", thisField[2]);  
                component.set("v.showThirdList",true);
                component.set("v.currentNumber",'3');
                getFieldMap = component.get("v.fieldMap3");
                this.getFieldFromObjectInit(component, event,thisField[2], getFieldMap[thisField[2]],thisField);
            }
            else if(component.get("v.currentNumber") === '3'){
                var conts = response.getReturnValue();
                component.set("v.fieldMap4", conts);
                component.set("v.lstKey4", this.processListing(component, event, conts));
                component.set("v.selectedValue4", thisField[3]);  
                component.set("v.showFourthList",true);
            }
        }

    });           
    $A.enqueueAction(action);
    },
})