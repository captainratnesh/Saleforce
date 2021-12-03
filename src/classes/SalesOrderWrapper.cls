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
 * This class is a Wrapper class of SalesOrder.
 * @author Aman Jain
 */

public class SalesOrderWrapper {
  @AuraEnabled
  public string tractUrl { get; set; }
  @AuraEnabled
  public Decimal taxShow { get; set; }
  @AuraEnabled
  public Decimal taxTotalShow { get; set; }
  @AuraEnabled
  public Decimal priceShowFinal { get; set; }
  @AuraEnabled
  public String taxShow1 { get; set; }
  @AuraEnabled
  public String taxTotalShow1 { get; set; }
  @AuraEnabled
  public String priceShowFinal1 { get; set; }
  @AuraEnabled
  public List<TractSalesOrderController_LT.ProductShowWrapper> productShowWrapper {
    get;
    set;
  }
  @AuraEnabled
  public boolean checkOrder { get; set; }
}