({
    doinit : function(component, event, helper) {      
        //helper.fetchFields(component, event, helper);
        
        var conts =component.get("v.accountMapWrapper");
        component.set("v.fieldMap", conts.mapOfNamesVsVales);
        component.set("v.lstKey", helper.processListing(component, event, conts.mapOfNamesVsVales));
        component.set("v.ObjectFieldMap", conts.mapOfFieldNameOfObject);
        component.set("v.ObjectList", helper.processListing(component, event, conts.mapOfFieldNameOfObject));
        var thisField = conts.selectedFieldValue.split(".");
        if(conts.accountStatusValue == 'Select from the Related List'){
            component.set("v.showRelatedList", true);
            var res = conts.selectedConditionsValue.split(" ");
            console.log('res::;'+res);
            component.set("v.selectedConditionFIeldValue", res[0]);
            
            if(res[3] != undefined){
                var str = res[1] + ' '+ res[2];
                component.set("v.selectedConditions", str);
                component.set("v.selectedConditionValue", res[3]);
            }
            else{
                component.set("v.selectedConditions", res[1]);
                if(res[2] != 'undefined'){
                    component.set("v.selectedConditionValue", res[2]);
                }
            }
            component.set("v.selectedobjectFieldValue", thisField[1]);
        }
        else{
            component.set("v.selectedValue", thisField[0]);
            if(thisField[1]!=undefined){
                component.set("v.currentNumber",'1');
                helper.getFieldFromObjectInit(component, event,thisField[0], conts.mapOfNamesVsVales[thisField[0]],thisField);
            }
        }
       
    },
    waiting: function(component, event, helper) {
        //component.set("v.wait", "updating...");
        component.set("v.HideSpinner", true); 
    },
    doneWaiting: function(component, event, helper) {
        //component.set("v.wait", "");
        component.set("v.HideSpinner", false); 
    },
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    onFieldSelect: function(component, event, helper) {
        component.set("v.currentNumber","1");
        var thisvalue = component.find("FieldId").get("v.value");
        console.log('thisvalue::'+thisvalue);
        var getMap = component.get("v.fieldMap");
        if(getMap[thisvalue] != 'No'){
            component.set("v.showSecondList",true);
            component.set("v.showThirdList",false);
            component.set("v.showFourthList",false);
            helper.getFieldFromObject(component, event,thisvalue,getMap[thisvalue]);
        }
        else{
            component.set("v.showSecondList",false);
            component.set("v.showThirdList",false);
            component.set("v.showFourthList",false);
            component.set("v.selectedValue2",'');
            component.set("v.selectedValue3",'');
            component.set("v.selectedValue4",'');
        }
        
    },
    onFieldSelect2: function(component, event, helper) {
        component.set("v.currentNumber","2");
        var thisvalue = component.find("FieldId2").get("v.value");
        var getMap = component.get("v.fieldMap2");
        if(getMap[thisvalue] != 'No'){
            component.set("v.showThirdList",true);
            component.set("v.showFourthList",false);
            helper.getFieldFromObject(component, event,thisvalue,getMap[thisvalue]);
        }
        else{
            component.set("v.showThirdList",false);
            component.set("v.showFourthList",false);
            component.set("v.selectedValue3",'');
            component.set("v.selectedValue4",'');
        }
        
    },
    onFieldSelect3: function(component, event, helper) {
        component.set("v.currentNumber","3");
        var thisvalue = component.find("FieldId3").get("v.value");
        var getMap = component.get("v.fieldMap3");
        if(getMap[thisvalue] != 'No'){
            component.set("v.showFourthList",true);
            helper.getFieldFromObject(component, event,thisvalue,getMap[thisvalue]);
        }
        else{
            component.set("v.showFourthList",false);
            component.set("v.selectedValue4",'');
        }
        
    },
    selectedChoice:function(component, event, helper){
        var selectedConditionAndValue = component.get("v.selectedConditionFIeldValue");
        var accWrap = component.get("v.accountMapWrapper");
        
        if(!component.get("v.showRelatedList")){
            var fieldToMap = component.get("v.selectedValue");
            selectedConditionAndValue = '';
            
        }
        else{
            var fieldToMap = component.get("v.selectedobject");
            fieldToMap = fieldToMap+'.'+component.get("v.selectedobjectFieldValue");
            selectedConditionAndValue = selectedConditionAndValue +' ' +component.get("v.selectedConditions");
            console.log('selectedConditionValue:::'+component.get("v.selectedConditionValue"));
            if(component.get("v.selectedConditionValue")!='' && component.get("v.selectedConditionValue")!=undefined){
                selectedConditionAndValue = selectedConditionAndValue + ' ' + component.get("v.selectedConditionValue");
            }
            else{
                selectedConditionAndValue='';
            }
        }
        console.log('selectedConditionAndValue:::'+selectedConditionAndValue);
        if(component.get("v.showSecondList") == true){
            fieldToMap = fieldToMap+'.' +component.get("v.selectedValue2");
        }
        
        if(component.get("v.showThirdList") == true){
            fieldToMap = fieldToMap+'.' +component.get("v.selectedValue3");
        }
        if(component.get("v.showFourthList") == true){
            fieldToMap = fieldToMap+'.' +component.get("v.selectedValue4");
        }
        var updateEvent = $A.get("e.c:FieldShowHandle");
        updateEvent.setParams({
            "thisField":fieldToMap,
            "selectedConditionAndValue":selectedConditionAndValue,
            "accWrapper":accWrap
        });
        updateEvent.fire();
        component.destroy();
    },
    accountStateChange:function(component, event, helper){
        var chanegEvent = event.getSource().get('v.value');
        if(chanegEvent == 'Select from the Same Record'){
            component.set('v.showRelatedList',false);
        }
        else{
            component.set('v.showRelatedList',true);
        }
        component.set("v.selectedValue",'Name');
        component.set("v.selectedobjectFieldValue",'Name');
        component.set("v.showSecondList",false);
        component.set("v.showThirdList",false);
        component.set("v.showFourthList",false);
    },
    onObjectChange:function(component, event, helper){
        var chanegEvent = event.getSource().get('v.value');
        console.log('chanegEvent::'+chanegEvent);
        component.set("v.selectedobjectFieldValue",'Name');
        component.set("v.showSecondList",false);
        component.set("v.showThirdList",false);
        component.set("v.showFourthList",false);
        component.set("v.selectedValue2",'');
        component.set("v.selectedValue3",'');
        component.set("v.selectedValue4",'');
        helper.getThisObjectFields(component, event, chanegEvent);
    },
    onFieldSelectObject:function(component, event, helper) {
        //console.log('getMap:::::'+JSON.stringify(component.get("v.ObjectFieldMap")));
        var thisvalueObject = component.find("FieldIdObjectThis").get('v.value');
        var getMap = component.get("v.ObjectFieldMap");
        if(getMap[thisvalueObject] != 'No'){
            component.set("v.showSecondList",true);
            helper.getFieldFromObject(component, event,thisvalueObject,getMap[thisvalueObject]);
        }
        else{
            component.set("v.showSecondList",false);
            component.set("v.showThirdList",false);
            component.set("v.showFourthList",false);
            component.set("v.selectedValue2",'');
            component.set("v.selectedValue3",'');
            component.set("v.selectedValue4",'');
        }
        
    }

})