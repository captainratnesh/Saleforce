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
 * This class is a Wrapper class of Product Charge class.
 * @author Aman Jain
 */

public class ProductChargeRuleWrapper {
  @AuraEnabled
  public list<SelectOption> selectStatusList { get; set; }
  @AuraEnabled
  public String selectStatusListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> productUsageRuleList { get; set; }
  @AuraEnabled
  public list<SelectOption> productUsageRuleList1 { get; set; }
  @AuraEnabled
  public list<SelectOption> productUsageRuleListAPi2 { get; set; }
  @AuraEnabled
  public String productUsageRuleListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> rateTypeList { get; set; }
  @AuraEnabled
  public String rateTypeListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> chargesPicklist { get; set; }
  @AuraEnabled
  public String chargesPicklistValue { get; set; }
  @AuraEnabled
  public String amountChargePickList { get; set; }
  @AuraEnabled
  public list<SelectOption> allowanceTypeList { get; set; }
  @AuraEnabled
  public String allowanceTypeListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> roleOverList { get; set; }
  @AuraEnabled
  public String roleOverListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> formulaField { get; set; }
  @AuraEnabled
  public String formulaFieldValue { get; set; }
  @AuraEnabled
  public list<SelectOption> operationList { get; set; }
  @AuraEnabled
  public list<SelectOption> operationList1 { get; set; }
  @AuraEnabled
  public list<SelectOption> operationListAPI2 { get; set; }
  @AuraEnabled
  public String operationListValue { get; set; }
  @AuraEnabled
  public list<SelectOption> passThroughChargeList { get; set; }
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
  public String productUsageRuleName { get; set; }
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
  @AuraEnabled
  public String validFrom { get; set; }
  @AuraEnabled
  public String validTo { get; set; }

