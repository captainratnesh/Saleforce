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
 * This class is a wrapper class
 * @author Aman Jain
 */

public class CreateChangeOrderWrapper {
  @AuraEnabled
  public List<SelectOption> compatibleProductList { get; set; }
  @AuraEnabled
  public String type { get; set; }
  @AuraEnabled
  public Map<String, List<SelectOption>> mapOfProductIdVsRecurrencePriceList {
    get;
    set;
  }
  @AuraEnabled
  public Map<String, List<SelectOption>> mapOfProductIdVsOneTimePriceList {
    get;
    set;
  }
  @AuraEnabled
  public decimal recurringprice { get; set; }
  @AuraEnabled
  public decimal oneTimePrice { get; set; }
  @AuraEnabled
  public Integer quantity { get; set; }
  @AuraEnabled
  public decimal totalPrice { get; set; }
  @AuraEnabled
  public String currentProductId { get; set; }
  @AuraEnabled
  public Map<String, boolean> mapofProductPriceEidVsPriceOverrideFlag {
    get;
    set;
  }
  @AuraEnabled
  public Map<String, boolean> mapofProductEidVsSerializedFlag { get; set; }
  @AuraEnabled
  public Boolean enableOneTime { get; set; }
  @AuraEnabled
  public Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList {
    get;
    set;
  }
  @AuraEnabled
  public String originalServiceName { get; set; }
  @AuraEnabled
  public String recurringpriceId { get; set; }
  @AuraEnabled
  public String oneTimePriceId { get; set; }
  @AuraEnabled
  public boolean emailReciept { get; set; }
  @AuraEnabled
  public String orderDate { get; set; }
  @AuraEnabled
  public boolean enablePreserveAgreement { get; set; }
  @AuraEnabled
  public String priceListId { get; set; }
  @AuraEnabled
  public String currentServiceId { get; set; }
  @AuraEnabled
  public String currencyType { get; set; }
  @AuraEnabled
  public String currentProductName { get; set; }
  @AuraEnabled
  public Map<String, Product2> mapofProductIdVsProduct { get; set; }
  @AuraEnabled
  public List<String> srIdentifierList { get; set; }
  @AuraEnabled
  public Map<String, Agreementwrapper> mapOfProductIdVsAgreementWrapper {
    get;
    set;
  }
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
  public Decimal agreementPeriod { get; set; }
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
  @AuraEnabled
  public boolean preserveAgreementPrice { get; set; }
  @AuraEnabled
  public String shortDescription { get; set; }
}