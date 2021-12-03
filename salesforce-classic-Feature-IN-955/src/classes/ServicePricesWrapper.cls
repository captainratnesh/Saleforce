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
 * This class is a wrapper class of ServicePrices.
 * @author Aman Jain
 */

public with sharing class ServicePricesWrapper {
  @AuraEnabled
  public Decimal invoiceQuantity { get; set; }
  @AuraEnabled
  public String proration { get; set; }
  @AuraEnabled
  public Date validFrom { get; set; }
  @AuraEnabled
  public String recurrence { get; set; }
  @AuraEnabled
  public String priceCategory { get; set; }
  @AuraEnabled
  public String bill { get; set; }
  @AuraEnabled
  public String price { get; set; }
  @AuraEnabled
  public String amount { get; set; }
}