  public ProductChargeRuleWrapper() {
    selectStatusList = new List<SelectOption>();
    productUsageRuleList = new List<SelectOption>();
    rateTypeList = new List<SelectOption>();
    chargesPicklist = new List<SelectOption>();
    allowanceTypeList = new List<SelectOption>();
    roleOverList = new List<SelectOption>();
    formulaField = new List<SelectOption>();
    operationList1 = new List<SelectOption>();
    operationListAPI2 = new List<SelectOption>();
    passThroughChargeList = new List<SelectOption>();
    productUsageRuleListAPI2 = new List<SelectOption>();
    productUsageRuleList1 = new List<SelectOption>();
    selectStatusList.add(new SelectOption('Draft', 'Draft'));
    selectStatusList.add(new SelectOption('Active', 'Active'));

    productUsageRuleList1.add(
      new SelectOption('Match All Events', 'Match All Events')
    );
    productUsageRuleList1.add(new SelectOption('Formula', 'Formula'));
    productUsageRuleList1.add(new SelectOption('Global', 'Global'));

    productUsageRuleListAPI2.add(
      new SelectOption('Match All Events', 'Match All Events')
    );
    productUsageRuleListAPI2.add(new SelectOption('Formula', 'Formula'));

    rateTypeList.add(new SelectOption('Flat', 'Flat'));
    rateTypeList.add(new SelectOption('Table Rate', 'Table Rate'));
    rateTypeList.add(new SelectOption('Pass Through', 'Pass Through'));

    chargesPicklist.add(new SelectOption('Choose One', 'Choose One'));
    chargesPicklist.add(new SelectOption('Millisecond', 'Millisecond'));
    chargesPicklist.add(new SelectOption('Second', 'Second'));
    chargesPicklist.add(new SelectOption('Minute', 'Minute'));
    chargesPicklist.add(new SelectOption('Hour', 'Hour'));
    chargesPicklist.add(new SelectOption('Day', 'Day'));
    chargesPicklist.add(new SelectOption('Week', 'Week'));
    chargesPicklist.add(new SelectOption('Event', 'Event'));
    chargesPicklist.add(new SelectOption('Byte', 'Byte'));
    chargesPicklist.add(new SelectOption('Kilobyte', 'Kilobyte'));
    chargesPicklist.add(new SelectOption('Megabyte', 'Megabyte'));
    chargesPicklist.add(new SelectOption('Gigabyte', 'Gigabyte'));
    chargesPicklist.add(new SelectOption('Terabyte', 'Terabyte'));
    chargesPicklist.add(new SelectOption('Count', 'Count'));
    chargesPicklist.add(new SelectOption('CURRENCY', 'Currency'));
    chargesPicklist.add(new SelectOption('BITS_PER_SECOND', 'Bits/Second'));
    chargesPicklist.add(
      new SelectOption('KILOBITS_PER_SECOND', 'Kilobits/Second')
    );
    chargesPicklist.add(
      new SelectOption('MEGABITS_PER_SECOND', 'Megabits/Second')
    );
    chargesPicklist.add(
      new SelectOption('GIGABITS_PER_SECOND', 'Gigabits/Second')
    );

    formulaField.add(new SelectOption('Choose One', 'Choose One'));
    formulaField.add(new SelectOption('text01', 'text01'));
    formulaField.add(new SelectOption('text02', 'text02'));
    formulaField.add(new SelectOption('text03', 'text03'));
    formulaField.add(new SelectOption('text04', 'text04'));
    formulaField.add(new SelectOption('text05', 'text05'));
    formulaField.add(new SelectOption('number01', 'number01'));
    formulaField.add(new SelectOption('number02', 'number02'));
    formulaField.add(new SelectOption('number03', 'number03'));
    formulaField.add(new SelectOption('number04', 'number04'));
    formulaField.add(new SelectOption('number05', 'number05'));
    formulaField.add(new SelectOption('boolean01', 'boolean01'));
    formulaField.add(new SelectOption('boolean02', 'boolean02'));
    formulaField.add(new SelectOption('boolean03', 'boolean03'));
    formulaField.add(new SelectOption('boolean04', 'boolean04'));
    formulaField.add(new SelectOption('boolean05', 'boolean05'));
    formulaField.add(new SelectOption('date01', 'date01'));
    formulaField.add(new SelectOption('date02', 'date02'));
    formulaField.add(new SelectOption('date03', 'date03'));
    formulaField.add(new SelectOption('date04', 'date04'));
    formulaField.add(new SelectOption('date05', 'date05'));

    passThroughChargeList.add(new SelectOption('Choose One', 'Choose One'));
    passThroughChargeList.add(new SelectOption('number01', 'number01'));
    passThroughChargeList.add(new SelectOption('number02', 'number02'));
    passThroughChargeList.add(new SelectOption('number03', 'number03'));
    passThroughChargeList.add(new SelectOption('number04', 'number04'));
    passThroughChargeList.add(new SelectOption('number05', 'number05'));

    operationList1.add(new SelectOption('Choose One', 'Choose One'));
    operationList1.add(new SelectOption('Equals', '='));
    operationList1.add(new SelectOption('NotEquals', '<>'));
    operationList1.add(new SelectOption('GreaterThan', '>'));
    operationList1.add(new SelectOption('GreaterThanEquals', '>='));
    operationList1.add(new SelectOption('LessThan', '<'));
    operationList1.add(new SelectOption('LessThanEquals', '<='));
    operationList1.add(new SelectOption('Lookup', 'Lookup'));

    operationListAPI2.add(new SelectOption('Choose One', 'Choose One'));
    operationListAPI2.add(new SelectOption('EQUALS', '='));
    operationListAPI2.add(new SelectOption('NOT_EQUALS', '<>'));
    operationListAPI2.add(new SelectOption('GREATER_THAN', '>'));
    operationListAPI2.add(new SelectOption('GREATER_THAN_EQUALS', '>='));
    operationListAPI2.add(new SelectOption('LESS_THAN', '<'));
    operationListAPI2.add(new SelectOption('LESS_THAN_EQUALS', '<='));
    operationListAPI2.add(new SelectOption('LOOKUP', 'Lookup'));

    allowanceTypeList.add(new SelectOption('Recurring', 'Recurring'));
    allowanceTypeList.add(new SelectOption('Unlimited', 'Unlimited'));
    allowanceTypeList.add(new SelectOption('OneTime', 'One Time'));

    roleOverList.add(new SelectOption('None', 'None'));
    roleOverList.add(new SelectOption('Uncapped', 'Uncapped'));
  }
}