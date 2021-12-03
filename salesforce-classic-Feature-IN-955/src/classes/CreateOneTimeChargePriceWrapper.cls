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
 * This Wrapper is used to carry the required information while creating one time prices to the lightning component.
 * @author Aman Jain
 */

public with sharing class CreateOneTimeChargePriceWrapper {
  @AuraEnabled
  public List<SelectOption> priceCategoryList { get; set; }
  @AuraEnabled
  public String priceCategory { get; set; }
  @AuraEnabled
  public Date fromDate { get; set; }
  @AuraEnabled
  public Boolean priceOverride { get; set; }
  @AuraEnabled
  public List<SelectOption> currencyList { get; set; }
  @AuraEnabled
  public String selectedcurrency { get; set; }
  @AuraEnabled
  public Boolean payOnPurchase { get; set; }
  @AuraEnabled
  public Boolean taperedPricing { get; set; }
  @AuraEnabled
  public Boolean chargeAtRenewal { get; set; }
  @AuraEnabled
  public Boolean requireScheduledCharges { get; set; }
  @AuraEnabled
  public List<SelectOption> productPriceGroupList { get; set; }
  @AuraEnabled
  public String productPriceGroup { get; set; }
  @AuraEnabled
  public List<CreatePriceRangeWrapper> createPriceRangeWrapper { get; set; }
  @AuraEnabled
  public String productId { get; set; }
  @AuraEnabled
  public String sfdcProductId { get; set; }

  public CreateOneTimeChargePriceWrapper() {
    priceOverride = true;
    payOnPurchase = false;
    chargeAtRenewal = false;
    taperedPricing = false;
    requireScheduledCharges = false;
    selectedcurrency = 'USD';
    createPriceRangeWrapper = new List<CreatePriceRangeWrapper>();
    createPriceRangeWrapper.add(new CreatePriceRangeWrapper());
  }
}