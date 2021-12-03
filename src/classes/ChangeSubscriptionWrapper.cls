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
 * This Wrapper is used to carry the product information to the change subscription lightning component.
 * @author Aman Jain
 */

public with sharing class ChangeSubscriptionWrapper {
  @AuraEnabled
  public String changedServiceEid;
  @AuraEnabled
  public String subscriptionId;
  @AuraEnabled
  public List<SelectOption> newServiceList;
  @AuraEnabled
  public Map<String, List<ProductPriceRangeWrapper>> productPriceIdtoPriceRangesMap;
  @AuraEnabled
  public Map<String, List<ProductPriceWrapper>> productIdToProductPriceMap;
  @AuraEnabled
  public List<SelectOption> recurringPriceList;
  @AuraEnabled
  public Map<String, Decimal> productPriceIdToPriceValueMap;
  @AuraEnabled
  public Map<String, String> productPriceIdToEidMap;
  @AuraEnabled
  public Map<String, Decimal> mapOfAgreementPeriod;
  @AuraEnabled
  public Decimal recurringPrice;
  @AuraEnabled
  public Boolean serviceHasAgreement;
  @AuraEnabled
  public List<SelectOption> agreementList;
  @AuraEnabled
  public List<SelectOption> renewActionList;
  @AuraEnabled
  public Boolean enablePreserveAgreement;
  @AuraEnabled
  public Boolean supportsPriceOverride;
  @AuraEnabled
  public Boolean canUpdateQty;
  @AuraEnabled
  public Integer quantity;
  @AuraEnabled
  public String errorMessage;

  public ChangeSubscriptionWrapper() {
  }
}