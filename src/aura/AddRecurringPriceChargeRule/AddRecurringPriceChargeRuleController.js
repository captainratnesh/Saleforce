({
	doInit : function(component, event, helper) {
		helper.showChargeRuleModel(component, event, helper);
	},
 
    onRuleTypeChange: function(component, event, helper) {

        var usagesRuleTypeValue = component.get("v.chargeRuleWrapper").productUsageRuleListValue;
        if (usagesRuleTypeValue == "Formula") {
            document.getElementById("formulaUsagesType").style.display = "table-row";
        } else {
            document.getElementById("formulaUsagesType").style.display = "none";
            if (usagesRuleTypeValue == "Global") {
                document.getElementById("globalUsagesType").style.display = "table-row";
            } else {
                document.getElementById("globalUsagesType").style.display = "none";
            }
        }
    },

    onAllowanceChange: function(component, event, helper) {
        document.getElementById("allowanceValueList").style.display = "none";
        var allowance = component.get("v.chargeRuleWrapper").allowanceTypeListValue;
        if (allowance == "OneTime") {
            document.getElementById("prorateOnOrder").style.display = "none";
            document.getElementById("prorateOnCancel").style.display = "none";
            document.getElementById("amountValue").style.display = "table-row";
            document.getElementById("rollOver").style.display = "table-row";
        } else if (allowance == "Unlimited") {
            var usagesRuleTypeValue = component.get("v.chargeRuleWrapper").productUsageRuleListValue;
            var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
            console.log('usagesRuleTypeValue:::'+usagesRuleTypeValue);
            console.log('rateType:::'+rateType);
            if ((usagesRuleTypeValue == "Global") || ((usagesRuleTypeValue == "Match All Events" || usagesRuleTypeValue == "Formula") && rateType == "Pass Through")) {
                document.getElementById("allowanceValueList").style.display = "block";
            }
            document.getElementById("prorateOnOrder").style.display = "none";
            document.getElementById("prorateOnCancel").style.display = "none";
            document.getElementById("amountValue").style.display = "none";
            document.getElementById("rollOver").style.display = "none";
        } else {
            document.getElementById("prorateOnOrder").style.display = "table-row";
            document.getElementById("prorateOnCancel").style.display = "table-row";
            document.getElementById("amountValue").style.display = "table-row";
            document.getElementById("rollOver").style.display = "table-row";
        }
    },
    onRateTypeChange: function(component, event, helper) {

        var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
        if (rateType == "Table Rate") {
            document.getElementById("flatRateType").style.display = "none";
            document.getElementById("passthroughRateType").style.display = "none";
            document.getElementById("tableRateType").style.display = "table-row";

        } else if (rateType == "Pass Through") {
            document.getElementById("tableRateType").style.display = "none";
            document.getElementById("flatRateType").style.display = "none";
            document.getElementById("passthroughRateType").style.display = "table-row";
        } else {
            document.getElementById("tableRateType").style.display = "none";
            document.getElementById("passthroughRateType").style.display = "none";
            document.getElementById("flatRateType").style.display = "table-row";
        }
    },
    onSpecificationChange: function(component, event, helper) {
        var usageRuleSpecification = component.get("v.chargeRuleWrapper").formulaUsageRuleListValue;
    },
    closeModalBox:function(component, event, helper) {
        component.destroy();
    },    
    addChargeRules: function(component, event, helper) {
        component.set("v.HideSpinner", true);    
        var specificationValue = component.find("specificationValue");
        var formulaFieldType = component.find("formulaFieldType");
        var field = component.find("operationValue");
        var productUsageRule = component.get("v.chargeRuleWrapper").productUsageRuleListValue;
        var formulaFieldValue = component.get("v.chargeRuleWrapper").formulaFieldValue;
        var fieldValue = component.get("v.chargeRuleWrapper").activityFormulaValue;
        var formulaUsageRuleListValue = component.get("v.chargeRuleWrapper").formulaUsageRuleListValue;

        var charges = component.find("chargesValueFlat");
        var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
        var chargesValue = component.get("v.chargeRuleWrapper").chargesPicklistValue;

        var ammountUnit = component.find("ammountValues");
        var ammount = component.find("ammount");
        var allowance = component.get("v.chargeRuleWrapper").allowanceTypeListValue;
        var ammountUnitValue = component.get("v.chargeRuleWrapper").amountChargePickList;
        var ammountValue = component.get("v.chargeRuleWrapper").ammountValue;

        var rateType = component.get("v.chargeRuleWrapper").rateTypeListValue;
        var ruleName = component.find("chargeRuleName");
        var ruleNameValue = component.get("v.chargeRuleWrapper").serviceUsageRuleName;

        var chargeCat = component.find("chargeCat");
        var chargeCatValue = component.get("v.chargeRuleWrapper").chargeCategoryListValue;

        var rollOverCmp = component.find("chargesValue");
        var rollOverValue = component.get("v.chargeRuleWrapper").roleOverListValue;

        var chargeValueComponent = component.find("chargeName");
        var chargeValue = component.get("v.chargeRuleWrapper").chargeValue;

        if (chargeValue != undefined && isNaN(chargeValue)) {
            chargeValueComponent.set("v.errors", [{
                message: "Please enter a valid numeric value."
            }]);
            component.set("v.HideSpinner", false);
        } else if (ammountValue != undefined && isNaN(ammountValue)) {
            ammount.set("v.errors", [{
                message: "Please enter a valid numeric value."
            }]);
            component.set("v.HideSpinner", false);
        } else if (ruleNameValue == " ") {
            ruleName.set("v.errors", [{
                message: "Name is required."
            }]);
            component.set("v.HideSpinner", false);
        } else {
            ruleName.set("v.errors", [{
                message: null
            }]);
            if (chargeCatValue == " ") {
                chargeCat.set("v.errors", [{
                    message: "Charge Category is required."
                }]);
                component.set("v.HideSpinner", false);
            } else {
                chargeCat.set("v.errors", [{
                    message: null
                }]);
                if (chargesValue == " " && rateType == "Flat") {
                    charges.set("v.errors", [{
                        message: "Charge Unit Type is required."
                    }]);
                    component.set("v.HideSpinner", false);
                } else {
                    charges.set("v.errors", [{
                        message: null
                    }]);
                    
                    if (allowance != "Unlimited" && (ammountUnitValue == " "||ammountUnitValue==undefined)) {
                        ammountUnit.set("v.errors", [{
                            message: "Amount Unit Type is required."
                        }]);
                        component.set("v.HideSpinner", false);
                    } else {
                        ammountUnit.set("v.errors", [{
                            message: null
                        }]);
                        if (allowance != "Unlimited" && ammountValue == 0) {
                            ammount.set("v.errors", [{
                                message: "Amount is required if Allowance is not unlimited."
                            }]);
                            component.set("v.HideSpinner", false);
                        } else {
                            ammount.set("v.errors", [{
                                message: null
                            }]);
                            if (formulaFieldValue == " " && productUsageRule == "Formula") {
                                formulaFieldType.set("v.errors", [{
                                    message: "Field is required."
                                }]);
                                component.set("v.HideSpinner", false);
                            } else {
                                formulaFieldType.set("v.errors", [{
                                    message: null
                                }]);
                                if (fieldValue == " " && productUsageRule == "Formula") {
                                    field.set("v.errors", [{
                                        message: "Field Value is required."
                                    }]);
                                    component.set("v.HideSpinner", false);
                                } else {
                                    field.set("v.errors", [{
                                        message: null
                                    }]);
                                    if (formulaUsageRuleListValue == " " && productUsageRule == "Global") {
                                        specificationValue.set("v.errors", [{
                                            message: "Formula Usage Rule Specification is required."
                                        }]);
                                        component.set("v.HideSpinner", false);
                                    } else {
                                        specificationValue.set("v.errors", [{
                                            message: null
                                        }]);
                                        if (allowance != "Unlimited" && rollOverValue === '') {
                                            component.set("v.message", "Roll Over value is required.");
                                            document.getElementById("showErrorrAddActivity").style.display = "block";
                                            component.set("v.HideSpinner", false);
                                        } else {
                                            component.set("v.message", "NoError");
                                            helper.addChargeRulesHelper(component, event, helper);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    },

     waiting: function(component, event, helper) {
        component.set("v.HideSpinner", true);
    },
    doneWaiting: function(component, event, helper) {
        component.set("v.HideSpinner", false);
    }
})