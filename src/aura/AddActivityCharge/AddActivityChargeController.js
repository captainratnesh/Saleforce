({
    closeModalBox: function(component, event, helper) {
        component.destroy();
    },
    doInit: function(component, event, helper) {
        var wrapperStr = component.get("v.wrapperString");
        if (wrapperStr != undefined && wrapperStr.trim() != '') {
            helper.getDeserializedWrapper(component, event, wrapperStr);
        } else {
            component.set("v.message", "Not a valid wrapper, please reload the page.");
            document.getElementById("showErrorrAddActivity").style.display = "block";
            component.set("v.HideSpinner", false);
        }
    },

    onRuleTypeChange: function(component, event, helper) {

        var usagesRuleTypeValue = component.get("v.prodSerWrappers").chargeRuleWrapper.productUsageRuleListValue;
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
        var allowance = component.get("v.prodSerWrappers").chargeRuleWrapper.allowanceTypeListValue;
        if (allowance == "OneTime") {
            document.getElementById("prorateOnOrder").style.display = "none";
            document.getElementById("prorateOnCancel").style.display = "none";
            document.getElementById("amountValue").style.display = "table-row";
            document.getElementById("rollOver").style.display = "table-row";
        } else if (allowance == "Unlimited") {
            var usagesRuleTypeValue = component.get("v.prodSerWrappers").chargeRuleWrapper.productUsageRuleListValue;
            var rateType = component.get("v.rateType");
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

        var rateType = component.get("v.prodSerWrappers").chargeRuleWrapper.rateTypeListValue;
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
        var usageRuleSpecification = component.get("v.prodSerWrappers").chargeRuleWrapper.formulaUsageRuleListValue;
        if (usageRuleSpecification != "Choose One") {
            document.getElementById("rateType").style.display = "none";
            document.getElementById("flatRateType").style.display = "none";
        } else {
            document.getElementById("rateType").style.display = "table-row";
            document.getElementById("flatRateType").style.display = "table-row";
        }
    },
    addChargeRules: function(component, event, helper) {
        component.set("v.HideSpinner", true);
        var specificationValue = component.find("specificationValue");
        var formulaFieldType = component.find("formulaFieldType");
        var field = component.find("operationValue");
        var productUsageRule = component.get("v.prodSerWrappers").chargeRuleWrapper.productUsageRuleListValue;
        var formulaFieldValue = component.get("v.prodSerWrappers").chargeRuleWrapper.formulaFieldValue;
        var fieldValue = component.get("v.prodSerWrappers").chargeRuleWrapper.activityFormulaValue;
        var formulaUsageRuleListValue = component.get("v.prodSerWrappers").chargeRuleWrapper.formulaUsageRuleListValue;

        var charges = component.find("chargesValueFlat");
        var rateType = component.get("v.prodSerWrappers").chargeRuleWrapper.rateTypeListValue;
        var chargesValue = component.get("v.prodSerWrappers").chargeRuleWrapper.chargesPicklistValue;

        var ammountUnit = component.find("ammountValues");
        var ammount = component.find("ammount");
        var allowance = component.get("v.prodSerWrappers").chargeRuleWrapper.allowanceTypeListValue;
        var ammountUnitValue = component.get("v.prodSerWrappers").chargeRuleWrapper.amountChargePickList;
        var ammountValue = component.get("v.prodSerWrappers").chargeRuleWrapper.ammountValue;

        var rateType = component.get("v.prodSerWrappers").chargeRuleWrapper.rateTypeListValue;
        var ruleName = component.find("chargeRuleName");
        var ruleNameValue = component.get("v.prodSerWrappers").chargeRuleWrapper.serviceUsageRuleName;

        var chargeCat = component.find("chargeCat");
        var chargeCatValue = component.get("v.prodSerWrappers").chargeRuleWrapper.chargeCategoryListValue;

        var rollOverCmp = component.find("chargesValue");
        var rollOverValue = component.get("v.prodSerWrappers").chargeRuleWrapper.roleOverListValue;

        var chargeValueComponent = component.find("chargeName");
        var chargeValue = component.get("v.prodSerWrappers").chargeRuleWrapper.chargeValue;

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
    }
})