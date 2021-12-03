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
 * This Wrapper is used to parse the API response for the Product relation.
 * @author AMAN JAIN
 */

public with sharing class ProductRelationWrapper {
  @AuraEnabled
  public String productName { get; set; }
  @AuraEnabled
  public String relatedfProductEid { get; set; }
  @AuraEnabled
  public String relationShipType { get; set; }
  @AuraEnabled
  public String scope { get; set; }
  @AuraEnabled
  public String productRelationShipEid { get; set; }
}