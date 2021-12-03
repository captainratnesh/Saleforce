({
    closeModalBox : function(component, event, helper) {
        component.destroy();
        /*document.getElementById("prodAddActivityChargeModal").style.display = "none";
        document.getElementById("prodBackGroundAddActivityCharge").style.display = "none";
        document.getElementById("showErrorrAddActivityProduct").style.display = "none"; */
    
    },
    doInit : function(component, event, helper) {
       var productWrapper = component.get("v.productWrapper");
        var oppId = component.get("v.oppId");
        component.set("v.productDetail", productWrapper.prod);
        component.set("v.ProductEid", productWrapper.productEid);
        component.set("v.RuleType", productWrapper.ruleType);
        helper.getChargeRules(component, event, helper);
    },
    onRuleTypeChange : function(component, event, helper) {
       var usagesRuleTypeValue = component.get("v.chargeRuleWrapper").productUsageRuleListValue;
       if(usagesRuleTypeValue == "Formula"){
           document.getElementById("formulaUsagesType").style.display = "table-row";
       }else{
           document.getElementById("formulaUsagesType").style.display = "none";
           if(usagesRuleTypeValue == "Global"){
               document.getElementById("globalUsagesType").style.display = "table-row";
           }else{
               document.getElementById("globalUsagesType").style.display = "none";
           }
       }
    },
    
    onAllowanceChange : function(component, event, helper) {
        document.getElementById("allowanceValueList").style.display = "none";
        var allowance = component.get("v.chargeRuleWrapper").allowanceTypeListValue;
         if(allowance == "OneTime"){
            document.getElementById("prorateOnOrder").style.display = "none";
            document.getElementById("prorateOnCancel").style.display = "none";
            document.getElementById("amountValue").style.display = "table-row";
            document.getElementById("rollOver").style.display = "table-row";
        }else if(allowance == "Unlimited"){
            var usagesRuleTypeValue = component.get("v.chargeRuleWrapper").productUsageRuleListValue;
            var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
            if((usagesRuleTypeValue == "Global") || ((usagesRuleTypeValue  == "Match All Events"   || usagesRuleTypeValue  == "Formula") &&  rateType  == "Pass Through")){
                document.getElementById("allowanceValueList").style.display = "block";
            } 
            document.getElementById("prorateOnOrder").style.display = "none";
            document.getElementById("prorateOnCancel").style.display = "none";
            document.getElementById("amountValue").style.display = "none"; 
            document.getElementById("rollOver").style.display = "none";
        }else{
            document.getElementById("prorateOnOrder").style.display = "table-row";
            document.getElementById("prorateOnCancel").style.display = "table-row";
            document.getElementById("amountValue").style.display = "table-row";
            document.getElementById("rollOver").style.display = "table-row";
        }
         
        
    },
    onRateTypeChange : function(component, event, helper) {
        var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
        if(rateType == "Table Rate"){
            document.getElementById("flatRateType").style.display = "none";
            document.getElementById("passthroughRateType").style.display = "none";
            document.getElementById("tableRateType").style.display = "table-row";
            
        }else if(rateType == "Pass Through"){
            document.getElementById("tableRateType").style.display = "none";
            document.getElementById("flatRateType").style.display = "none";
            document.getElementById("passthroughRateType").style.display = "table-row";
        }else{
             document.getElementById("tableRateType").style.display = "none";
             document.getElementById("passthroughRateType").style.display = "none";
             document.getElementById("flatRateType").style.display = "table-row";
        }
    },
    onSpecificationChange : function(component, event, helper) {
        var usageRuleSpecification = component.get("v.chargeRuleWrapper").formulaUsageRuleListValue;
        if(usageRuleSpecification != "Choose One"){
            document.getElementById("rateType").style.display = "none";
            document.getElementById("flatRateType").style.display = "none";
        }else{
            document.getElementById("rateType").style.display = "table-row";
            document.getElementById("flatRateType").style.display = "table-row";
        }
        
    },
    addChargeRules : function(component, event, helper) {
         var specificationValue =  component.find("specificationValue");
         var formulaFieldType =  component.find("formulaFieldType");
         var field =  component.find("operationValue");
         var productUsageRule = component.get("v.chargeRuleWrapper").productUsageRuleListValue;
         var formulaFieldValue = component.get("v.chargeRuleWrapper").formulaFieldValue;
         var fieldValue = component.get("v.chargeRuleWrapper").activityFormulaValue;
         var formulaUsageRuleListValue = component.get("v.chargeRuleWrapper").formulaUsageRuleListValue;
         var charges =  component.find("chargesValueFlat");
         var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
         var chargesValue = component.get("v.chargeRuleWrapper").chargesPicklistValue;
         var ammountUnit =  component.find("ammountValues");
         var ammount =  component.find("ammount");
         var allowance = component.get("v.chargeRuleWrapper").allowanceTypeListValue;
         var ammountUnitValue = component.get("v.chargeRuleWrapper").chargesPicklistValue2;
         var ammountValue = component.get("v.chargeRuleWrapper").ammountValue;
         var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
         var ruleName =  component.find("chargeRuleName");
         var ruleNameValue = component.get("v.chargeRuleWrapper").serviceUsageRuleName;         
         var chargeCat =  component.find("chargeCat");    
         var chargeCatValue = component.get("v.chargeRuleWrapper").chargeCategoryListValue;           
         if (ruleNameValue == " " ){
            ruleName.set("v.errors", [{message:"Name is required."}]);
         }else{
            ruleName.set("v.errors", [{message:null}]);
            if (chargeCatValue == " " ){
                chargeCat.set("v.errors", [{message:"Charge Category is required."}]);
             }else{
                chargeCat.set("v.errors", [{message:null}]);
                if (chargesValue == " " && rateType == "Flat"){
                charges.set("v.errors", [{message:"Charge Unit Type is required."}]);
                }else{
                    charges.set("v.errors", [{message:null}]);
                    if (allowance != "Unlimited" && (ammountUnitValue == " "||ammountUnitValue==undefined)){
                    ammountUnit.set("v.errors", [{message:"Amount Unit Type is required."}]);
                    }else{
                        ammountUnit.set("v.errors", [{message:null}]);
                        if (allowance != "Unlimited" && ammountValue == 0){
                            ammount.set("v.errors", [{message:"Amount is required if Allowance is not unlimited."}]);
                        }else{
                            ammount.set("v.errors", [{message:null}]);
                            if (formulaFieldValue == " " && productUsageRule == "Formula"){
                                formulaFieldType.set("v.errors", [{message:"Field is required."}]);
                            }else{
                                formulaFieldType.set("v.errors", [{message:null}]);
                                if (fieldValue == " " && productUsageRule == "Formula"){
                                    field.set("v.errors", [{message:"Field Value is required."}]);
                                }else{
                                    field.set("v.errors", [{message:null}]);
                                    if (formulaUsageRuleListValue == " " && productUsageRule == "Global"){
                                     specificationValue.set("v.errors", [{message:"Formula Usage Rule Specification is required."}]);
                                     }else{
                                        specificationValue.set("v.errors", [{message:null}]);
                                       helper.saveAddChargeRules(component, event, helper);
                                     }  
                                } 
                            } 
                        }  
                    }  
                } 
             }
         }
    }
})