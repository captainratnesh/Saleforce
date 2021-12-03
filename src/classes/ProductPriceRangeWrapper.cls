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
 * This Wrapper is used to parse the API response for the Product price range.
 * @author AMAN JAIN
 */

public class ProductPriceRangeWrapper {
  @AuraEnabled
  public Decimal quantityBeginRange { get; set; }
  @AuraEnabled
  public Decimal quantityEndRange { get; set; }
  @AuraEnabled
  public Decimal price { get; set; }
  @AuraEnabled
  public Integer level { get; set; }
  @AuraEnabled
  public String currencyType { get; set; }
  @AuraEnabled
  public String eid { get; set; }
}