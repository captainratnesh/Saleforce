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
 * This Wrapper is used to carry the required product price range information while creating product prices.
 * @author Aman Jain
 */

public with sharing class CreatePriceRangeWrapper {
  @AuraEnabled
  public String tier { get; set; }
  @AuraEnabled
  public Integer startingQuantity { get; set; }
  @AuraEnabled
  public Integer endingQuantity { get; set; }
  @AuraEnabled
  public Decimal price { get; set; }
  @AuraEnabled
  public String currencyType { get; set; }
  @AuraEnabled
  public String eid { get; set; }

  public CreatePriceRangeWrapper() {
    Tier = 'Tier 1';
    startingQuantity = 0;
    Price = 0.00;
  }
}