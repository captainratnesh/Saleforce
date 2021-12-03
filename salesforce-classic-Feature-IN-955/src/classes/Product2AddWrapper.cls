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
 * This Wrapper is used to carry the product information added to the cart.
 * @author Aman Jain
 */

public class Product2AddWrapper {
  @AuraEnabled
  public product2 prod { get; set; }
  @AuraEnabled
  public String oppId { get; set; }
  @AuraEnabled
  public String productEid { get; set; }
  @AuraEnabled
  public String ruleType { get; set; }
  @AuraEnabled
  public Boolean priceOverridden { get; set; }
  @AuraEnabled
  public Boolean productTrial { get; set; }
  @AuraEnabled
  public Boolean productTrialOverride { get; set; }
  @AuraEnabled
  public Decimal productTrialDays { get; set; }
  @AuraEnabled
  public Decimal overridedTrialLength { get; set; }
  @AuraEnabled
  public Boolean scheduleChargeEnable { get; set; }
  @AuraEnabled
  public Boolean disableRecurring { get; set; }
  @AuraEnabled
  public Boolean oneTimeChargeEnable { get; set; }
  @AuraEnabled
  public Boolean disableonetime { get; set; }
  @AuraEnabled
  public decimal recurringprice { get; set; }
  @AuraEnabled
  public decimal oneTimePrice { get; set; }
  @AuraEnabled
  public decimal maxServiceResource { get; set; }
  @AuraEnabled
  public decimal minServiceResource { get; set; }
  @AuraEnabled
  public boolean ruleOverride { get; set; }
  @AuraEnabled
  public boolean serviceCustomFieldEnable { get; set; }
  @AuraEnabled
  public Integer quantity { get; set; }
  @AuraEnabled
  public map<String, decimal> idAndPriceValueMap { get; set; }
  @AuraEnabled
  public map<String, String> idAndEidMapOneTime { get; set; }
  @AuraEnabled
  public map<String, String> idAndEidMap { get; set; }
  @AuraEnabled
  public List<SelectOption> productPriceList { get; set; }
  @AuraEnabled
  public String priceListValue { get; set; }
  @AuraEnabled
  public String priceListValue1 { get; set; }
  @AuraEnabled
  public List<SelectOption> recurrenceoptList { get; set; }
  @AuraEnabled
  public String recurrencPer { get; set; }
  @AuraEnabled
  public String recurrencPerValue { get; set; }
  @AuraEnabled
  public String oneTimePerValue { get; set; }
  @AuraEnabled
  public String discountName { get; set; }
  @AuraEnabled
  public String discountEid { get; set; }
  @AuraEnabled
  public String newServiceResource { get; set; }
  @AuraEnabled
  public String serviceResourceName { get; set; }
  @AuraEnabled
  public String serviceResourceEid { get; set; }
  @AuraEnabled
  public String errorMessage { get; set; }
  @AuraEnabled
  public String oliId { get; set; }
  @AuraEnabled
  public List<String> pricebookNames { get; set; }
  @AuraEnabled
  public opportunityLineItem oLineItem { get; set; }
  @AuraEnabled
  public String agreementEndAction { get; set; }
  @AuraEnabled
  public Date overrideAgreementEndDate { get; set; }
  @AuraEnabled
  public String agreementId { get; set; }
  @AuraEnabled
  public String agreementName { get; set; }
  @AuraEnabled
  public String agreementPeriodType { get; set; }
  @AuraEnabled
  public String service { get; set; }
  @AuraEnabled
  public String serviceName { get; set; }
  @AuraEnabled
  public String parentServiceEId { get; set; }
  @AuraEnabled
  public Decimal agreementPeriod { get; set; }
  @AuraEnabled
  public List<ScheduleChargeWrapper> scheduleChargeList { get; set; }
  @AuraEnabled
  public List<ServiceCustomFieldValuesWrapper> serviceCustomFieldValueList {
    get;
    set;
  }
  @AuraEnabled
  public List<Product2AddWrapper> childProducts { get; set; }
  @AuraEnabled
  public Agreementwrapper agreements { get; set; }
  @AuraEnabled
  public Boolean serialized { get; set; }
  @AuraEnabled
  public decimal totelPrice { get; set; }
  @AuraEnabled
  public decimal unitPrice { get; set; }
  @AuraEnabled
  public map<String, List<ProductPriceRangeWrapper>> priceVsPriceRanges {
    get;
    set;
  }
  @AuraEnabled
  public decimal priceRangeValue { get; set; }
  @AuraEnabled
  public String totelPriceValue { get; set; }
  @AuraEnabled
  public boolean existing { get; set; }
  @AuraEnabled
  public String serviceEid { get; set; }
  @AuraEnabled
  public List<ProductUsesWrapper> usageWrapList { get; set; }
  @AuraEnabled
  public Map<String, boolean> mapofProductPriceEidVsPriceOverrideFlag {
    get;
    set;
  }
  @AuraEnabled
  public String priceListName { get; set; }
  @AuraEnabled
  public boolean enabledAgreementConfiguration { get; set; }
  @AuraEnabled
  public boolean hasServiceCustomFields { get; set; }
  @AuraEnabled
  public String nextAgreementId { get; set; }
  @AuraEnabled
  public String nextAgreementEndAction { get; set; }
  @AuraEnabled
  public String nextAgreementName { get; set; }
  @AuraEnabled
  public String renewalPrice { get; set; }
  @AuraEnabled
  public String nextRenewalPrice { get; set; }

  public Product2AddWrapper() {
    priceListValue = ' ';
    priceListValue1 = ' ';
    recurrencPer = ' ';
    newServiceResource = '';
    serviceResourceName = '';
    serviceResourceEid = '';
    recurrencPerValue = ' ';
    oliId = ' ';
    parentServiceEId = ' ';
    priceOverridden = false;
    hasServiceCustomFields = false;
    quantity = 1;
    oLineItem = new opportunityLineItem();
    idAndPriceValueMap = new Map<String, decimal>();
    idAndEidMapOneTime = new Map<String, string>();
    idAndEidMap = new Map<String, string>();
    scheduleChargeList = new List<ScheduleChargeWrapper>();
    serviceCustomFieldValueList = new List<ServiceCustomFieldValuesWrapper>();
    totelPriceValue = '0.00';
    totelPrice = 0;
    existing = false;
    mapofProductPriceEidVsPriceOverrideFlag = new Map<String, boolean>();
    disableonetime = false;
    disableRecurring = false;
    enabledAgreementConfiguration = false;
  }
}