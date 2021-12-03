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
 * This Wrapper is used to carry the Activity charge rule information to the lightning component.
 * @author Aman Jain
 */

public class ChargeRulesWrapper {
  @AuraEnabled
  public list<SelectOption> selectStatusList1 { get; set; }
  @AuraEnabled
  public String selectStatusListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> productUsageRuleList1 { get; set; }
  @AuraEnabled
  public String productUsageRuleListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> rateTypeList1 { get; set; }
  @AuraEnabled
  public String rateTypeListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> chargesPicklist1 { get; set; }
  @AuraEnabled
  public String chargesPicklistValue { get; set; }
  @AuraEnabled
  public list<SelectOption> allowanceTypeList1 { get; set; }
  @AuraEnabled
  public String allowanceTypeListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> roleOverList1 { get; set; }
  @AuraEnabled
  public String roleOverListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> formulaField1 { get; set; }
  @AuraEnabled
  public String formulaFieldValue { get; set; }
  @AuraEnabled
  public list<SelectOption> operationList1 { get; set; }
  @AuraEnabled
  public String operationListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> passThroughChargeList1 { get; set; }
  @AuraEnabled
  public String passThroughChargeListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> formulaUsageRuleList { get; set; }
  @AuraEnabled
  public String formulaUsageRuleListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> chargeListBytes { get; set; }
  @AuraEnabled
  public String chargeListBytesValue { get; set; }
  @AuraEnabled
  public list<SelectOption> chargeCategoryList { get; set; }
  @AuraEnabled
  public String chargeCategoryListValue { get; set; }
  @AuraEnabled
  public String serviceUsageRuleName { get; set; }
  @AuraEnabled
  public Decimal chargeValue { get; set; }
  @AuraEnabled
  public Double ammountValue { get; set; }
  @AuraEnabled
  public String activityFormulaValue { get; set; }
  @AuraEnabled
  public Boolean prorateOnOrder { get; set; }
  @AuraEnabled
  public Boolean prorateOnCancel { get; set; }
}