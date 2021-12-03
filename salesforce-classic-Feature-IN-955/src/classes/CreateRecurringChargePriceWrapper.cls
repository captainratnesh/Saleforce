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
 * This Wrapper is used to carry the required information while creating recurring prices to the lightning component.
 * @author Aman Jain
 */

public with sharing class CreateRecurringChargePriceWrapper {
  @AuraEnabled
  public List<SelectOption> priceCategoryList { get; set; }
  @AuraEnabled
  public String priceCategory { get; set; }
  @AuraEnabled
  public Date fromDate { get; set; }
  @AuraEnabled
  public List<SelectOption> billingTypeList { get; set; }
  @AuraEnabled
  public String billingType { get; set; }
  @AuraEnabled
  public Boolean proratedOnOrder { get; set; }
  @AuraEnabled
  public Boolean proratedOnOrderNoCharge { get; set; }
  @AuraEnabled
  public Boolean proratedOnCancel { get; set; }
  @AuraEnabled
  public Boolean priceOverride { get; set; }
  @AuraEnabled
  public Boolean taperedPricing { get; set; }
  @AuraEnabled
  public List<SelectOption> currencyList { get; set; }
  @AuraEnabled
  public String selectedcurrency { get; set; }
  @AuraEnabled
  public List<SelectOption> recurrencePeriodList { get; set; }
  @AuraEnabled
  public String recurrencePeriod { get; set; }
  @AuraEnabled
  public Boolean payOnPurchase { get; set; }
  @AuraEnabled
  public Boolean autoPaymentRequired { get; set; }
  @AuraEnabled
  public List<SelectOption> productPriceGroupList { get; set; }
  @AuraEnabled
  public String productPriceGroup { get; set; }
  @AuraEnabled
  public List<SelectOption> billInAdvanceUnitList { get; set; }
  @AuraEnabled
  public String billInAdvanceUnit { get; set; }
  @AuraEnabled
  public Integer billInAdvance { get; set; }
  @AuraEnabled
  public List<CreatePriceRangeWrapper> createPriceRangeWrapper { get; set; }
  @AuraEnabled
  public String productId { get; set; }
  @AuraEnabled
  public Boolean hasProductId { get; set; }
  @AuraEnabled
  public String sfdcProductId { get; set; }
  @AuraEnabled
  public String eid { get; set; }

  public CreateRecurringChargePriceWrapper() {
    priceOverride = true;
    proratedOnOrder = false;
    proratedOnOrderNoCharge = false;
    proratedOnCancel = false;
    payOnPurchase = false;
    autoPaymentRequired = false;
    taperedPricing = false;
    billingType = 'Bill In Advance';
    selectedcurrency = 'USD';
    recurrencePeriod = 'BILL_CYCLE';
    eid = null;
    createPriceRangeWrapper = new List<CreatePriceRangeWrapper>();
    createPriceRangeWrapper.add(new CreatePriceRangeWrapper());
  }
}