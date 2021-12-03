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
 * This Wrapper is used to parse the API response for a one-time order item.
 * @author AMAN JAIN
 */
public with sharing class GTVOneTimeOrderItemWrapper {
  @AuraEnabled
  public string productName { get; set; }
  @AuraEnabled
  public string description { get; set; }
  @AuraEnabled
  public string orderNumber { get; set; }
  @AuraEnabled
  public string status { get; set; }
  @AuraEnabled
  public Integer quantity { get; set; }
  @AuraEnabled
  public string unitPrice { get; set; }
  @AuraEnabled
  public string totalPrice { get; set; }
  @AuraEnabled
  public Date purchaseDate { get; set; }
  @AuraEnabled
  public string id { get; set; }
  @AuraEnabled
  public string priceCategory { get; set; }
  @AuraEnabled
  public string overridden { get; set; }
  @AuraEnabled
  public list<ScheduleChargesWapper> scheduleChargeInf { get; set; }
  @AuraEnabled
  public string productDescription { get; set; }
}