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
 * This Wrapper is used to carry the order information to the Order Detail lightning component.
 * @author AMAN JAIN
 */

public with sharing class GTVSalesOrderDetailWrapper {
  @AuraEnabled
  public List<GTVOrderItemWrapper> listOfOrderItems { get; set; }
  @AuraEnabled
  public String taxAmount { get; set; }
  @AuraEnabled
  public String orderAmount { get; set; }
  @AuraEnabled
  public String totalOrderAmountWithTaxes { get; set; }
  @AuraEnabled
  public boolean checkOrder { get; set; }
  @AuraEnabled
  public string tractUrl { get; set; }
}