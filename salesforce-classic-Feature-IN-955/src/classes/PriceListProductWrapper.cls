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
 * This Wrapper is used to carry the product information in a price list to the lightning component.
 * @author Aman Jain
 */

public with sharing class PriceListProductWrapper {
  @AuraEnabled
  public String productName;
  @AuraEnabled
  public String productEid;
  @AuraEnabled
  public String sfdcProductId;
  @AuraEnabled
  public String productType;
  @AuraEnabled
  public String productCategoryName;
}