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
 * This Wrapper is used to parse the API response for Discount code.
 * @author Aman Jain
 */

public with sharing class DiscountCodeWrapper {
  @AuraEnabled
  public String name { get; set; }
  @AuraEnabled
  public String code { get; set; }
  @AuraEnabled
  public String type { get; set; }
  @AuraEnabled
  public String status { get; set; }
  @AuraEnabled
  public String description { get; set; }
  @AuraEnabled
  public String chargeCategory { get; set; }
  @AuraEnabled
  public String availableFrom { get; set; }
  @AuraEnabled
  public String discount { get; set; }
  @AuraEnabled
  public String amount { get; set; }
  @AuraEnabled
  public Integer duration { get; set; }
  @AuraEnabled
  public Date validFrom { get; set; }
  @AuraEnabled
  public Date validTo { get; set; }
}