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
 * This Wrapper is used to parse the API response for the order items.
 * @author AMAN JAIN
 */

public with sharing class GTVOrderItemWrapper {
  @AuraEnabled
  public boolean orderItem { get; set; }
  @AuraEnabled
  public string productName { get; set; }
  @AuraEnabled
  public boolean hasShortDescription { get; set; }
  @AuraEnabled
  public string shortDescription { get; set; }
  @AuraEnabled
  public boolean hasParentService { get; set; }
  @AuraEnabled
  public String parentServiceName { get; set; }
  @AuraEnabled
  public boolean hasServiceResource { get; set; }
  @AuraEnabled
  public list<String> listOfServiceResources { get; set; }
  @AuraEnabled
  public Integer quantity { get; set; }
  @AuraEnabled
  public String recurringPrice { get; set; }
  @AuraEnabled
  public String unitPrice { get; set; }
  @AuraEnabled
  public String orderItemUnitPrice { get; set; }
  @AuraEnabled
  public String orderItemTotalPrice { get; set; }
  @AuraEnabled
  public boolean hasAgreement { get; set; }
  @AuraEnabled
  public string agreementName { get; set; }
  @AuraEnabled
  public string agreementEndAction { get; set; }
  @AuraEnabled
  public string agreementPeriod { get; set; }
  @AuraEnabled
  public string agreementEndDate { get; set; }
}