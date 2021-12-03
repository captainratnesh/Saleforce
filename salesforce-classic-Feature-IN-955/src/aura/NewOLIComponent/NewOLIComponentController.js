({
    doinit : function(component, event, helper) {
        console.log("recordId::::"+component.get("v.recordId"));
        helper.getOliId(component, event, helper);
    },
    closeModalBox : function(component, event, helper) {
        window.location.href='/'+ component.get("v.oppId");
    },
    saveChanges : function(component, event, helper) {
        var proWrap =  component.get("v.productWrapper");
        if(proWrap.agreementId == ' '){
            proWrap.agreementId = null;
            proWrap.agreementPeriod = null;
            proWrap.agreementEndAction = null;
            proWrap.overrideAgreementEndDate = null;
        }
        helper.saveOLiData(component, event, helper);
    },
    clickCreateAgreement : function(component, event, helper) {
        var productWrapObj = component.get("v.productWrapper");
        $A.createComponent(
            "c:AddAgreementComponent", 
            {
                "productWrapper": productWrapObj
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
    editBasicDetails : function(component, event, helper) {
        var productWrapObj = component.get("v.productWrapper");
        console.log('productWrapObj:::::::'+productWrapObj);
        $A.createComponent(
            "c:EditBasicProductDetails", 
            {
                "productWrapper": productWrapObj
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
    clickCreateServiceResource : function(component, event, helper) {
        var productWrapObj = component.get("v.productWrapper");
        $A.createComponent(
            "c:AddServiceResourceComponent", 
            {
                "productWrapper": productWrapObj
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
    clickCreateServiceCustomField : function(component, event, helper) {
        var productWrapObj = component.get("v.productWrapper");
        var appEvent = $A.get("e.c:ConfigCustomFieldEvent");
        appEvent.setParams({
            "productWrapper": productWrapObj
        });
        appEvent.fire();
        
        document.getElementById("customField").style.display = "block";
        document.getElementById("customFieldBackground").style.display = "block"; 
    },
    clickCreateScheduleCharge : function(component, event, helper) {
        var productWrapObj = component.get("v.productWrapper");
        $A.createComponent(
            "c:ScheduleChargesComponent", 
            {
                "productWrapper": productWrapObj,
                "oppId"			: component.get("v.oppId")
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
    clickAddActivityCharge : function(component, event, helper) {
        var productWrapObj = component.get("v.productWrapper");
        $A.createComponent(
            "c:AddChargeRuleProduct", 
            {
                "productWrapper": productWrapObj,  
                 "oppId": component.get("v.oppId")
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
    removeChargeRule: function(component, event, helper) {
        var selectedItem = event.currentTarget;
        var count = selectedItem.dataset.countdelete;
        helper.deleteAndRemoveChargeRule(component, event, count);
    },
    
    
    handleSelectedAgreementReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        component.set("v.productWrapper", productWrapper);
        console.log('productWrapper::::'+JSON.stringify(component.get("v.productWrapper")));
    },
    handleServiceResourceReturnAction : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        component.set("v.productWrapper", productWrapper);
        console.log('productWrapper::::'+JSON.stringify(component.get("v.productWrapper")));
    },
    handleConfigServiceCustomFieldReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        component.set("v.productWrapper", productWrapper);
        console.log('productWrapper::::'+JSON.stringify(component.get("v.productWrapper")));
    },
    handleScheduleChargeReturnEvent : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        component.set("v.productWrapper", productWrapper);
        console.log('productWrapper::::'+JSON.stringify(component.get("v.productWrapper")));
    },
    handleConfigureChargeRuleAction : function(component, event, helper) {
        var productWrapper = event.getParam("productWrapper");
        var oppId = event.getParam("oppId");
        component.set("v.oppId", oppId);
        component.set("v.productWrapper", productWrapper);
        document.getElementById("showErrorChargeRule").style.display = "none";
        helper.getOliData(component, event, helper);
    },
    handleBasicProductEdit : function(component, event, helper) {
        console.log('I am Hereeer');
        var productWrapper = event.getParam("productWrapper");
        component.set("v.productWrapper", productWrapper);
        console.log('productWrapper::::'+JSON.stringify(component.get("v.productWrapper")));
    },
    waiting : function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting : function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }

    
})