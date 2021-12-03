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
 * This Wrapper is used to parse the API response for the Product price.
 * @author AMAN JAIN
 */

public class ProductPriceWrapper {
  @AuraEnabled
  public DateTime fromDate { get; set; }
  @AuraEnabled
  public DateTime thruDate { get; set; }
  @AuraEnabled
  public Boolean priceOverride { get; set; }
  @AuraEnabled
  public String priceType { get; set; }
  @AuraEnabled
  public Boolean paymentOnPurchaseRequired { get; set; }
  @AuraEnabled
  public Boolean recurringPaymentRequired { get; set; }
  @AuraEnabled
  public String recurrencePeriod { get; set; }
  @AuraEnabled
  public String currencyType { get; set; }
  @AuraEnabled
  public Boolean scheduledCharges { get; set; }
  @AuraEnabled
  public String eid { get; set; }
  @AuraEnabled
  public Boolean hasProductEid { get; set; }
  @AuraEnabled
  public String priceListEid { get; set; }
  @AuraEnabled
  public list<ProductPriceRangeWrapper> priceRangesList { get; set; }
  @AuraEnabled
  public String priceCategory { get; set; }
  @AuraEnabled
  public String productEid { get; set; }
  @AuraEnabled
  public Boolean proratedOnOrder { get; set; }
  @AuraEnabled
  public Boolean proratedOnOrderNoCharge { get; set; }
  @AuraEnabled
  public Boolean proratedOnCancel { get; set; }
  @AuraEnabled
  public String priceGroupId { get; set; }
  @AuraEnabled
  public String priceCategoryId { get; set; }
  @AuraEnabled
  public Boolean billInAdvance { get; set; }
  @AuraEnabled
  public String billInAdvanceUnit { get; set; }
  @AuraEnabled
  public Integer billInAdvanceAmount { get; set; }
}