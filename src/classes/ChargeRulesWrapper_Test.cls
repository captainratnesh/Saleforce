/**
 * Unpublished Work. Copyright 2009-2018 Transverse, LLC. All Rights Reserved.
 * This software contains confidential and trade secret information of:
 * Transverse, LLC.
 * 620 Congress Ave.
 * Suite 200
 * Austin, TX 78701
 * USA
 * Use, duplication or disclosure of this software is prohibited
 * without prior written permission of Transverse, LLC.
 */

/**
 * This class is a test class of ChargeRulesWrapper class.
 * @author Aman Jain
 */

@istest
public with sharing class ChargeRulesWrapper_Test {
  @istest
  public static void unitTest() {
    ChargeRulesWrapper crw = new ChargeRulesWrapper();
    crw.selectStatusList1 = new List<SelectOption>();
    crw.selectStatusListValue = '';
    crw.productUsageRuleList1 = new List<SelectOption>();
    crw.productUsageRuleListValue = '';
    crw.rateTypeList1 = new List<SelectOption>();
    crw.rateTypeListValue = '';
    crw.chargesPicklist1 = new List<SelectOption>();
    crw.chargesPicklistValue = '';
    crw.allowanceTypeList1 = new List<SelectOption>();
    crw.allowanceTypeListValue = '';
    crw.roleOverList1 = new List<SelectOption>();
    crw.roleOverListValue = '';
    crw.formulaField1 = new List<SelectOption>();
    crw.formulaFieldValue = '';
    crw.operationList1 = new List<SelectOption>();
    crw.operationListValue = '';
    crw.passThroughChargeList1 = new List<SelectOption>();
    crw.passThroughChargeListValue = '';
    crw.formulaUsageRuleList = new List<SelectOption>();
    crw.formulaUsageRuleListValue = '';
    crw.chargeListBytes = new List<SelectOption>();
    crw.chargeListBytesValue = '';
    crw.chargeCategoryList = new List<SelectOption>();
    crw.chargeCategoryListValue = '';
    crw.ServiceUsageRuleName = '';
    crw.ammountValue = 0.0;
    crw.chargeValue = 0.0;
    crw.ActivityFormulaValue = '';
    crw.prorateOnOrder = true;
    crw.prorateOnCancel = true;
    System.assertNotEquals(crw, null);
  }
}